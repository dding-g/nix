{ config, lib, ... }:

let
  cfg = config.custom.paperReview;
  paperReviewDir = "${config.home.homeDirectory}/.local/share/paper-review";
in
{
  options.custom.paperReview = {
    enable = lib.mkEnableOption "Paper Review Automation (Gemini CLI 기반 논문 자동 리뷰)";
  };

  config = lib.mkIf cfg.enable {
    # config.env
    home.file.".local/share/paper-review/config.env".text = ''
      # Paper Review Configuration
      # =========================

      # iCloud 논문 경로 (필요시 수정)
      PAPERS_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Papers"

      # 리뷰 조건
      DAYS_TO_CHECK=7        # 최근 N일 내 추가된 파일만 처리
      MAX_PAPERS_PER_RUN=5   # 한 번에 처리할 최대 논문 수

      # Gemini 설정
      # gemini-2.5-pro: 더 정확한 분석
      # gemini-2.5-flash: 더 빠른 처리
      GEMINI_MODEL="gemini-2.5-pro"

      # Rate limit 방지 (초)
      SLEEP_BETWEEN_PAPERS=30

      # macOS 알림
      ENABLE_NOTIFICATION=true
    '';

    # templates/review-prompt.md
    home.file.".local/share/paper-review/templates/review-prompt.md".text = ''
      당신은 ML/AI 분야의 시니어 연구자입니다. 이 논문을 다음 구조로 리뷰해주세요.

      ## 1. 핵심 요약 (3문장)
      - 이 논문이 해결하려는 문제
      - 제안하는 방법의 핵심 아이디어
      - 주요 결과/기여

      ## 2. 기술적 분석

      ### 방법론
      - 핵심 알고리즘/아키텍처
      - 기존 방법과의 차이점
      - 주요 가정과 한계

      ### 실험
      - 데이터셋과 평가 지표
      - 베이스라인 비교
      - Ablation study 결과 (있다면)

      ## 3. 비판적 평가
      - 강점 (2-3가지)
      - 약점/한계 (2-3가지)
      - 재현 가능성 평가

      ## 4. 실무 적용 가능성
      - 프로덕션 환경에 적용할 때 고려사항
      - 필요한 리소스 (데이터, 컴퓨팅)
      - 예상되는 도전 과제

      ## 5. 관련 연구 & 후속 읽을거리
      - 이 논문을 이해하기 위해 먼저 읽어야 할 논문 (2-3개)
      - 이 논문의 후속/관련 연구 (2-3개)

      ## 6. 한줄 평가
      [점수: ?/10] - 한 문장으로 이 논문의 가치 요약
    '';

    # review-papers.sh
    home.file.".local/share/paper-review/review-papers.sh" = {
      executable = true;
      text = ''
        #!/bin/bash
        # =============================================================================
        # Paper Review Automation Script (Agent Workflow)
        # AGENT.md 가이드라인에 따라 Inbox의 논문을 리뷰하고 정리
        # Gemini CLI를 사용하여 PDF를 직접 분석
        # =============================================================================

        set -euo pipefail

        # 스크립트 디렉토리
        SCRIPT_DIR="${paperReviewDir}"

        # =============================================================================
        # 1. 경로 및 설정
        # =============================================================================

        # 환경 변수 로드 (~/.zshrc.local 등)
        if [[ -f "$HOME/.zshrc.local" ]]; then
            set +u  # 잠시 unbound variable check 해제 (zshrc 내부 변수 문제 방지)
            source "$HOME/.zshrc.local"
            set -u
        fi

        # Obsidian 논문리뷰 루트 경로 (사용자 환경)
        BASE_DIR="/Users/ddingg/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-ddingg/논문리뷰"

        # 주요 디렉토리 및 파일 경로
        INBOX_DIR="$BASE_DIR/inbox"
        AGENT_FILE="$BASE_DIR/AGENT.md"
        LOG_DIR="$SCRIPT_DIR/logs"

        # 설정 파일 로드 (옵션: API 키 등 환경변수)
        if [[ -f "$SCRIPT_DIR/config.env" ]]; then
            source "$SCRIPT_DIR/config.env"
        fi

        # 로그 디렉토리 생성
        mkdir -p "$LOG_DIR"
        LOG_FILE="$LOG_DIR/$(date +%Y-%m-%d).log"
        exec > >(tee -a "$LOG_FILE") 2>&1

        echo ""
        echo "=============================================="
        echo "Paper Review Agent Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "=============================================="

        # -----------------------------------------------------------------------------
        # 사전 검사
        # -----------------------------------------------------------------------------

        # 1. Gemini CLI 확인
        if ! command -v gemini &> /dev/null; then
            echo "Error: gemini CLI not found."
            echo "Please install: npm install -g @anthropic-ai/gemini-cli"
            exit 1
        fi

        # 2. 필수 경로 확인
        if [[ ! -d "$INBOX_DIR" ]]; then
            echo "Error: Inbox directory not found at $INBOX_DIR"
            exit 1
        fi

        if [[ ! -f "$AGENT_FILE" ]]; then
            echo "Error: AGENT.md not found at $AGENT_FILE"
            exit 1
        fi

        # -----------------------------------------------------------------------------
        # 프롬프트 준비
        # -----------------------------------------------------------------------------
        PROMPT_FILE="$SCRIPT_DIR/temp_prompt.txt"

        cat "$AGENT_FILE" > "$PROMPT_FILE"
        cat >> "$PROMPT_FILE" <<'INSTRUCTION'

        --------------------------------------------------------------------------------
        [SYSTEM INSTRUCTION]
        You are an intelligent research assistant designed to follow the workflow described above.
        1. Read the provided PDF paper carefully.
        2. Generate a review report in Markdown format strictly following the '[표준 리뷰 프롬프트]' section in the text above.
        3. Ensure the Frontmatter (YAML) is correctly formatted.
        4. Output ONLY the markdown content. Do not wrap the output in code blocks.
        INSTRUCTION

        # =============================================================================
        # 2. 논문 처리 루프
        # =============================================================================

        GOOD_RATING_DIR="$BASE_DIR/good-rating"
        ARCHIVE_DIR="$BASE_DIR/archive"
        mkdir -p "$GOOD_RATING_DIR" "$ARCHIVE_DIR"

        processed_count=0
        error_count=0
        processed_list="" # Slack 알림용 목록

        echo "Scanning Inbox: $INBOX_DIR"

        # Inbox 내의 모든 PDF 파일 검색 (process substitution으로 서브셸 문제 방지)
        while read -r paper_path; do
            paper_filename=$(basename "$paper_path")
            paper_title="''${paper_filename%.*}"

            # iCloud 동기화 대기 (evicted 파일 대응)
            if [[ -f "$paper_path.icloud" ]] || [[ ! -s "$paper_path" ]]; then
                echo "Downloading from iCloud: $paper_filename"
                brctl download "$paper_path" 2>/dev/null || true
                sleep 3
            fi

            # 파일 유효성 재확인
            if [[ ! -f "$paper_path" ]] || [[ ! -s "$paper_path" ]]; then
                echo "Skipping (Empty or not found): $paper_filename"
                continue
            fi

            echo "--------------------------------------------------"
            echo "Processing: $paper_title"

            # 임시 결과 파일
            temp_output="$SCRIPT_DIR/temp_review.md"

            # Gemini CLI로 PDF + 프롬프트 전달
            echo "  > Running Gemini CLI..."
            gemini_stderr="$SCRIPT_DIR/temp_gemini_stderr.log"
            if ! gemini -m gemini-2.5-pro --sandbox \
                --include-directories "$INBOX_DIR" \
                -o text \
                "$(cat "$PROMPT_FILE")" \
                "$paper_path" \
                > "$temp_output" 2>"$gemini_stderr"; then
                echo "  ✗ Failed to process: $paper_filename (kept in inbox)"
                echo "  > Gemini stderr:"
                cat "$gemini_stderr" | sed 's/^/    /'
                ((error_count++)) || true
                continue
            fi
            # 성공 시에도 stderr 출력 (경고 등 확인용)
            if [[ -s "$gemini_stderr" ]]; then
                echo "  > Gemini stderr:"
                cat "$gemini_stderr" | sed 's/^/    /'
            fi

            # 결과 파일 검증 (비어있으면 실패 처리)
            if [[ ! -s "$temp_output" ]]; then
                 echo "  ✗ Failed: Output is empty. (kept in inbox)"
                 ((error_count++)) || true
                 continue
            fi

            # 논문 제목 추출 (frontmatter title 필드)
            # title: "Some Paper Title" → Some_Paper_Title
            raw_title=$(grep "^title:" "$temp_output" | head -n 1 | sed 's/^title:[[:space:]]*//' | tr -d '"')
            if [[ -n "$raw_title" ]]; then
                # 폴더명으로 사용 가능하도록 변환: 공백→_, 특수문자 제거
                folder_name=$(echo "$raw_title" | sed 's/[[:space:]]\+/_/g; s/[^A-Za-z0-9_-]//g; s/__*/_/g; s/^_//; s/_$//')
                echo "  > Title: $raw_title"
            else
                # title 추출 실패 시 PDF 파일명 사용
                folder_name="$paper_title"
                echo "  > Title extraction failed, using filename: $folder_name"
            fi

            # Rating 추출하여 직접 분류
            rating=$(grep "^rating:" "$temp_output" | head -n 1 | awk '{print $2}' | tr -d " '\"")
            if ! [[ "$rating" =~ ^[0-9]+$ ]]; then
                rating=0
            fi

            if [[ "$rating" -ge 4 ]]; then
                dest_base="$GOOD_RATING_DIR"
                echo "  ⭐ Rating: $rating → good-rating"
            else
                dest_base="$ARCHIVE_DIR"
                echo "  🗄️  Rating: $rating → archive"
            fi

            # 대상 폴더 생성
            target_dir="$dest_base/$folder_name"
            if [[ -d "$target_dir" ]]; then
                echo "  ! Target directory exists. Using timestamp to avoid conflict."
                target_dir="''${target_dir}_$(date +%H%M%S)"
            fi
            mkdir -p "$target_dir"

            # 리뷰 파일 저장 + 원본 PDF 이동
            mv "$temp_output" "$target_dir/$folder_name.md"
            mv "$paper_path" "$target_dir/$paper_filename"

            echo "  ✓ Success! Moved to: $target_dir"
            ((processed_count++)) || true
            processed_list+="- $paper_title\n"

            # Rate Limit 방지용 대기
            sleep 5
        done < <(find "$INBOX_DIR" -name "*.pdf" -type f -maxdepth 1)

        # 임시 파일 정리
        rm -f "$PROMPT_FILE" "$SCRIPT_DIR/temp_review.md" "$SCRIPT_DIR/temp_gemini_stderr.log"

        # =============================================================================
        # 3. 마무리 및 알림
        # =============================================================================

        echo ""
        echo "=============================================="
        echo "Summary"
        echo "  - Processed: $processed_count"
        echo "  - Errors: $error_count"
        echo "=============================================="

        # 알림 메시지 구성
        if [[ "$processed_count" -gt 0 ]]; then
            # macOS 알림
            osascript -e "display notification \"$processed_count papers reviewed & organized\" with title \"📚 Paper Agent\""

            # Slack 알림
            if [[ -n "''${SLACK_WEBHOOK_URL:-}" ]]; then
                echo "Sending Slack notification..."

                SLACK_TEXT="📚 *Paper Review Completed*\n\n✅ *Processed:* $processed_count papers\n\n📝 *Review List:*\n$processed_list"

                if command -v jq &> /dev/null; then
                    JSON_PAYLOAD=$(jq -n --arg text "$SLACK_TEXT" '{text: $text}')
                else
                    ESCAPED_TEXT=$(echo "$SLACK_TEXT" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
                    JSON_PAYLOAD="{\"text\": \"$ESCAPED_TEXT\"}"
                fi

                curl -s -X POST -H 'Content-type: application/json' --data "$JSON_PAYLOAD" "$SLACK_WEBHOOK_URL"
                echo "Slack notification sent."
            else
                echo "Warning: SLACK_WEBHOOK_URL is not set. Skipping Slack notification."
            fi
        fi
      '';
    };

    # LaunchAgent: 매일 오전 7시 실행
    launchd.agents.paper-review = {
      enable = true;
      config = {
        Label = "com.myunggeun.paper-review";
        ProgramArguments = [
          "/bin/bash"
          "-l"
          "-c"
          "${paperReviewDir}/review-papers.sh"
        ];
        StartCalendarInterval = [
          {
            Hour = 7;
            Minute = 0;
          }
        ];
        StandardOutPath = "/tmp/paper-review.stdout.log";
        StandardErrorPath = "/tmp/paper-review.stderr.log";
        EnvironmentVariables = {
          PATH = "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.nix-profile/bin";
          HOME = config.home.homeDirectory;
        };
        LowPriorityIO = true;
        Nice = 10;
      };
    };
  };
}

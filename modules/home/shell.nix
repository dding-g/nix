{ ... }:

{
  # ═══════════════════════════════════════════════════════════
  # Zsh
  # ═══════════════════════════════════════════════════════════
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    # ─────────────────────────────────────────
    # 히스토리 설정
    # ─────────────────────────────────────────
    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      share = true;  # 터미널 간 히스토리 공유
    };

    shellAliases = {
      # ─────────────────────────────────────────
      # 기본 명령어 대체
      # ─────────────────────────────────────────
      ls = "eza";
      ll = "eza -la";
      la = "eza -a";
      lt = "eza --tree";
      l = "eza -l";
      cat = "bat";
      grep = "rg";
      find = "fd";

      # ─────────────────────────────────────────
      # Git
      # ─────────────────────────────────────────
      g = "git";
      gs = "git status";
      gp = "git push";
      gph = "git push origin HEAD";
      gl = "git pull";
      gco = "git checkout";
      gcm = "git commit -m";
      gd = "git diff";
      ga = "git add";
      gaa = "git add -A";
      gcb = "git checkout -b";
      lg = "lazygit";

      # ─────────────────────────────────────────
      # Git Flow
      # ─────────────────────────────────────────
      gfi = "git flow init";
      gffs = "git flow feature start";
      gfff = "git flow feature finish";
      gffp = "git flow feature publish";
      gfft = "git flow feature track";
      gfrs = "git flow release start";
      gfrf = "git flow release finish";
      gfhs = "git flow hotfix start";
      gfhf = "git flow hotfix finish";

      # ─────────────────────────────────────────
      # Nix
      # ─────────────────────────────────────────
      rebuild = "darwin-rebuild switch --flake ~/.config/nix-darwin";
      nix-clean = "nix-collect-garbage -d";
      nix-update = "nix flake update";

      # ─────────────────────────────────────────
      # 개발
      # ─────────────────────────────────────────
      pn = "pnpm";
      claude-yolo = "claude --dangerously-skip-permissions";

      # ─────────────────────────────────────────
      # 디렉토리 이동
      # ─────────────────────────────────────────
      dev = "cd ~/Developer";
      dl = "cd ~/Downloads";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # ─────────────────────────────────────────
      # 시스템 / 유틸리티
      # ─────────────────────────────────────────
      top = "btop";          # 시스템 모니터
      du = "dust";           # 디스크 사용량
      df = "duf";            # 디스크 여유 공간
      ps = "procs";          # 프로세스 목록

      # IP 주소 확인
      myip = "curl -s ifconfig.me";
      localip = "ipconfig getifaddr en0";

      # 빠른 서버
      serve = "python3 -m http.server 8000";

      # 클립보드
      copy = "pbcopy";
      paste = "pbpaste";

      # 자주 쓰는 명령
      c = "clear";
      q = "exit";
      h = "history";
      path = "echo $PATH | tr ':' '\\n'";
    };

    initContent = ''
      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # pnpm
      export PNPM_HOME="$HOME/Library/pnpm"
      export PATH="$PNPM_HOME:$PATH"

      # brew app
      export PATH="$HOME/.local/bin:$PATH"

      # Java (Homebrew Temurin)
      export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"

      # Editor
      export EDITOR=zed
      export LAUNCH_EDITOR=zed

      # Terminal
      export TERMINAL=Ghostty

      # ─────────────────────────────────────────
      # 커스텀 함수
      # ─────────────────────────────────────────
      # 디렉토리 만들고 이동
      mkcd() { mkdir -p "$1" && cd "$1" }

      # 포트 사용 프로세스 확인
      port() { lsof -i :"$1" }

      # 빠른 파일 검색 + 미리보기
      ff() { fzf --preview "bat --color=always {}" }

      # ─────────────────────────────────────────
      # 로컬 환경변수 (git에 포함되지 않음)
      # ─────────────────────────────────────────
      [ -f ~/.zshrc.local ] && source ~/.zshrc.local
    '';
  };
}

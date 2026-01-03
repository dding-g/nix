# 개발 도구

개발 작업을 도와주는 유틸리티들입니다.

## jq (JSON 처리)

커맨드라인 JSON 프로세서.

```bash
# 기본 사용
cat data.json | jq '.'              # 예쁘게 출력
echo '{"a":1}' | jq '.'             # 인라인 JSON

# 필드 접근
jq '.name' data.json                 # name 필드
jq '.users[0]' data.json             # 첫 번째 user
jq '.users[].name' data.json         # 모든 user의 name

# 필터링
jq '.users[] | select(.age > 20)' data.json
jq '.items | map(select(.active))' data.json

# 변환
jq '{name: .title, id: .id}' data.json
jq '.users | length' data.json       # 배열 길이
jq 'keys' data.json                  # 키 목록

# API 응답 처리
curl -s api.com/users | jq '.[0].name'
curl -s api.com/data | jq -r '.token'  # raw 출력 (따옴표 없이)

# 파일로 저장
jq '.users' data.json > users.json
```

## yq (YAML 처리)

jq와 비슷한 YAML 프로세서.

```bash
# 기본 사용
yq '.' config.yaml                   # 예쁘게 출력
yq '.services' docker-compose.yml    # 필드 접근

# 수정
yq '.version = "2.0"' config.yaml    # 값 변경
yq '.new_field = "value"' config.yaml # 필드 추가
yq 'del(.old_field)' config.yaml     # 필드 삭제

# in-place 수정
yq -i '.version = "2.0"' config.yaml

# YAML <-> JSON 변환
yq -o json config.yaml               # YAML → JSON
yq -P data.json                      # JSON → YAML
```

## httpie (curl 대체)

사용자 친화적인 HTTP 클라이언트.

```bash
# GET 요청
http httpbin.org/get                 # 기본 GET
http httpbin.org/get name==value     # 쿼리 파라미터

# POST 요청
http POST httpbin.org/post name=John age:=25
# name=John  → 문자열
# age:=25    → 숫자 (JSON)

# 헤더
http httpbin.org/get Authorization:"Bearer token"
http httpbin.org/get User-Agent:MyApp

# JSON 바디
http POST api.com/users <<< '{"name": "John"}'
echo '{"name": "John"}' | http POST api.com/users

# 파일 업로드
http POST api.com/upload file@./image.png

# 다운로드
http --download example.com/file.zip

# 인증
http -a user:pass api.com/protected
http --auth-type bearer --auth token api.com/protected

# 세션 (쿠키 유지)
http --session=mysession POST api.com/login user=admin
http --session=mysession GET api.com/dashboard
```

## tldr (man 대체)

간단한 명령어 예제 모음.

```bash
# 사용법
tldr tar                 # tar 사용 예제
tldr git-rebase          # git rebase 예제
tldr docker-compose      # docker-compose 예제

# 업데이트
tldr --update            # 캐시 업데이트

# 플랫폼별
tldr -p osx diskutil     # macOS 전용 명령어
tldr -p linux systemctl  # Linux 전용 명령어
```

## direnv (디렉토리별 환경변수)

디렉토리에 들어가면 자동으로 환경변수 로드.

```bash
# 프로젝트에 .envrc 파일 생성
echo 'export API_KEY=secret123' > .envrc
echo 'export NODE_ENV=development' >> .envrc

# 승인 (최초 1회)
direnv allow

# 이후 해당 디렉토리 진입 시 자동 로드
cd my-project            # 환경변수 자동 설정
cd ..                    # 환경변수 자동 해제

# Nix와 함께 (use_flake)
# .envrc 내용:
# use flake

# 일반적인 .envrc 패턴
# export DATABASE_URL=...
# export AWS_PROFILE=myprofile
# PATH_add ./bin
# layout node
```

## zoxide (스마트 cd)

자주 가는 디렉토리를 기억하는 스마트 cd.

```bash
# 기본 사용
z project                # 'project' 포함 디렉토리로 이동
z proj                   # 부분 매칭도 가능
z dev nix                # 여러 키워드 조합

# 인터랙티브 선택
zi                       # fzf로 디렉토리 선택

# 데이터베이스 관리
zoxide query             # 저장된 경로 목록
zoxide query project     # 특정 패턴 검색
zoxide remove /old/path  # 경로 제거
```

## Neovim

모던 Vim. 별도 설정 권장.

```bash
# 실행
nvim file.txt            # 파일 열기
nvim .                   # 현재 디렉토리

# 기본 Vim 명령
# i        입력 모드
# ESC      일반 모드
# :w       저장
# :q       종료
# :wq      저장 후 종료
# /pattern 검색
# n/N      다음/이전 검색 결과

# 추천 설정: LazyVim, NvChad, AstroNvim
```

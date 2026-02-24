# Shell & Terminal 설정

Zsh 쉘과 터미널 관련 설정들입니다.

## Starship (프롬프트)

빠르고 커스터마이징 가능한 프롬프트.

```bash
# 자동 설정됨 - 별도 명령 필요 없음

# 현재 프롬프트 구성:
# [디렉토리] [git 브랜치] [git 상태]    [명령 실행시간]
# ❯                                    [node] [python] [aws]

# 프롬프트 심볼
# ❯     성공 (초록)
# ❯     실패 (빨강)
# ❮     Vim 모드

# Git 상태 심볼
#       브랜치
# ⇡n    n개 커밋 ahead
# ⇣n    n개 커밋 behind
# ?n    n개 untracked
# !n    n개 modified
# +n    n개 staged
# ✘n    n개 deleted

# 설정 파일 위치 (Nix가 관리)
# ~/.config/starship.toml
```

## Zsh 기능

### Auto-suggestions
```bash
# 입력하면 회색으로 이전 명령어 제안
# → (오른쪽 화살표)로 수락
# Ctrl+→ 단어 단위 수락
```

### Syntax Highlighting
```bash
# 올바른 명령: 초록색
# 잘못된 명령: 빨간색
# 경로: 밑줄
```

### 히스토리
```bash
# 설정
# - 50,000개 저장
# - 중복 무시
# - 공백으로 시작하면 저장 안 함
# - 터미널 간 공유

# 검색
Ctrl+R               # 히스토리 검색 (fzf)
history              # 최근 명령어 (또는 h)
```

## 유용한 Shell Alias

### 기본 명령어 대체
```bash
ls       # eza
ll       # eza -la
la       # eza -a
lt       # eza --tree
cat      # bat
grep     # rg
find     # fd
top      # btop
du       # dust
df       # duf
ps       # procs
```

### 디렉토리 이동
```bash
..       # cd ..
...      # cd ../..
....     # cd ../../..
dev      # cd ~/Developer
dl       # cd ~/Downloads
z <kw>   # zoxide (스마트 cd)
```

### Git 단축키
```bash
g        # git
gs       # git status
gp       # git push
gl       # git pull
gco      # git checkout
gcm      # git commit -m
gd       # git diff
ga       # git add
gaa      # git add -A
gcb      # git checkout -b
lg       # lazygit
```

### Nix 관리
```bash
rebuild      # darwin-rebuild switch --flake ~/.config/nix-darwin
nix-clean    # nix-collect-garbage -d
nix-update   # nix flake update
```

### 개발
```bash
pn           # pnpm
serve        # python3 -m http.server 8000
claude-yolo  # claude --dangerously-skip-permissions
cx           # codex
cxy          # codex --dangerously-bypass-approvals-and-sandbox
codex-yolo   # codex --dangerously-bypass-approvals-and-sandbox
```

### 유틸리티
```bash
c            # clear
q            # exit
h            # history
copy         # pbcopy (클립보드로 복사)
paste        # pbpaste (클립보드에서 붙여넣기)
myip         # 외부 IP 확인
localip      # 로컬 IP 확인
path         # $PATH를 줄별로 출력
```

## 커스텀 함수

```bash
# 디렉토리 만들고 이동
mkcd my-folder

# 포트 사용 프로세스 확인
port 3000

# 파일 검색 + 미리보기
ff
```

## tmux

터미널 멀티플렉서. 세션/윈도우/패인을 관리합니다.

### Prefix 키

모든 tmux 단축키는 **prefix** 키를 먼저 누른 뒤 사용합니다.

```
Prefix = Ctrl+Space
```

### 세션 관리
```
prefix d          세션에서 분리 (detach)
prefix s          세션 목록
prefix $          세션 이름 변경
```

### 윈도우
```
prefix c          새 윈도우 (현재 경로 유지)
prefix ,          윈도우 이름 변경
prefix n          다음 윈도우
prefix p          이전 윈도우
prefix 1-9        윈도우 번호로 이동
prefix &          윈도우 닫기
```

### 패인 분할/이동
```
prefix |          세로 분할
prefix -          가로 분할
prefix h/j/k/l   패인 이동 (vim 스타일)
prefix H/J/K/L   패인 크기 조정 (5칸씩)
prefix x          패인 닫기
prefix z          패인 전체화면 토글
```

### 복사 모드 (vi)
```
prefix [          복사 모드 진입
v                 선택 시작
y                 복사 (시스템 클립보드)
q                 복사 모드 종료
```

### 기타
```
prefix r          설정 리로드
prefix I          플러그인 설치 (TPM)
```

### 상태바

화면 상단에 표시됩니다.

```
좌측: 세션 이름
우측: 디렉토리 | 배터리 | CPU | 날짜/시간
테마: Catppuccin Mocha
```

### 플러그인
- **sensible**: 합리적 기본 설정
- **yank**: 시스템 클립보드 복사
- **resurrect**: 세션 저장/복원 (`prefix Ctrl+s` 저장, `prefix Ctrl+r` 복원)
- **continuum**: 자동 저장 (10분 간격) + tmux 시작 시 자동 복원
- **battery**: 배터리 상태 표시
- **cpu**: CPU 사용률 표시
- **catppuccin**: 테마

## Ghostty 터미널

### 현재 설정
- 폰트: JetBrainsMono Nerd Font (14pt)
- 테마: Catppuccin Mocha
- 배경: 반투명 (92%) + 블러
- Option 키: Alt로 사용

### 단축키
```
Cmd+T        새 탭
Cmd+W        탭 닫기
Cmd+1-9      탭 전환
Cmd+D        세로 분할
Cmd+Shift+D  가로 분할
Cmd+[/]      패널 전환
Cmd+K        화면 클리어
Cmd+,        설정
```

## 팁

### 클립보드 활용
```bash
# 명령 출력을 클립보드로
pwd | copy
cat file.txt | copy

# 클립보드 내용 사용
paste > file.txt
echo $(paste)
```

### 빠른 편집
```bash
# 마지막 명령 수정
fc

# 마지막 명령 sudo로 재실행
sudo !!

# 마지막 인자 재사용
mkdir test && cd $_
```

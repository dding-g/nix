# Nix-Darwin macOS Configuration

nix-darwin + home-manager를 사용한 macOS 개발 환경 자동화 설정입니다.

## 포함된 도구

### CLI 도구 (Nix)
| 카테고리 | 패키지 |
|----------|--------|
| 기본 | `git` `curl` `wget` |
| Modern CLI | `eza` `bat` `ripgrep` `fd` `fzf` |
| 개발 | `neovim` `lazygit` `jq` `yq` `delta` `gh` |
| Rust | `rustc` `cargo` |
| 모니터링 | `htop` `btop` `dust` `duf` `procs` |
| Node.js | `volta` |
| DevOps | `awscli2` `terraform` |
| 사용자 | `httpie` `tldr` `tree` `wt` |

### Homebrew Formulae
| 패키지 | 설명 |
|--------|------|
| `mas` | Mac App Store CLI |
| `mackup` | 앱 설정 백업/복원 (iCloud) |
| `openjdk@17` | Java (React Native) |
| `gemini-cli` | Google Gemini CLI |
| `railway` | Railway 배포 CLI |
| `git-flow` | Git Flow 워크플로우 |

### GUI 앱 (Homebrew Casks)
| 카테고리 | 앱 |
|----------|-----|
| 터미널 | Ghostty |
| 에디터 | Sublime Text, Zed, OpenCode Desktop, Cursor |
| 개발 | Docker Desktop, Insomnia, Android Studio, Figma, Android Platform Tools, Apidog |
| AI | Claude, Claude Code, ChatGPT |
| 브라우저 | Zen, Google Chrome |
| 생산성 | Raycast, Notion, Slack, Itsycal, Obsidian, Linear |
| 폰트 | JetBrains Mono Nerd Font |

### Mac App Store
- KakaoTalk
- Xcode

### macOS 설정
- Dock: 자동 숨김, 오른쪽 배치, 최근 항목 숨김
- Finder: 경로바/상태바 표시, 확장자 표시, 리스트 뷰
- 키보드: 빠른 키 반복 (KeyRepeat=2), F키 기본 동작
- 스크린샷: ~/Pictures/Screenshots, PNG, 그림자 제거
- Touch ID sudo 인증
- Spotlight 단축키 비활성화 (Raycast용)

## 사전 설치

### 1. Nix (Determinate Installer)
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 2. Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 설치

```bash
# GitHub CLI 설치 및 인증
brew install gh
gh auth login

# 저장소 클론
gh repo clone ddingg/nix ~/.config/nix-darwin
cd ~/.config/nix-darwin

# 환경변수 설정
cp .env.example .env
# .env 파일을 열어 NIX_USER, NIX_HOSTNAME 값 설정

# 첫 실행
source .env && sudo nix run nix-darwin -- switch --flake . --impure

# 이후 업데이트
source .env && darwin-rebuild switch --flake . --impure
```

## 환경변수 설정

### 1. .env 파일 생성

```bash
cp .env.example .env
```

### 2. 값 확인 및 설정

```bash
# 사용자명 확인
whoami

# 호스트명 확인
hostname
```

### 3. .env 파일 수정

```bash
# .env
NIX_USER=myuser
NIX_HOSTNAME=my-mac
```

### 환경변수 목록

| 변수 | 설명 | 확인 방법 | 기본값 |
|------|------|----------|--------|
| `NIX_USER` | macOS 사용자명 | `whoami` | `ddingg` |
| `NIX_HOSTNAME` | 호스트명 | `hostname` | `jomyeong-geun-ui-MacBookPro` |

> `.env` 파일은 `.gitignore`에 포함되어 있어 개인 설정이 저장소에 커밋되지 않습니다.
> 환경변수 사용 시 `--impure` 플래그가 필요합니다.

## 주요 명령어

```bash
rebuild      # 설정 적용 (darwin-rebuild switch)
nix-clean    # 가비지 컬렉션
nix-update   # flake 업데이트
```

## 앱 설정 관리 (Mackup)

앱 설정 파일(Ghostty, Zed, Claude Code 등)은 Mackup을 통해 iCloud로 백업/복원합니다.

```bash
# 설정 백업 (변경 후 실행)
mackup backup

# 새 Mac에서 복원
mackup restore

# 지원 앱 확인
mackup list | grep <app>
```

백업 위치: `~/Library/Mobile Documents/com~apple~CloudDocs/Mackup/`

## 파일 구조

```
.
├── flake.nix                   # Flake 진입점
├── darwin.nix                  # 시스템 모듈 진입점
├── home.nix                    # 홈 모듈 진입점
├── modules/
│   ├── darwin/                 # 시스템 레벨 모듈
│   │   ├── packages.nix        # CLI 도구 (Nix)
│   │   ├── homebrew.nix        # Homebrew casks/brews
│   │   └── system.nix          # macOS defaults
│   └── home/                   # 사용자 레벨 모듈
│       ├── git.nix             # Git 설정
│       ├── shell.nix           # Zsh + aliases
│       ├── starship.nix        # 프롬프트
│       └── programs.nix        # fzf, direnv, zoxide
├── scripts/
│   └── wt                      # Git Worktree Manager
└── CLAUDE.md                   # AI 어시스턴트용 컨텍스트
```

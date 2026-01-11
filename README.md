# Nix-Darwin macOS Configuration

nix-darwin + home-manager를 사용한 macOS 개발 환경 자동화 설정입니다.

## 포함된 도구

### CLI 도구 (Nix)
| 카테고리 | 패키지 |
|----------|--------|
| 기본 | `git` `curl` `wget` |
| Modern CLI | `eza` `bat` `ripgrep` `fd` `fzf` |
| 개발 | `lazygit` `jq` `yq` `delta` `gh` |
| 모니터링 | `htop` `btop` `dust` `duf` `procs` |
| Node.js | `pnpm` `bun` `volta` |
| DevOps | `awscli2` `terraform` |
| 사용자 | `httpie` `tldr` `tree` |

### Homebrew Formulae
| 패키지 | 설명 |
|--------|------|
| `mas` | Mac App Store CLI |
| `openjdk@17` | Java (React Native) |
| `gemini-cli` | Google Gemini CLI |
| `railway` | Railway 배포 CLI |

### GUI 앱 (Homebrew Casks)
| 카테고리 | 앱 |
|----------|-----|
| 터미널 | Ghostty |
| 에디터 | Sublime Text, Zed, OpenCode Desktop |
| 개발 | Docker Desktop, Insomnia, Android Studio, Figma, Android Platform Tools |
| AI | Claude, Claude Code, ChatGPT, Warp |
| 브라우저 | Zen, Google Chrome |
| 생산성 | Raycast, Notion, Slack |
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

# 첫 실행
sudo nix run nix-darwin -- switch --flake .

# 이후 업데이트
darwin-rebuild switch --flake .
```

## 주요 명령어

```bash
rebuild      # 설정 적용 (darwin-rebuild switch)
nix-clean    # 가비지 컬렉션
nix-update   # flake 업데이트
```

## 파일 구조

```
.
├── flake.nix      # Flake 진입점
├── darwin.nix     # 시스템 설정 (패키지, Homebrew, macOS)
├── home.nix       # 사용자 설정 (shell, git, dotfiles)
├── CLAUDE.md      # AI 어시스턴트용 컨텍스트
└── docs/          # 도구별 사용 가이드
```

## 문서

자세한 도구 사용법은 [docs/README.md](./docs/README.md) 참조.

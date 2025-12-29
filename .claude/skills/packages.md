# 패키지 레퍼런스

## 자주 사용하는 CLI 패키지

### 기본 도구
| 패키지 | 설명 | nixpkgs 이름 |
|--------|------|--------------|
| Git | 버전 관리 | `git` |
| curl | HTTP 클라이언트 | `curl` |
| wget | 다운로더 | `wget` |

### Modern CLI (기본 명령어 대체)
| 기존 | 대체 | nixpkgs 이름 | 설명 |
|------|------|--------------|------|
| ls | eza | `eza` | 컬러, 아이콘, Git 상태 |
| cat | bat | `bat` | 문법 하이라이팅 |
| grep | ripgrep | `ripgrep` | 빠른 검색 |
| find | fd | `fd` | 직관적 문법 |
| - | fzf | `fzf` | Fuzzy finder |
| - | zoxide | `zoxide` | 스마트 cd |

### 개발 도구
| 패키지 | nixpkgs 이름 | 설명 |
|--------|--------------|------|
| Neovim | `neovim` | 에디터 |
| lazygit | `lazygit` | TUI Git |
| jq | `jq` | JSON 처리 |
| yq | `yq` | YAML 처리 |
| GitHub CLI | `gh` | GitHub 작업 |
| httpie | `httpie` | HTTP 클라이언트 |

### Node.js 생태계
| 패키지 | nixpkgs 이름 |
|--------|--------------|
| Node 20 LTS | `nodejs_20` |
| Node 22 | `nodejs_22` |
| pnpm | `pnpm` |
| yarn | `yarn` |

### Python
| 패키지 | nixpkgs 이름 |
|--------|--------------|
| Python 3.11 | `python311` |
| Python 3.12 | `python312` |

### AWS / DevOps
| 패키지 | nixpkgs 이름 |
|--------|--------------|
| AWS CLI v2 | `awscli2` |
| Terraform | `terraform` |
| kubectl | `kubectl` |
| k9s | `k9s` |

## Homebrew Casks (GUI 앱)

### 터미널
| 앱 | cask 이름 |
|----|-----------|
| Ghostty | `ghostty` |
| iTerm2 | `iterm2` |
| WezTerm | `wezterm` |
| Alacritty | `alacritty` |

### 에디터/IDE
| 앱 | cask 이름 |
|----|-----------|
| VS Code | `visual-studio-code` |
| Cursor | `cursor` |
| Zed | `zed` |
| JetBrains Toolbox | `jetbrains-toolbox` |

### 개발 도구
| 앱 | cask 이름 |
|----|-----------|
| Docker Desktop | `docker` |
| Postman | `postman` |
| Insomnia | `insomnia` |
| TablePlus | `tableplus` |
| Sequel Ace | `sequel-ace` |

### 브라우저
| 앱 | cask 이름 |
|----|-----------|
| Arc | `arc` |
| Chrome | `google-chrome` |
| Firefox | `firefox` |
| Brave | `brave-browser` |

### 생산성
| 앱 | cask 이름 |
|----|-----------|
| Raycast | `raycast` |
| Alfred | `alfred` |
| Notion | `notion` |
| Obsidian | `obsidian` |
| Slack | `slack` |
| Discord | `discord` |
| Zoom | `zoom` |

### 디자인
| 앱 | cask 이름 |
|----|-----------|
| Figma | `figma` |

### 유틸리티
| 앱 | cask 이름 |
|----|-----------|
| 1Password | `1password` |
| Bitwarden | `bitwarden` |
| CleanMyMac | `cleanmymac` |
| AppCleaner | `appcleaner` |
| Rectangle | `rectangle` |
| Hidden Bar | `hiddenbar` |

### 폰트 (tap: homebrew/cask-fonts)
| 폰트 | cask 이름 |
|------|-----------|
| JetBrains Mono Nerd | `font-jetbrains-mono-nerd-font` |
| Fira Code Nerd | `font-fira-code-nerd-font` |
| Hack Nerd | `font-hack-nerd-font` |
| MesloLG Nerd | `font-meslo-lg-nerd-font` |

## Mac App Store (masApps)

```nix
masApps = {
  "Xcode" = 497799835;
  "KakaoTalk" = 869223134;
  "Slack" = 803453959;
  "1Password" = 1333542190;
  "Magnet" = 441258766;
};
```

> ID 확인: `mas search <app name>`

## 검색 방법

```bash
# Nix 패키지 검색
nix search nixpkgs <keyword>

# 또는 웹
# https://search.nixos.org/packages

# Homebrew cask 검색
brew search --cask <keyword>

# Mac App Store 검색
mas search <keyword>
```

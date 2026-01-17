# Nix-Darwin macOS Configuration

## 프로젝트 개요

이 프로젝트는 **nix-darwin + home-manager**를 사용한 macOS 시스템 설정 자동화 프로젝트입니다.
목표는 macOS 초기화 후 단일 명령으로 전체 개발 환경을 복원하는 것입니다.

## 기술 스택

- **Nix Flakes**: 패키지 및 의존성 관리
- **nix-darwin**: macOS 시스템 설정 선언적 관리
- **home-manager**: 사용자 레벨 dotfiles 및 프로그램 설정

## 디렉토리 구조

```
.
├── flake.nix                   # 진입점 - inputs 및 outputs 정의
├── flake.lock                  # 의존성 버전 락 파일
├── darwin.nix                  # 시스템 모듈 진입점 (imports만)
├── home.nix                    # 홈 모듈 진입점 (imports만)
├── modules/
│   ├── darwin/                 # 시스템 레벨 모듈
│   │   ├── default.nix         # darwin 모듈 진입점
│   │   ├── packages.nix        # 시스템 패키지 (CLI 도구)
│   │   ├── homebrew.nix        # Homebrew casks/brews
│   │   └── system.nix          # macOS defaults, 보안, 사용자 설정
│   └── home/                   # 사용자 레벨 모듈
│       ├── default.nix         # home 모듈 진입점 + Mackup 설정
│       ├── git.nix             # Git 설정
│       ├── shell.nix           # Zsh 설정 + aliases
│       ├── starship.nix        # 프롬프트 설정
│       └── programs.nix        # fzf, direnv, zoxide
└── CLAUDE.md                   # 이 파일
```

## 핵심 명령어

```bash
# 설정 적용 (수정 후 항상 실행)
source .env && darwin-rebuild switch --flake . --impure

# 패키지 검색
nix search nixpkgs <package-name>

# Flake 업데이트 (모든 패키지 최신화)
nix flake update

# 문법 체크
nix flake check

# 가비지 컬렉션 (디스크 정리)
nix-collect-garbage -d

# 롤백
darwin-rebuild --rollback
```

## 사용자 정보

- **username**: ddingg (macOS 사용자명)
- **system**: aarch64-darwin (Apple Silicon)
- **hostname**: jomyeong-geun-ui-MacBookPro

## 작업 규칙

### 파일 수정 시
1. Nix 문법 준수 (세미콜론, 중괄호 등)
2. 수정 후 `nix flake check`로 문법 검증 권장
3. 점진적 변경 - 한 번에 너무 많이 바꾸지 않기

### 패키지 추가 시
| 패키지 유형 | 추가할 파일 |
|------------|-----------|
| CLI 도구 (Nix) | `modules/darwin/packages.nix` → `environment.systemPackages` |
| Homebrew brew | `modules/darwin/homebrew.nix` → `homebrew.brews` |
| GUI 앱 (Cask) | `modules/darwin/homebrew.nix` → `homebrew.casks` |
| Mac App Store | `modules/darwin/homebrew.nix` → `homebrew.masApps` |
| 사용자 도구 | `modules/home/programs.nix` → `home.packages` |

### Shell alias 추가
`modules/home/shell.nix` → `programs.zsh.shellAliases`

### macOS 기본값 변경
`modules/darwin/system.nix` → `system.defaults`

### 앱 설정 파일 관리 (Mackup)
앱 설정 파일은 Mackup을 통해 iCloud로 백업/복원됩니다.
- 설정 변경 후 백업: `mackup backup`
- 새 Mac에서 복원: `mackup restore`
- 백업 위치: `~/Library/Mobile Documents/com~apple~CloudDocs/Mackup/`

## 자주 사용하는 패턴

### Nix 패키지 추가
```nix
# modules/darwin/packages.nix
environment.systemPackages = with pkgs; [
  existing-package
  new-package  # 여기에 추가
];
```

### Homebrew Cask 추가
```nix
# modules/darwin/homebrew.nix
homebrew.casks = [
  "existing-app"
  "new-app"  # 여기에 추가
];
```

### Shell alias 추가
```nix
# modules/home/shell.nix
programs.zsh.shellAliases = {
  existing = "command";
  newalias = "new-command";  # 여기에 추가
};
```

### macOS 기본값 변경
```nix
# modules/darwin/system.nix
system.defaults.dock.autohide = true;
system.defaults.finder.ShowPathbar = true;
```

## 트러블슈팅

### 빌드 실패 시
1. `nix flake check`로 문법 오류 확인
2. 에러 메시지에서 파일:라인 확인
3. 최근 변경사항 롤백 후 하나씩 추가

### Homebrew 관련 오류
- `brew` 명령 경로 문제: `/opt/homebrew/bin/brew` 확인
- 앱 이름 오류: `brew search <app>` 으로 정확한 이름 확인

### 패키지를 못 찾을 때
```bash
nix search nixpkgs <name>
# 또는 https://search.nixos.org/packages 에서 검색
```

### Mackup 관련
- 지원 앱 확인: `mackup list | grep <app>`
- 백업 상태 확인: `ls -la ~/Library/Mobile\ Documents/com~apple~CloudDocs/Mackup/`
- 복원 후 앱 재시작 필요

## 참고 리소스

- [nix-darwin 옵션](https://daiderd.com/nix-darwin/manual/index.html)
- [home-manager 옵션](https://nix-community.github.io/home-manager/options.html)
- [Nix 패키지 검색](https://search.nixos.org/packages)
- [macOS defaults 참고](https://macos-defaults.com/)

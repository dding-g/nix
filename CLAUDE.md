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
├── flake.nix           # 진입점 - inputs 및 outputs 정의
├── flake.lock          # 의존성 버전 락 파일
├── darwin.nix          # 시스템 레벨 설정 (패키지, Homebrew, macOS defaults)
├── home.nix            # 사용자 레벨 설정 (shell, git, dotfiles)
├── modules/            # 기능별 분리된 모듈
│   ├── darwin/         # 시스템 모듈
│   │   ├── homebrew.nix
│   │   ├── system.nix
│   │   └── packages.nix
│   └── home/           # 홈 매니저 모듈
│       ├── shell.nix
│       ├── git.nix
│       ├── dev.nix
│       └── programs.nix
└── CLAUDE.md           # 이 파일
```

## 핵심 명령어

```bash
# 설정 적용 (수정 후 항상 실행)
darwin-rebuild switch --flake .

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
- **hostname**: macbook

## 작업 규칙

### 파일 수정 시
1. Nix 문법 준수 (세미콜론, 중괄호 등)
2. 수정 후 `nix flake check`로 문법 검증 권장
3. 점진적 변경 - 한 번에 너무 많이 바꾸지 않기

### 패키지 추가 시
- CLI 도구: `darwin.nix` → `environment.systemPackages`
- GUI 앱 (macOS): `darwin.nix` → `homebrew.casks`
- Mac App Store: `darwin.nix` → `homebrew.masApps`
- 사용자 도구/dotfiles: `home.nix`

### 모듈 분리 기준
- 단일 파일이 100줄 초과 시 모듈로 분리 고려
- 관련 설정끼리 그룹화 (shell, git, dev 등)

## 자주 사용하는 패턴

### 패키지 추가
```nix
environment.systemPackages = with pkgs; [
  existing-package
  new-package  # 여기에 추가
];
```

### Homebrew Cask 추가
```nix
homebrew.casks = [
  "existing-app"
  "new-app"  # 여기에 추가
];
```

### Shell alias 추가
```nix
programs.zsh.shellAliases = {
  existing = "command";
  newalias = "new-command";  # 여기에 추가
};
```

### macOS 기본값 변경
```nix
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

## 참고 리소스

- [nix-darwin 옵션](https://daiderd.com/nix-darwin/manual/index.html)
- [home-manager 옵션](https://nix-community.github.io/home-manager/options.html)
- [Nix 패키지 검색](https://search.nixos.org/packages)
- [macOS defaults 참고](https://macos-defaults.com/)

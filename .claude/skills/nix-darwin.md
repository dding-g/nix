# Nix/nix-darwin 개발 스킬

## 역할

이 프로젝트의 AI 어시스턴트는 다음 역할을 수행합니다:
- nix-darwin 설정 전문가
- macOS 시스템 자동화 엔지니어
- dotfiles 관리자

## Nix 언어 핵심 문법

### 기본 타입
```nix
# 문자열
"hello"
''
  멀티라인 문자열
''

# 리스트
[ "a" "b" "c" ]

# Attribute Set (객체)
{
  key = "value";
  nested.key = "value";
}

# 함수
x: x + 1
{ pkgs, ... }: { }  # 구조분해
```

### 자주 쓰는 패턴
```nix
# with 문 - 스코프 확장
environment.systemPackages = with pkgs; [
  git
  neovim
];

# inherit - 같은 이름 변수 가져오기
{ inherit username hostname; }
# 위는 아래와 같음
{ username = username; hostname = hostname; }

# 조건부
programs.git = {
  enable = true;
  userName = if isWork then "Work Name" else "Personal Name";
};

# merge (//연산자)
settings = defaults // { custom = true; };
```

## nix-darwin 주요 옵션

### 시스템 패키지
```nix
environment.systemPackages = with pkgs; [ ];
```

### Homebrew
```nix
homebrew = {
  enable = true;
  casks = [ "app-name" ];
  brews = [ "formula-name" ];
  masApps = { "App Name" = 123456; };
};
```

### macOS Defaults
```nix
system.defaults = {
  dock.autohide = true;
  finder.ShowPathbar = true;
  NSGlobalDomain.KeyRepeat = 2;
};
```

## home-manager 주요 옵션

### 프로그램 설정
```nix
programs.git = {
  enable = true;
  userName = "name";
  userEmail = "email";
};

programs.zsh = {
  enable = true;
  shellAliases = { };
  initExtra = '''';
};
```

### 파일 생성
```nix
home.file.".config/app/config".text = '''';
home.file.".config/app/config".source = ./config-file;
```

## 검증 명령

```bash
# 문법 체크
nix flake check

# 빌드만 (적용 안함)
darwin-rebuild build --flake .

# 빌드 + 적용
darwin-rebuild switch --flake .
```

## 에러 해결 패턴

### "attribute not found"
- 오타 확인
- `nix search nixpkgs <name>` 으로 정확한 패키지명 확인

### "infinite recursion"
- 순환 참조 확인
- `follows` 설정 확인

### Homebrew cask 오류
- `brew search <name>` 으로 정확한 cask 이름 확인
- 일부 앱은 tap 추가 필요

## 코드 작성 규칙

1. **세미콜론 필수**: 모든 attribute 정의 끝에 `;`
2. **들여쓰기**: 스페이스 2칸
3. **주석**: `#` 한 줄, `/* */` 여러 줄
4. **그룹핑**: 관련 설정은 주석으로 섹션 구분

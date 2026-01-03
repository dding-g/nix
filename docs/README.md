# Nix 개발 환경 도구 가이드

이 문서들은 nix-darwin으로 설치된 도구들의 사용법을 정리한 것입니다.

## 문서 목록

| 파일 | 설명 |
|------|------|
| [modern-cli.md](./modern-cli.md) | eza, bat, ripgrep, fd, fzf (기본 명령어 대체) |
| [system-monitoring.md](./system-monitoring.md) | btop, htop, dust, duf, procs (시스템 모니터링) |
| [git-tools.md](./git-tools.md) | delta, lazygit, gh (Git 워크플로우) |
| [dev-tools.md](./dev-tools.md) | jq, yq, httpie, tldr, direnv, zoxide (개발 유틸리티) |
| [shell-terminal.md](./shell-terminal.md) | Zsh, Starship, Ghostty 설정 및 alias |

## 빠른 참조: Alias 치트시트

### 기본 명령어
```bash
ls → eza          cat → bat         grep → rg
find → fd         top → btop        du → dust
df → duf          ps → procs
```

### Git
```bash
g    git          gs   status       gp   push
gl   pull         gco  checkout     gcm  commit -m
gd   diff         ga   add          gaa  add -A
gcb  checkout -b  lg   lazygit
```

### 이동
```bash
..   cd ..        z <kw>  zoxide (스마트 cd)
dev  ~/Developer  dl      ~/Downloads
```

### Nix
```bash
rebuild     darwin-rebuild switch
nix-clean   가비지 컬렉션
nix-update  flake 업데이트
```

### 유틸리티
```bash
c        clear         myip     외부 IP
q        exit          localip  로컬 IP
copy     pbcopy        serve    HTTP 서버 (8000)
paste    pbpaste       ff       fzf + 미리보기
port N   포트 확인     mkcd     mkdir + cd
```

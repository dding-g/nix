---
description: nix-darwin 설정 적용 및 README 업데이트
---

nix-darwin 설정을 시스템에 적용하고 README를 최신 상태로 업데이트합니다.

## 실행 단계

1. `sudo darwin-rebuild switch --flake .` 실행
2. 빌드 성공 시 README.md 업데이트:
   - `darwin.nix`의 `environment.systemPackages` → CLI 도구 테이블
   - `darwin.nix`의 `homebrew.casks` → GUI 앱 테이블
   - `darwin.nix`의 `homebrew.brews` → Homebrew formulae
   - `darwin.nix`의 `system.defaults` → macOS 설정 요약
   - `home.nix`의 `home.packages` → 사용자 패키지

## README.md 구조

```markdown
# Nix-Darwin macOS Configuration

## 포함된 도구
### CLI 도구 (Nix)
| 카테고리 | 패키지 |
### GUI 앱 (Homebrew)
| 카테고리 | 앱 |
### macOS 설정
- 주요 설정 bullet points

## 사전 설치
## 설치
## 주요 명령어
## 파일 구조
## 문서
```

3. README 변경사항이 있으면 git diff로 보여주기

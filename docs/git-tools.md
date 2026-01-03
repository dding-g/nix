# Git 도구

Git 작업을 더 효율적으로 만드는 도구들입니다.

## delta (Git diff 뷰어)

Syntax highlighting과 side-by-side 비교가 되는 diff 뷰어.
Git에 자동 연동되어 있어 별도 명령 필요 없음.

```bash
# Git과 자동 연동
git diff                 # delta로 자동 표시
git show                 # delta로 자동 표시
git log -p               # delta로 자동 표시

# 현재 설정
# - side-by-side: 좌우 비교
# - line-numbers: 라인 번호 표시
# - navigate: n/N으로 파일 간 이동
# - 테마: Catppuccin Mocha

# delta 단독 사용
diff file1 file2 | delta
cat file.patch | delta
```

## lazygit (Git TUI)

터미널에서 사용하는 Git GUI.

```bash
# 실행
lazygit          # 또는 alias: lg

# 주요 단축키
# ?        도움말
# q        종료
# j/k      위아래 이동
# enter    선택/상세보기
# space    스테이징/언스테이징
# c        커밋
# p        push
# P        pull
# b        브랜치 메뉴
# m        머지
# r        rebase 메뉴
# s        stash 메뉴
# z        undo (실험적)

# 파일 관련
# a        모두 스테이지
# d        파일 삭제 (discard changes)
# e        파일 편집

# 커밋 관련
# A        amend 커밋
# r        reword 커밋 메시지
# d        커밋 삭제
# g        reset 메뉴
```

## gh (GitHub CLI)

GitHub 작업을 터미널에서 수행.

```bash
# 인증
gh auth login            # GitHub 로그인

# Repository
gh repo create           # 새 repo 생성
gh repo clone owner/repo # 클론
gh repo view             # 현재 repo 정보
gh repo fork             # 포크

# Pull Request
gh pr create             # PR 생성
gh pr list               # PR 목록
gh pr checkout 123       # PR #123 체크아웃
gh pr view               # 현재 브랜치 PR 보기
gh pr merge              # PR 머지
gh pr review             # PR 리뷰

# Issue
gh issue create          # 이슈 생성
gh issue list            # 이슈 목록
gh issue view 123        # 이슈 #123 보기
gh issue close 123       # 이슈 닫기

# Actions (CI/CD)
gh run list              # workflow 실행 목록
gh run view              # 실행 상세
gh run watch             # 실행 실시간 모니터링

# Gist
gh gist create file.txt  # gist 생성
gh gist list             # gist 목록
```

## Git Alias

설정된 Git 단축 명령어들:

```bash
# 기본 alias
g                # git
gs               # git status
gp               # git push
gl               # git pull
gco              # git checkout
gcm "msg"        # git commit -m "msg"
gd               # git diff
ga               # git add
gaa              # git add -A
gcb branch       # git checkout -b branch
lg               # lazygit

# Git 내장 alias (.gitconfig)
git st           # git status
git co           # git checkout
git br           # git branch
git ci           # git commit
git lg           # git log --oneline --graph --all
```

## 유용한 Git 워크플로우

```bash
# 새 기능 개발
gcb feature/new-feature    # 새 브랜치
# ... 코딩 ...
gaa                        # 모든 변경 스테이지
gcm "feat: 새 기능 추가"    # 커밋
gp                         # 푸시
gh pr create               # PR 생성

# 빠른 수정
ga file.js
gcm "fix: 버그 수정"
gp

# lazygit으로 복잡한 작업
lg                         # lazygit 실행
# space로 원하는 파일만 스테이지
# c로 커밋
# p로 푸시
```

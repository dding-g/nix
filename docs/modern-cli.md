# Modern CLI 도구

기본 Unix 명령어를 대체하는 현대적인 CLI 도구들입니다.

## eza (ls 대체)

더 예쁘고 기능이 풍부한 `ls` 대체.

```bash
# 기본 사용
eza              # ls와 동일
eza -l           # 상세 목록
eza -la          # 숨김 파일 포함
eza --tree       # 트리 구조
eza -l --git     # Git 상태 표시

# 설정된 alias
ls               # eza
ll               # eza -la
la               # eza -a
lt               # eza --tree
l                # eza -l
```

## bat (cat 대체)

Syntax highlighting이 되는 `cat` 대체.

```bash
# 기본 사용
bat file.js              # 파일 보기 (syntax highlighting)
bat file1.js file2.js    # 여러 파일
bat -n file.js           # 라인 번호만 (헤더 없이)
bat -p file.js           # plain 모드 (장식 없이)
bat --diff file.js       # Git diff 하이라이트

# 파이프와 함께
curl -s api.com | bat -l json    # JSON 하이라이트
cat log.txt | bat -l log         # 로그 하이라이트

# 설정된 alias
cat              # bat
```

## ripgrep (grep 대체)

매우 빠른 `grep` 대체. 기본적으로 .gitignore를 존중함.

```bash
# 기본 사용
rg "pattern"             # 현재 디렉토리에서 검색
rg "pattern" ./src       # 특정 디렉토리에서 검색
rg -i "pattern"          # 대소문자 무시
rg -w "word"             # 단어 단위 매칭
rg "pattern" -t js       # 특정 파일 타입만

# 고급 사용
rg "pattern" -C 3        # 앞뒤 3줄 컨텍스트
rg "pattern" -l          # 파일명만 출력
rg "pattern" --json      # JSON 출력
rg "TODO|FIXME"          # 정규식

# 설정된 alias
grep             # rg
```

## fd (find 대체)

사용자 친화적인 `find` 대체.

```bash
# 기본 사용
fd                       # 모든 파일 나열
fd "pattern"             # 이름으로 검색
fd -e js                 # 확장자로 검색
fd -e js -e ts           # 여러 확장자

# 고급 사용
fd -H "pattern"          # 숨김 파일 포함
fd -t f "pattern"        # 파일만
fd -t d "pattern"        # 디렉토리만
fd -x rm {}              # 찾은 파일 삭제
fd -e js -x wc -l        # 찾은 JS 파일 라인 수

# 설정된 alias
find             # fd
```

## fzf (Fuzzy Finder)

인터랙티브 fuzzy 검색 도구.

```bash
# 기본 사용
fzf                      # 파일 검색
fzf --preview "bat {}"   # 미리보기와 함께

# 다른 명령과 조합
vim $(fzf)               # 선택한 파일 vim으로 열기
cd $(fd -t d | fzf)      # 디렉토리 선택 후 이동
git checkout $(git branch | fzf)  # 브랜치 선택

# 히스토리 검색 (Ctrl+R)
# 파일 검색 (Ctrl+T)
# 디렉토리 이동 (Alt+C)

# 설정된 함수
ff               # fzf --preview "bat --color=always {}"
```

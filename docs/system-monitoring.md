# 시스템 모니터링 도구

시스템 리소스를 모니터링하는 현대적인 도구들입니다.

## btop (top 대체)

예쁜 UI의 시스템 모니터.

```bash
# 실행
btop

# 키보드 단축키 (btop 내부)
# h        도움말
# q        종료
# e        프로세스 트리 보기
# f        필터
# k        프로세스 종료
# s        정렬 변경
# m        메모리 정렬
# p        CPU 정렬

# 설정된 alias
top              # btop
```

## htop (top 대체)

클래식한 인터랙티브 프로세스 뷰어.

```bash
# 실행
htop

# 키보드 단축키
# F1       도움말
# F2       설정
# F3       검색
# F4       필터
# F5       트리 보기
# F9       프로세스 종료
# F10      종료
# /        검색
# k        시그널 보내기

# 특정 사용자 프로세스만
htop -u ddingg
```

## dust (du 대체)

디스크 사용량을 시각적으로 보여주는 도구.

```bash
# 기본 사용
dust                     # 현재 디렉토리
dust /path               # 특정 경로
dust -d 2                # 깊이 제한
dust -r                  # 역순 정렬

# 파일 개수 기준
dust -f                  # 파일 개수로 정렬

# 특정 파일 무시
dust -X node_modules     # node_modules 제외

# 설정된 alias
du               # dust
```

## duf (df 대체)

디스크 여유 공간을 예쁘게 보여주는 도구.

```bash
# 기본 사용
duf                      # 모든 디스크 정보

# 필터링
duf /                    # 특정 마운트 포인트만
duf -only local          # 로컬 디스크만
duf -hide special        # 특수 파일시스템 숨김

# 출력 포맷
duf -json                # JSON 출력
duf -output mountpoint,size,avail,usage

# 설정된 alias
df               # duf
```

## procs (ps 대체)

더 읽기 좋은 프로세스 목록.

```bash
# 기본 사용
procs                    # 모든 프로세스

# 검색/필터
procs node               # 'node' 포함 프로세스
procs --tree             # 트리 구조
procs -w                 # watch 모드 (실시간)

# 정렬
procs --sortd cpu        # CPU 사용량 순
procs --sortd mem        # 메모리 사용량 순
procs --sorta start      # 시작 시간 순

# 특정 정보만
procs -c pid,user,cpu,command

# 설정된 alias
ps               # procs
```

## 추가 유틸리티 alias

```bash
# 포트 사용 확인
port 3000        # lsof -i :3000 (해당 포트 사용 프로세스)

# IP 주소 확인
myip             # 외부 IP (curl ifconfig.me)
localip          # 로컬 IP (ipconfig getifaddr en0)

# 빠른 HTTP 서버
serve            # python3 -m http.server 8000
```

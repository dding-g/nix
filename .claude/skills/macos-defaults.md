# macOS System Defaults 레퍼런스

## Dock

```nix
system.defaults.dock = {
  # 자동 숨김
  autohide = true;
  autohide-delay = 0.0;          # 숨김 딜레이 (초)
  autohide-time-modifier = 0.4;  # 애니메이션 속도
  
  # 크기/위치
  tilesize = 48;                 # 아이콘 크기 (16-128)
  orientation = "bottom";        # bottom | left | right
  
  # 표시 옵션
  show-recents = false;          # 최근 앱 표시
  static-only = false;           # 실행 중인 앱만 표시
  
  # 기타
  mru-spaces = false;            # 최근 사용 기준 spaces 정렬 비활성화
  mineffect = "scale";           # 최소화 효과: genie | scale
};
```

## Finder

```nix
system.defaults.finder = {
  # 표시 옵션
  AppleShowAllExtensions = true;     # 확장자 항상 표시
  AppleShowAllFiles = false;         # 숨김 파일 표시
  ShowPathbar = true;                # 경로 바 표시
  ShowStatusBar = true;              # 상태 바 표시
  
  # 검색
  FXDefaultSearchScope = "SCcf";     # 현재 폴더에서 검색
  
  # 뷰
  FXPreferredViewStyle = "Nlsv";     # icnv(아이콘) | Nlsv(리스트) | clmv(컬럼) | Flwv(갤러리)
  
  # 기타
  FXEnableExtensionChangeWarning = false;  # 확장자 변경 경고 비활성화
  _FXShowPosixPathInTitle = true;          # 타이틀에 전체 경로 표시
};
```

## 키보드

```nix
system.defaults.NSGlobalDomain = {
  # 키 반복
  KeyRepeat = 2;              # 키 반복 속도 (1이 가장 빠름, 기본 6)
  InitialKeyRepeat = 15;      # 반복 시작 딜레이 (기본 25)
  ApplePressAndHoldEnabled = false;  # 길게 눌러 특수문자 비활성화 (키 반복 활성화)
  
  # 자동 수정
  NSAutomaticSpellingCorrectionEnabled = false;   # 자동 맞춤법
  NSAutomaticCapitalizationEnabled = false;       # 자동 대문자
  NSAutomaticDashSubstitutionEnabled = false;     # 자동 대시 변환
  NSAutomaticQuoteSubstitutionEnabled = false;    # 자동 따옴표 변환
  NSAutomaticPeriodSubstitutionEnabled = false;   # 자동 마침표 (스페이스 두번)
  
  # 기타
  AppleKeyboardUIMode = 3;    # 전체 키보드 접근 (탭으로 모든 컨트롤 이동)
};
```

## 트랙패드

```nix
system.defaults.trackpad = {
  Clicking = true;                     # 탭으로 클릭
  TrackpadThreeFingerDrag = true;      # 세 손가락 드래그
  TrackpadRightClick = true;           # 두 손가락 우클릭
};
```

## 스크린샷

```nix
system.defaults.screencapture = {
  location = "~/Screenshots";    # 저장 위치
  type = "png";                  # 포맷: png | jpg | pdf | gif
  disable-shadow = true;         # 그림자 비활성화
};
```

## 시스템 전역

```nix
system.defaults.NSGlobalDomain = {
  # 스크롤
  AppleScrollerPagingBehavior = true;  # 스크롤바 클릭 시 해당 위치로 이동
  
  # 외관
  AppleInterfaceStyle = "Dark";        # 다크 모드
  AppleShowScrollBars = "WhenScrolling"; # 스크롤바: Automatic | WhenScrolling | Always
  
  # 확장자
  AppleShowAllExtensions = true;
};
```

## 기타 앱별 설정

```nix
# Activity Monitor
system.defaults.ActivityMonitor = {
  ShowCategory = 0;  # 모든 프로세스
  IconType = 5;      # CPU 사용량 표시
};

# 타임머신
system.defaults.TimeMachine.DoNotOfferNewDisksForBackup = true;
```

## 참고

전체 옵션 목록:
- https://macos-defaults.com/
- https://daiderd.com/nix-darwin/manual/index.html

{ pkgs, username, hostname, ... }:

{
  # ═══════════════════════════════════════════════════════════
  # Nix 설정 (Determinate Nix 사용 시 비활성화)
  # ═══════════════════════════════════════════════════════════
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;

  # ═══════════════════════════════════════════════════════════
  # 시스템 패키지
  # ═══════════════════════════════════════════════════════════
  environment.systemPackages = with pkgs; [
    # ─────────────────────────────────────────
    # 기본 CLI 도구
    # ─────────────────────────────────────────
    git
    curl
    wget

    # ─────────────────────────────────────────
    # Modern CLI (기본 명령어 대체)
    # ─────────────────────────────────────────
    eza       # ls 대체
    bat       # cat 대체
    ripgrep   # grep 대체
    fd        # find 대체
    fzf       # fuzzy finder

    # ─────────────────────────────────────────
    # 개발 도구
    # ─────────────────────────────────────────
    lazygit
    jq
    yq
    delta     # git diff 뷰어
    gh        # GitHub CLI

    # ─────────────────────────────────────────
    # 시스템 모니터링
    # ─────────────────────────────────────────
    htop      # 프로세스 모니터
    btop      # 더 예쁜 시스템 모니터
    dust      # du 대체 (디스크 사용량)
    duf       # df 대체 (디스크 여유 공간)
    procs     # ps 대체

    # ─────────────────────────────────────────
    # Node.js
    # ─────────────────────────────────────────
    volta

    # ─────────────────────────────────────────
    # AWS / DevOps
    # ─────────────────────────────────────────
    awscli2
    terraform
  ];

  # ═══════════════════════════════════════════════════════════
  # Homebrew (Nix에 없는 GUI 앱)
  # ═══════════════════════════════════════════════════════════
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";  # 선언 안 된 앱 자동 삭제
    };

    taps = [
      # 폰트는 이제 homebrew-cask에 통합됨
    ];

    brews = [
      "mas"  # Mac App Store CLI
      "openjdk@17" # Java for React Navtive
      "gemini-cli" # Gemini
      "railway" # Python deploy
    ];

    casks = [
      # ─────────────────────────────────────────
      # 터미널
      # ─────────────────────────────────────────
      "ghostty"

      # ─────────────────────────────────────────
      # 에디터 / IDE
      # ─────────────────────────────────────────
      "sublime-text"
      "zed"
      "opencode-desktop"
      "cursor"

      # ─────────────────────────────────────────
      # 개발 도구
      # ─────────────────────────────────────────
      "docker-desktop"
      "insomnia"
      "android-studio"
      "figma"
      "android-platform-tools"
      "apidog"

      # ─────────────────────────────────────────
      # AI 도구
      # ─────────────────────────────────────────
      "claude"
      "claude-code"
      "chatgpt"

      # ─────────────────────────────────────────
      # 브라우저
      # ─────────────────────────────────────────
      "zen"
      "google-chrome"

      # ─────────────────────────────────────────
      # 생산성
      # ─────────────────────────────────────────
      "raycast"
      "notion"
      "slack"
      "itsycal"
      "obsidian"
      "linear-linear"

      # ─────────────────────────────────────────
      # 폰트
      # ─────────────────────────────────────────
      "font-jetbrains-mono-nerd-font"
    ];

    masApps = {
      # mas search <app> 으로 ID 확인
      "KakaoTalk" = 869223134;
      "Xcode" = 497799835;
    };
  };

  # ═══════════════════════════════════════════════════════════
  # macOS 시스템 설정
  # ═══════════════════════════════════════════════════════════
  system.defaults = {
    # ─────────────────────────────────────────
    # Dock
    # ─────────────────────────────────────────
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
      orientation = "right";
      tilesize = 48;
      show-recents = false;
      mru-spaces = false;
    };

    # ─────────────────────────────────────────
    # Finder
    # ─────────────────────────────────────────
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
    };

    # ─────────────────────────────────────────
    # 키보드 / 입력
    # ─────────────────────────────────────────
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      ApplePressAndHoldEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      "com.apple.keyboard.fnState" = true;  # F1, F2 등을 표준 기능 키로 사용
    };

    # ─────────────────────────────────────────
    # 스크린샷
    # ─────────────────────────────────────────
    screencapture = {
      location = "~/Pictures/Screenshots";
      type = "png";
      disable-shadow = true;  # 그림자 제거
    };

    # ─────────────────────────────────────────
    # 단축키 (Spotlight 비활성화)
    # ─────────────────────────────────────────
    CustomUserPreferences = {
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          "64" = { enabled = false; };  # Cmd+Space (Spotlight) 비활성화
          "65" = { enabled = false; };  # Cmd+Alt+Space 비활성화
        };
      };
      # .DS_Store 파일 네트워크 드라이브에 생성 안 함
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
    };
  };

  # ═══════════════════════════════════════════════════════════
  # 보안 / 기타
  # ═══════════════════════════════════════════════════════════
  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = username;
  system.stateVersion = 5;
  networking.hostName = hostname;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}

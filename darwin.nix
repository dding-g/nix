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
    neovim
    lazygit
    jq
    yq
    gh        # GitHub CLI
    
    # ─────────────────────────────────────────
    # Node.js
    # ─────────────────────────────────────────
    nodejs_22
    pnpm
    
    # ─────────────────────────────────────────
    # AWS / DevOps
    # ─────────────────────────────────────────
    awscli2
    # terraform
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
      "homebrew/cask-fonts"
    ];
    
    brews = [
      "mas"  # Mac App Store CLI
    ];
    
    casks = [
      # ─────────────────────────────────────────
      # 터미널
      # ─────────────────────────────────────────
      "ghostty"
      
      # ─────────────────────────────────────────
      # 에디터 / IDE
      # ─────────────────────────────────────────
      "visual-studio-code"
      "cursor"
      
      # ─────────────────────────────────────────
      # 개발 도구
      # ─────────────────────────────────────────
      "docker"
      "postman"
      
      # ─────────────────────────────────────────
      # 브라우저
      # ─────────────────────────────────────────
      "arc"
      "google-chrome"
      
      # ─────────────────────────────────────────
      # 생산성
      # ─────────────────────────────────────────
      "raycast"
      "notion"
      "slack"
      
      # ─────────────────────────────────────────
      # 폰트
      # ─────────────────────────────────────────
      "font-jetbrains-mono-nerd-font"
    ];
    
    masApps = {
      # mas search <app> 으로 ID 확인
      "KakaoTalk" = 869223134;
      # "Xcode" = 497799835;
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
    };
    
    # ─────────────────────────────────────────
    # 트랙패드
    # ─────────────────────────────────────────
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
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

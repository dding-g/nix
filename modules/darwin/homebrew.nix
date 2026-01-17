{ ... }:

{
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
      "mackup"  # 앱 설정 백업/복원 (iCloud)
      "openjdk@17" # Java for React Navtive
      "gemini-cli" # Gemini
      "railway" # Python deploy
      "git-flow"
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
}

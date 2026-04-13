{ pkgs, lib, ... }:

{
  # ═══════════════════════════════════════════════════════════
  # 사용자 패키지
  # ═══════════════════════════════════════════════════════════
  home.packages = with pkgs; [
    httpie
    tldr
    tree

    # 커스텀 스크립트
    (writeShellScriptBin "wt" (builtins.readFile ../../scripts/wt))
  ];

  # ═══════════════════════════════════════════════════════════
  # fzf (Fuzzy Finder)
  # ═══════════════════════════════════════════════════════════
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # ═══════════════════════════════════════════════════════════
  # direnv (디렉토리별 환경변수)
  # ═══════════════════════════════════════════════════════════
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # ═══════════════════════════════════════════════════════════
  # zoxide (스마트 cd)
  # z <키워드>로 자주 가는 디렉토리 빠르게 이동
  # ═══════════════════════════════════════════════════════════
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # ═══════════════════════════════════════════════════════════
  # Glow (Markdown pager)
  # ═══════════════════════════════════════════════════════════
  home.file.".config/glow/glow.yml".text = ''
    style: "light"
  '';

  home.file.".config/opencode/opencode-notifier.json".text = builtins.toJSON {
    sound = false;
    notification = true;
    bell = false;
    timeout = 5;
    showProjectName = true;
    showSessionTitle = false;
    showIcon = true;
    suppressWhenFocused = true;
    enableOnDesktop = false;
    notificationSystem = "ghostty";
  };

  home.activation.ensureOpencodeNotifierPlugin = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config_dir="$HOME/.config/opencode"
    config_path="$config_dir/opencode.json"
    tmp_path="$(mktemp)"
    notifier_pkg="@mohak34/opencode-notifier@0.2.2"

    mkdir -p "$config_dir"

    if [ -f "$config_path" ]; then
      ${pkgs.jq}/bin/jq --arg notifier_pkg "$notifier_pkg" '
        .plugin =
          (if (.plugin | type) == "array" then .plugin else [] end)
          | if index($notifier_pkg) then . else . + [$notifier_pkg] end
      ' "$config_path" > "$tmp_path"
      mv "$tmp_path" "$config_path"
    else
      cat > "$config_path" <<EOF
{
  "\$schema": "https://opencode.ai/config.json",
  "plugin": ["$notifier_pkg"]
}
EOF
    fi
  '';
}

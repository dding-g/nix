{ username, hostname, ... }:

{
  # ═══════════════════════════════════════════════════════════
  # Nix 설정 (Determinate Nix 사용 시 비활성화)
  # ═══════════════════════════════════════════════════════════
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;

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

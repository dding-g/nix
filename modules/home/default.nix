{ ... }:

{
  imports = [
    ./git.nix
    ./shell.nix
    ./starship.nix
    ./programs.nix
  ];

  home.stateVersion = "24.05";

  # ═══════════════════════════════════════════════════════════
  # Mackup 설정 (앱 설정 백업/복원용)
  # ═══════════════════════════════════════════════════════════
  home.file.".mackup.cfg".text = ''
    [storage]
    engine = icloud
    directory = Mackup

    [applications_to_ignore]
    insomnia
    zsh
    starship
    git
    mackup
    cursor
    lazygit
    macosx
  '';
}

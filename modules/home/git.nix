{ ... }:

{
  # ═══════════════════════════════════════════════════════════
  # Git
  # ═══════════════════════════════════════════════════════════
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "dding-g";
        email = "area409@gmail.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      core.editor = "nvim";

      # ─────────────────────────────────────────
      # Delta (더 예쁜 diff)
      # ─────────────────────────────────────────
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "Catppuccin Mocha";
      };
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --oneline --graph --all";
      };
    };
  };
}

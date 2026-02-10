{ pkgs, ... }:

{
  # ═══════════════════════════════════════════════════════════
  # tmux
  # ═══════════════════════════════════════════════════════════
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    prefix = "C-a";
    baseIndex = 1;           # 윈도우 번호 1부터 시작
    escapeTime = 0;          # ESC 딜레이 제거 (vim 사용 시 필수)
    historyLimit = 50000;
    mouse = true;
    keyMode = "vi";
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank                   # 시스템 클립보드 복사
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"
        '';
      }
    ];

    extraConfig = ''
      # ─────────────────────────────────────────
      # True color 지원
      # ─────────────────────────────────────────
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -ag terminal-overrides ",xterm-ghostty:RGB"

      # ─────────────────────────────────────────
      # 윈도우/패인 분할
      # ─────────────────────────────────────────
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # ─────────────────────────────────────────
      # 패인 이동 (vim 스타일)
      # ─────────────────────────────────────────
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # ─────────────────────────────────────────
      # 패인 크기 조정
      # ─────────────────────────────────────────
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # ─────────────────────────────────────────
      # 설정 리로드
      # ─────────────────────────────────────────
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # ─────────────────────────────────────────
      # 기타
      # ─────────────────────────────────────────
      set -g renumber-windows on     # 윈도우 닫으면 번호 재정렬
      set -g set-clipboard on        # 클립보드 연동
      set -g focus-events on         # 포커스 이벤트 전달

      # 상태바 위치
      set -g status-position top
    '';
  };
}

{ pkgs, ... }:

{
  # ═══════════════════════════════════════════════════════════
  # tmux
  # ═══════════════════════════════════════════════════════════
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    prefix = "C-Space";
    baseIndex = 1;           # 윈도우 번호 1부터 시작
    escapeTime = 0;          # ESC 딜레이 제거 (vim 사용 시 필수)
    historyLimit = 50000;
    mouse = true;
    keyMode = "vi";
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank                   # 시스템 클립보드 복사
      resurrect              # 세션 저장/복원
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      # battery, cpu는 catppuccin + status-right 설정 이후에 실행해야 interpolation 됨
      # → extraConfig 하단에서 수동 run-shell
      {
        plugin = catppuccin;
        extraConfig = ''
          # ─────────────────────────────────────────
          # Catppuccin 테마
          # ─────────────────────────────────────────
          set -g @catppuccin_flavor "latte"
          set -g @catppuccin_status_background "default"

          # 윈도우 스타일
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_text " #W"
          set -g @catppuccin_window_current_text " #W"
          set -g @catppuccin_window_flags "icon"

          # 모듈별 커스터마이징
          set -g @catppuccin_date_time_text " %m/%d %H:%M"
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
      # 상태바
      # ─────────────────────────────────────────
      set -g status-position top
      set -g status-interval 5
      set -g status-left-length 100
      set -g status-right-length 100
      # #{E:@...} 형식 필수 - E: 없으면 format string이 그대로 출력됨
      set -g   status-left  "#{E:@catppuccin_status_session}"
      set -g   status-right "#{E:@catppuccin_status_directory}"
      set -agF status-right "#{E:@catppuccin_status_battery}"
      set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -ag  status-right "#{E:@catppuccin_status_date_time}"

      # battery/cpu 플러그인은 status-right에서 #{battery_icon} 등을 치환하는 방식이므로
      # catppuccin + status-right 설정 이후에 실행해야 정상 동작함
      run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux

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
    '';
  };
}

{ config, lib, pkgs, ... }:

{
   programs.tmux = {
    enable = true;
    shortcut = "a"; # Use Ctrl-a
    baseIndex = 1;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    aggressiveResize = false;
    historyLimit = 100000;
    resizeAmount = 5;
    escapeTime = 0;
    clock24 = true;
    terminal = "screen-256color";

    extraConfig = ''
      set-option -g display-time 2000
      set-option -g display-panes-time 3000

      # Status Bar
      set-option -g status-interval 1
      set-option -g status-right ` #(whoami)@#H :: %H:%M%p`
      set-option -g status-fg default

      # Set Solarized light theme
      set -g @colors-solarized 'light'

      set -g @sidebar-tree-command 'tree -C'


      # more plugins on https://github.com/tmux-plugins
      # hit prefix + I to fetch the plugin and source it. The plugin will automatically start "working" in the background, no action required.
      # set -g @plugin 'tmux-plugins/tmux-open'
      # set -g @plugin 'tmux-plugins/tmux-sidebar'
      set -g @plugin 'tmux-plugins/tmux-yank'
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'seebi/tmux-colors-solarized'
      run '~/.tmux/plugins/tpm/tpm'

      # bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
      # bind -n WheelDownPane select-pane -t= \; send-keys -M
      # bind -n C-WheelUpPane select-pane -t= \; copy-mode -e \; send-keys -M
      # bind -T copy-mode-vi    C-WheelUpPane   send-keys -X halfpage-up
      # bind -T copy-mode-vi    C-WheelDownPane send-keys -X halfpage-down
      # bind -T copy-mode-emacs C-WheelUpPane   send-keys -X halfpage-up
      # bind -T copy-mode-emacs C-WheelDownPane send-keys -X halfpage-down
      # setw -g mode-keys vi
      # unbind -T copy-mode-vi Enter
      # bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -selection c"
      # bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"

    '';

  };
}

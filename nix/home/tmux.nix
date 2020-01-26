{ config, lib, pkgs, ... }:

{
   programs.tmux = {
    enable = true;
    shortcut = "a"; # Use Ctrl-a
    baseIndex = 1; # Widows numbers begin with 1
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    aggressiveResize = true;
    historyLimit = 100000;
    resizeAmount = 5;
    escapeTime = 0;

    extraConfig = ''
      set -g default-terminal "screen-256color"
      # rebind prefix key to C-a
      set -g prefix C-a
      unbind-key C-b
      bind C-a send-prefix
      set -g mouse on
      set -g set-clipboard external

      set -g default-command /usr/bin/zsh
      set -g default-shell /usr/bin/zsh
      set-option -g history-limit 999999999
      set -g base-index 1
      set-option -g allow-rename off
      set -g pane-base-index 1

      bind-key C-r source-file ~/.tmux.conf\; display "reloaded!"
      ## for toggle synchronizing panes
      bind-key C-s set-window-option synchronize-panes
      
      set-option -g display-time 2000
      set-option -g display-panes-time 3000

      # Status Bar
      set-option -g status-interval 1
      set-option -g status-left \'\'
      set-option -g status-right \' #(whoami)@#H :: %H:%M%p'
      #set-window-option -g window-status-current-style green
      set-option -g status-fg default

      # Status Bar solarized-dark (default)
      set-option -g status-style bg=black
      set-option -g pane-active-border-style fg=green
      set-option -g pane-border-style fg=blue

      set -g @sidebar-tree-command 'tree -C'

      # last saved environment is automatically restored when tmux is started
      #set -g @continuum-restore 'on'

      # more plugins on https://github.com/tmux-plugins
      # hit prefix + I to fetch the plugin and source it. The plugin will automatically start "working" in the background, no action required.
      set -g @plugin 'tmux-plugins/tmux-open'
      set -g @plugin 'tmux-plugins/tmux-sidebar'
      set -g @plugin 'tmux-plugins/tmux-yank'
      run '~/.tmux/plugins/tpm/tpm'


      bind -T root MouseUp2Pane paste
      bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
      bind -n WheelDownPane select-pane -t= \; send-keys -M
      bind -n C-WheelUpPane select-pane -t= \; copy-mode -e \; send-keys -M
      bind -T copy-mode-vi    C-WheelUpPane   send-keys -X halfpage-up
      bind -T copy-mode-vi    C-WheelDownPane send-keys -X halfpage-down
      bind -T copy-mode-emacs C-WheelUpPane   send-keys -X halfpage-up
      bind -T copy-mode-emacs C-WheelDownPane send-keys -X halfpage-down
      setw -g mode-keys vi
      unbind -T copy-mode-vi Enter
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -selection c"
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"



      # Fix environment variables
      set-option -g update-environment "SSH_AUTH_SOCK \
                                        SSH_CONNECTION \
                                        DISPLAY"
      # Use default shell
      set-option -g default-shell ''${SHELL}
      # set -g default-terminal "xterm-24bit"
    '';

  };
}

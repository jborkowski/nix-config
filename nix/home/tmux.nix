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
    secureSocket = false;

    extraConfig = ''
      set-option -g display-time 2000
      set-option -g display-panes-time 3000

      # Status Bar
      set-option -g status-interval 1
      set-option -g status-right ` #(whoami)@#H :: %H:%M%p`
      set-option -g status-fg default

      set-option -g @online_icon "#[fg=#86dc2f]● online#[fg=default]"
      set-option -g @offline_icon "#[fg=#e0211d]●	offline#[fg=default]"
      set-option -g clock-mode-colour '#57557f'
      set-option -g message-command-style 'bg=#262626,fg=#b2b2b2'
      set-option -g message-style 'bg=#262626,fg=#b2b2b2'
      set-option -g mode-style 'bg=#444444,fg=#b2b2b2'
      set-option -g pane-border-style 'fg=#111111'
      set-option -g pane-active-border-style 'fg=#111111'
      set-option -g status-left ' #S '
      set-option -g status-left-style 'bg=#fdab08,fg=#121212'
      set-option -g status-right ' #{online_status} #[bg=#57557f] %Y/%m/%d %a %H:%M '
      set-option -g status-right-style 'bg=#121212,fg=#b2b2b2'
      set-option -g status-style 'bg=#121212,fg=#b2b2b2'
      set-option -g window-status-activity-style 'bg=#121212,fg=#d75fd7'
      set-option -g window-status-current-format ' #I#F| #W '
      set-option -g window-status-current-style 'bg=#57557f,fg=#b2b2b2'
      set-option -g window-status-format '#[fg=#585858] #I |#[fg=default] #W '
      set-option -g window-status-separator ''''''
      set-option -g window-status-style 'bg=#121212,fg=#b2b2b2'

      # Set Solarized dark theme
      # set -g @colors-solarized 'dark'

      set -g @sidebar-tree-command 'tree -C'

      # more plugins on https://github.com/tmux-plugins
      # hit prefix + I to fetch the plugin and source it. The plugin will automatically start "working" in the background, no action required.
      set -g @plugin 'tmux-plugins/tmux-open'
      # set -g @plugin 'tmux-plugins/tmux-sidebar'
      set -g @plugin 'tmux-plugins/tmux-yank'
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'seebi/tmux-colors-solarized'
      set -g @plugin 'christoomey/vim-tmux-navigator'
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

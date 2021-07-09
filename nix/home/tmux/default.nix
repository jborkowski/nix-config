{ config, pkgs, ... }:

let
 plugins = pkgs.tmuxPlugins  // pkgs.callPackage ./custom-plugins.nix {};
 tmuxConf = builtins.readFile ./default.conf;
in
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

    plugins = with plugins; [
      cpu
      nord # theme
    ];

    extraConfig = tmuxConf;

 };
}

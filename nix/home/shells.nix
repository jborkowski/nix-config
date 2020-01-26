{ config, lib, pkgs, ... }:

let
  shellAliases = {
    l = "exa";
    ls = "exa";
    copy = "xclip -i -selection clipboard";
    g = "git";
    e = "eval $EDITOR";
    ee = "e (fzf)";
    download = "aria2c --file-allocation=none --seed-time=0";
  };
in
{
  home.packages = with pkgs; [
    # Programs used by shell config defined below.
    exa
    aria
    nodePackages.castnow
  ];

  programs.broot = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    inherit shellAliases;
  };

  programs.bash = {
    enable = true;
    historyIgnore = [ "l" "ls" "cd" "exit" ];
    historyControl = [ "erasedups" ];
    enableAutojump = true;
    inherit shellAliases;
    initExtra = ''
    if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh;
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
    fi # added by Nix installer
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
}

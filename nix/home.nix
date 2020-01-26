{ config, pkgs, ...}:

let
  allPlatformImports = [
    ./home/git.nix
    ./home/haskell.nix
    ./home/shells.nix
    ./home/tmux.nix
  ];
  linuxImports = [
    ./home/i3.nix
    ./home/gpg.nix
    ./home/udiskie.nix
  ];
in
{
  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  # Utility functions
  _module.args = {
    fetchGH = fq: rev: builtins.fetchTarball ("https://github.com/" + fq + "/archive/" + rev + ".tar.gz");
  };

  imports = if builtins.currentSystem == "x86_64-linux"
            then (allPlatformImports ++ linuxImports)
            else allPlatformImports;

  home.packages = with pkgs; [
    # Basic tools
    htop
    file

    # Dev tools
    (callPackage ./nvim.nix {})
    gnumake
    ripgrep
    tmux
    gitAndTools.hub
    zlib
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
  };

}

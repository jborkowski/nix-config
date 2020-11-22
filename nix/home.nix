{ config, pkgs, ...}:

let
  allPlatformImports = [
    ./home/git.nix
    ./home/haskell.nix
    ./home/shells.nix
    ./home/tmux.nix
    ./emacs

  ];
  fetchGH = fq: rev: builtins.fetchTarball ("https://github.com/" + fq + "/archive/" + rev + ".tar.gz");
in rec {
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };
  programs.tmux.secureSocket = false;

  home = {
    username = "jobo";
    homeDirectory = "/User/jobo";
  };

  # Utility functions
  _module.args = {
    inherit fetchGH;
  };

  imports = allPlatformImports;

  home.packages = with pkgs; [
    # Basic tools
    htop
    file
    coreutils
    zlib
    tree

    # langToolsEnv
    direnv
    global
    gnumake
    m4
    rtags
    sloccount

    # Dev tools
    (callPackage ./nvim {inherit fetchGH;})
    ripgrep
    tmux
    sqlite
    niv
    nixops
    metals

    # networkToolsEnv
    dnsutils
    httpie
    iperf
    mitmproxy
    openvpn
    pdnsd
    rsync
    sipcalc
    wget
    znc

    # jsToolsEnv
    # Move this to own file
    jq
    nodejs
    nodePackages.eslint
    nodePackages.csslint
    nodePackages.js-beautify
    nodePackages.prettier
    nodePackages.purescript-language-server
    nodePackages.parcel-bundler
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
    TMUX_TMPDIR = "/tmp";
  };

  programs.home-manager = {
    enable = true;
    path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
  };
  home.stateVersion = "20.09";


}

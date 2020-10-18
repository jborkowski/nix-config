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
  nixpkgs.config.allowUnfree = true;
  programs.tmux.secureSocket = false;

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
    valgrind
    wabt

    # Dev tools
    (callPackage ./nvim {inherit fetchGH;})
    ripgrep
    tmux
    sqlite
    nixops

    # networkToolsEnv
    cacert
    dnsutils
    go-jira
    httpie
    httrack
    iperf
    lftp
    mitmproxy
    mtr
    nmap
    openvpn
    pdnsd
    rsync
    sipcalc
    wget
    znc

    # jsToolsEnv
    jq
    jo
    nodejs
    nodePackages.eslint
    nodePackages.csslint
    nodePackages.js-beautify
    nodePackages.prettier
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
    TMUX_TMPDIR = "/tmp";
  };

  programs.home-manager = {
    enable = true;
    path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
  };
  home.stateVersion = "20.03";


}

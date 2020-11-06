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
#    valgrind
    wabt

    # Dev tools
    (callPackage ./nvim {inherit fetchGH;})
    ripgrep
    tmux
    sqlite
    niv
#    nixops

    # networkToolsEnv
 #   cacert
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

    dejavu_fonts
    emacs-all-the-icons-fonts
    #emojione
    fantasque-sans-mono
    fira-code
    font-awesome-ttf
   # google-fonts
    hack-font
    hasklig
    iosevka
    noto-fonts-emoji
    powerline-fonts
    material-icons

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
  home.stateVersion = "20.09";


}

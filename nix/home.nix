{ config, pkgs, ...}:

let
  allPlatformImports = [
    ./home/git.nix
    ./home/haskell.nix
    ./home/shells.nix
    ./home/tmux.nix
    ./home/i3.nix
    ./home/vscode.nix
    ./home/irc.nix
    (import ./home/emacs {inherit pkgs; })
    ./scripts.nix
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

    # langToolsEnv
    direnv
    global
    gnumake
    htmlTidy
    m4
    rtags
    sloccount
    valgrind
    wabt


    # Dev tools
    (callPackage ./home/nvim { inherit fetchGH; })
    ripgrep
    tmux
    sqlite
    stow
    nixops
    idea.idea-community
    sbt

    # gitToolsEnv
    diffstat
    diffutils
    gist
    git-lfs
    gitRepo
    gitAndTools.git-crypt
    gitAndTools.git-hub
    gitAndTools.git-imerge
    gitAndTools.gitFull
    gitAndTools.gitflow
    gitAndTools.hub
    gitAndTools.tig
    gitAndTools.topGit
    gitAndTools.git-annex-remote-rclone
    gitAndTools.git-secret
    gitstats
    patch
    patchutils
    sift
    travis

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

    # editor
    vscode

    # communication
    slack
    protonmail-bridge
    discord

    # cloud
    nextcloud-client

    # office
    libreoffice

    # pdf
    mupdf

    # ebook - epub
    calibre

    # flash cards
    anki

    # video
    vlc

    # file manager
    ranger

    tree
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
    TMUX_TMPDIR = "/tmp";
    QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
    QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
  };

  programs.home-manager = {
    enable = true;
  };


  home.stateVersion = "20.03";


}

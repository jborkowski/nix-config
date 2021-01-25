{ config, pkgs, ...}:

let
    terminal = [
        (import ./home/alacritty { fontSize = 6; inherit pkgs; })
        ./home/shells.nix
        ./home/tmux.nix
    ];
    editor  = [
        (import ./home/emacs { inherit pkgs; })
        (import ./home/vscode.nix { inherit pkgs; } )
    ];
    wm = [
        ./home/i3.nix
    ];
    misc = [
        ./home/git.nix
        ./home/irc.nix
        ./scripts.nix
    ];
    dev = [
        ./home/haskell.nix
    ];

    fetchGH = fq: rev: builtins.fetchTarball ("https://github.com/" + fq + "/archive/" + rev + ".tar.gz");
in rec {
  nixpkgs.config.allowUnfree = true;

  # Utility functions
  _module.args = {
    inherit fetchGH;
  };

  imports = terminal ++ editor ++ wm ++ misc ++ dev;

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;

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
    # sbt
    dbeaver

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
    iperf
    lftp
    rsync

    # jsToolsEnv
    jq
    jo
    nodejs
    nodePackages.eslint
    nodePackages.csslint
    nodePackages.js-beautify
    nodePackages.prettier
    nodePackages.purescript-language-server
    nodePackages.parcel-bundler

    # communication
    #slack
    #protonmail-bridge
    #discord

    # cloud
    nextcloud-client

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

    pavucontrol

    streamlink
    streamlink-twitch-gui-bin

    # teams
  ];

  home = {
    username = "jobo";
    homeDirectory = "/home/jobo";
    stateVersion = "20.09";
 
    sessionVariables = {
      EDITOR = "emacs";
      TMUX_TMPDIR = "/tmp";
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    };
  };
  programs.home-manager = {
    enable = true;
  };
}

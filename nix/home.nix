{ config, pkgs, ...}:

let
  laptopBar = pkgs.callPackage ./home/polybar/bar.nix {
    font0 = 14;
    font1 = 16;
    font2 = 30;
    font3 = 25;
    font4 = 6;
  };

  myspotify = import ../spotify/default.nix {
    opts = "-force-device-scale-factor=1.4 %U";
    inherit pkgs;
  };

  statusBar = import ./home/polybar {
    inherit config pkgs;
    mainBar = laptopBar;
    openCalendar = "${pkgs.gnome3.gnome-calendar}/bin/gnome-calendar";
  };


  terminal = [
      (import ./home/alacritty { fontSize = 8; inherit pkgs; })
      ./home/zsh
      ./home/tmux
  ];
  editor  = [
      (import ./home/emacs { inherit pkgs; })
      (import ./home/vscode { inherit pkgs; } )
  ];
  wm = [
      ./home/xmonad
      statusBar
  ];
  misc = [
      ./home/rofi
      ./home/git
      ./home/irc
      ./home/networkmanager
      ./home/udiskie
      ./scripts.nix
  ];
  dev = [
      ./home/haskell
  ];


  defaultPkgs = with pkgs; [
    _1password
    _1password-gui

    anki

    htop

    coreutils
    zlib
    chromium

    nextcloud-client

    protonmail-bridge

    streamlink
    streamlink-twitch-gui-bin

    arandr               # simple GUI for xrandr
    asciinema            # record the terminal
    audacious            # simple music player
    cachix               # nix caching
    calibre              # e-book reader
    dconf2nix            # dconf (gnome) files to nix converter
    discord              # chat client
    dmenu                # application launcher
    docker-compose       # docker manager
    dive                 # explore docker layers
    duf                  # disk usage/free utility
    element-desktop      # a feature-rich client for Matrix.org
    exa                  # a better `ls`
    fd                   # "find" for files
    gimp                 # gnu image manipulation program
    gnomecast            # chromecast local files
    hyperfine            # command-line benchmarking tool
    jitsi-meet-electron  # open source video calls and chat
    killall              # kill processes by name
    libreoffice          # office suite
    libnotify            # notify-send command
    multilockscreen      # fast lockscreen based on i3lock
    ncdu                 # disk space info (a better du)
    neofetch             # command-line system information
    ngrok-2              # secure tunneling to localhost
    nix-doc              # nix documentation search tool
    nix-index            # files database for nixpkgs
    nixos-generators     # nix tool to generate isos
    nyancat              # the famous rainbow cat!
    manix                # documentation searcher for nix
    pavucontrol          # pulseaudio volume control
    paprefs              # pulseaudio preferences
    pasystray            # pulseaudio systray
    playerctl            # music player controller
    prettyping           # a nicer ping
    pulsemixer           # pulseaudio mixer
    ripgrep              # fast grep
    rnix-lsp             # nix lsp server
    signal-desktop       # signal messaging client
    simplescreenrecorder # self-explanatory
    slack                # messaging client
    spotify              # music source
    tdesktop             # telegram messaging client
    tldr                 # summary of a man page
    tree                 # display files in a tree view
    vlc                  # media player
    xclip                # clipboard support (also for neovim)

    # fixes the `ar` error required by cabal
    binutils-unwrapped
  ];

  polybarPkgs = with pkgs; [
    font-awesome-ttf      
    material-design-icons 
  ];

  xmonadPkgs = with pkgs; [
    networkmanager_dmenu
    networkmanagerapplet
    nitrogen               
    xcape                  
    xorg.xkbcomp           
    xorg.xmodmap           
    xorg.xrandr
    xorg.xbacklight 
  ];

  gnomePkgs = with pkgs.gnome3; [
    eog            # image viewer
    evince         # pdf reader
    gnome-calendar # calendar
    nautilus       # file manager
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
    direnv
    global
    gnumake
    rtags
    sloccount


    (callPackage ./home/nvim { inherit fetchGH; })
    ripgrep
    tmux
    sqlite
    stow
    nixops
    # sbt
    dbeaver

    cacert
    dnsutils
    iperf
    rsync

    jq
    jo
    nodejs
    nodePackages.eslint
    nodePackages.csslint
    nodePackages.js-beautify
    nodePackages.prettier
    nodePackages.purescript-language-server
    nodePackages.parcel-bundler

 ] ++ defaultPkgs ++ gnomePkgs ++ polybarPkgs ++ xmonadPkgs;


  home = {
    username = "jobo";
    homeDirectory = "/home/jobo";
    stateVersion = "21.05";
 
    sessionVariables = {
      DISPLAY = ":0";
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

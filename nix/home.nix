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
in rec {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowUnsupportedSystem = false;
    };

    overlays =
      let path = ../overlays; in with builtins;
      map (n: import (path + ("/" + n)))
          (filter (n: match ".*\\.nix" n != null ||
                      pathExists (path + ("/" + n + "/default.nix")))
                  (attrNames (readDir path)));
  };

  programs.home-manager.enable = true;
  programs.tmux.secureSocket = false;

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
    coreutils
    zlib
    emacs

    # langToolsEnv
    direnv
    global
    gnumake
    htmlTidy
    m4
    idutils
    rtags
    sloccount
    valgrind
    wabt

    # Dev tools
    (callPackage ./nvim.nix {})
    ripgrep
    tmux
    sqlite
    stow

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
    aria2
    backblaze-b2
    bazaar
    cacert
    dnsutils
    go-jira
    httpie
    httrack
    iperf
    lftp
    mercurialFull
    mitmproxy
    mtr
    nmap
    openssh
    openssl
    openvpn
    pdnsd
    rclone
    rsync
    sipcalc
    spiped
    w3m
    wget
    wireguard
    wireshark
    znc

    ditaa
    dot2tex
    doxygen
    ffmpeg
    figlet
    fontconfig
    graphviz-nox
    groff
    highlight
    hugo
    inkscape.out
    librsvg
    plantuml
    poppler_utils
    # recoll
    # qpdf
    perlPackages.ImageExifTool
    libxml2
    libxslt
    sdcv
    sourceHighlight
    svg2tikz
    taskjuggler
    texFull
    xapian
    xdg_utils
    yuicompressor

    # jsToolsEnv
    jq
    jo
    nodejs
    nodePackages.eslint
    nodePackages.csslint
    nodePackages.js-beautify
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
    TMUX_TMPDIR = "/tmp";
  };

}

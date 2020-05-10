{ config, pkgs, ...}:

let
  allPlatformImports = [
    ./home/git.nix
    ./home/haskell.nix
    ./home/shells.nix
    ./home/tmux.nix
  ];
  fetchGH = fq: rev: builtins.fetchTarball ("https://github.com/" + fq + "/archive/" + rev + ".tar.gz");
in rec {
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
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
    emacs

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
    (callPackage ./nvim {inherit fetchGH;})
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
    # nodePackages.standarx
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TMUX_TMPDIR = "/tmp";
  };

}

{ config, pkgs, ...}:

let

  terminal = [
      ./home/zsh
      ./home/tmux
  ];
  
  editor  = [
  #  (import ./home/emacs { inherit pkgs; })
  #  (import ./home/vscode { inherit pkgs; } )
  ];
  
  misc = [
      ./home/git
  ];
 
  dev = [
      ./home/haskell
  ];

  defaultPkgs = with pkgs; [
    anki

    htop

    coreutils
    direnv
    global
    gnumake
    rtags

    (callPackage ./home/nvim { inherit fetchGH; })
    tmux
    sqlite
    stow
    # nixops
    dbeaver

    cacert
    dnsutils
    iperf
    rsync

    jq
    nodejs
    nodePackages.eslint
    nodePackages.csslint
    nodePackages.js-beautify
    nodePackages.prettier
    nodePackages.purescript-language-server
    nodePackages.parcel-bundler

    asciinema            # record the terminal
    cachix               # nix caching
    docker-compose       # docker manager
    dive                 # explore docker layers
    element-desktop      # a feature-rich client for Matrix.org
    exa                  # a better `ls`
    fd                   # "find" for files
    hyperfine            # command-line benchmarking tool
    killall              # kill processes by name
    ncdu                 # disk space info (a better du)
    neofetch             # command-line system information
    ngrok-2              # secure tunneling to localhost
    nix-doc              # nix documentation search tool
    nix-index            # files database for nixpkgs
    nixos-generators     # nix tool to generate isos
    nyancat              # the famous rainbow cat!
    manix                # documentation searcher for nix
    prettyping           # a nicer ping
    pulsemixer           # pulseaudio mixer
    ripgrep              # fast grep
    rnix-lsp             # nix lsp server
    tldr                 # summary of a man page
    tree                 # display files in a tree view
  ];

    fetchGH = fq: rev: builtins.fetchTarball ("https://github.com/" + fq + "/archive/" + rev + ".tar.gz");
in rec {
  nixpkgs.config.allowUnfree = true;

  # Utility functions
  _module.args = {
    inherit fetchGH;
  };

  imports = terminal ++ editor ++ misc ++ dev;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = defaultPkgs;

  home = {
    username = "jobo";
    homeDirectory = "/Users/jobo";
    stateVersion = "21.11";
 
    sessionVariables = {
      EDITOR = "emacs";
      TMUX_TMPDIR = "/tmp";
    };
  };

  programs.home-manager = {
    enable = true;
  };
}

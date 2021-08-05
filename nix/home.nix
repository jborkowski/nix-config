{ config, pkgs, ... }:

let

  terminal = [ ./home/zsh ./home/tmux ];

  editor = [
    (import ./home/emacs { inherit pkgs; })
    ./home/nvim
    #  (import ./home/vscode { inherit pkgs; } )
  ];

  misc = [ ./home/git ];

  dev = [ ./home/haskell ];

  defaultPkgs = with pkgs; [
    ag
    anki
    cacert
    direnv
    rtags
    htop

    tmux
    sqlite
    stow
    nixfmt
    # nixops
    dbeaver
    fira-code-symbols
    fira-code

    jq
    nodejs
    nodePackages.eslint
    nodePackages.csslint
    nodePackages.js-beautify
    nodePackages.prettier
    nodePackages.purescript-language-server
    nodePackages.parcel-bundler

    asciinema # record the terminal
    cachix # nix caching
    docker-compose # docker manager
    dive # explore docker layers
    exa # a better `ls`
    fd # "find" for files
    hyperfine # command-line benchmarking tool
    killall # kill processes by name
    ncdu # disk space info (a better du)
    neofetch # command-line system information
    ngrok-2 # secure tunneling to localhost
    nix-doc # nix documentation search tool
    nix-index # files database for nixpkgs
    nixos-generators # nix tool to generate isos
    nyancat # the famous rainbow cat!
    manix # documentation searcher for nix
    ripgrep # fast grep
    rnix-lsp # nix lsp server
    tldr # summary of a man page
    tree # display files in a tree view
  ];

in rec {
  nixpkgs.config.allowUnfree = true;

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

  programs.home-manager = { enable = true; };
}

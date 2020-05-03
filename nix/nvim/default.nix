{ pkgs ? import <nixpkgs> {}, ... }:

let
  customPlugins = {
    neovim-ghcid = pkgs.vimUtils.buildVimPlugin {
      name = "ghcid";
      src = (pkgs.fetchFromGitHub {
        owner = "ndmitchell";
        repo = "ghcid";
        rev = "5d7f859bc6dd553bdf93e6453391353cf310e232";
        sha256 = "1gyasmk6k2yqlkny27wnc1fn2khphgv400apfh1m59pzd9mdgsc2";
      }) + "/plugins/nvim";
    };

     psc-ide-vim = pkgs.vimUtils.buildVimPlugin {
       pname = "psc-ide-vim";
       version = "2019-09-17";
       src = pkgs.fetchFromGitHub {
         owner = "frigoeu";
         repo = "psc-ide-vim";
         rev = "5fb4e329e5c0c7d80f0356ab4028eee9c8bd3465";
         sha256 = "0gzbxsq6wh8d9z9vyrff4hdpc66yg9y8hnxq4kjrz9qrccc75c1f";
       };
       meta.homepage = "https://github.com/frigoeu/psc-ide-vim/";
     };

    papercolor-theme = pkgs.vimUtils.buildVimPlugin {
      name = "papercolor-theme";
      src = pkgs.fetchFromGitHub {
        owner = "NLKNguyen";
        repo = "papercolor-theme";
        rev = "ddd0986";
        sha256 = "1dhbnd99xs6l5alqhn9m1nynmr9sbvrqj2137l23ysisprl3rgmr";
      };
    };

    indenthaskell = pkgs.vimUtils.buildVimPlugin {
      name = "indenthaskell";
      src = pkgs.fetchFromGitHub {
        owner = "vim-scripts";
        repo = "indenthaskell.vim";
        rev = "17380713774ea4f3ca5da1de455126fa1cce82f7";
        sha256 = "1cs9qkn40fk3c8a9kvbdm3d6izf944awiagpmllkvlb4ci9m6lk7";
      };
    };

    nerdtree = pkgs.vimUtils.buildVimPlugin {
      name = "nerdtree";
      src = pkgs.fetchFromGitHub {
        owner = "scrooloose";
        repo = "nerdtree";
        rev = "e47e588705bd7d205a3b5a60ac7090c9a2504ba2";
        sha256 = "15ai00k7w0brbjvmsj920hpnqy4iz1y3b0pw04m3mlcx20pkfy9s";
      };
    };

    lastpos = pkgs.vimUtils.buildVimPlugin {
      name = "lastpos";
      src = pkgs.fetchFromGitHub {
        owner = "vim-scripts";
        repo = "lastpos.vim";
        rev = "21a22ce4a11117cae8a0017c1cd9a9094fe5adf2";
        sha256 = "0b4xd87a8pxhdf6g8digvjc1a83y572qk4qfdccda2r5m4knidm4";
      };
    };

    vim-jsx = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "vim-jsx";
      src = pkgs.fetchgit {
        url = "git://github.com/mxw/vim-jsx";
        rev = "8879e0d9c5ba0e04ecbede1c89f63b7a0efa24af";
        sha256 = "0czjily7kjw7bwmkxd8lqn5ncrazqjsfhsy3sf2wl9ni0r45cgcd";
      };
    };

    yajs-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
       name = "yajs.vim";
       src = pkgs.fetchFromGitHub {
         owner = "othree";
         repo = "yajs.vim";
         rev = "437be4ccf0e78fe54cb482657091cff9e8479488";
         sha256 = "157q2w2bq1p6g1wc67zl53n6iw4l04qz2sqa5j6mgqg71rgqzk0p";
       };
    };

    commentary-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
       name = "commentary.vim";
       src = pkgs.fetchFromGitHub {
         owner = "tpope";
         repo = "vim-commentary";
         rev = "f8238d70f873969fb41bf6a6b07ca63a4c0b82b1";
         sha256 = "09d81q9na7pvvrmxxqy09ffdzsx5v5dikinb704c9wm4ys2bidr9";
       };
    };

    neocomplcache = pkgs.vimUtils.buildVimPlugin {
      name = "neocomplcache";
      src = pkgs.fetchFromGitHub {
        owner = "Shougo";
        repo = "neocomplcache.vim";
        rev = "778181767467b8f8016828898779a646074d883a";
        sha256 = "080h24fqv9gsv9ny33gxzsy03w9wyx1xw8f1xwqyll9c6hw62ygy";
      };
    };
  };
in
  with pkgs; neovim.override {
    configure = {
      # Builtin packaging
      # List of plugins: nix-env -qaP -A nixos.vimPlugins
      packages.myVimPackage = with pkgs.vimPlugins; {
        # Loaded on launch
        start = [ ];
        # Manually loadable by calling `:packadd $plugin-name
        opt = [ ];
      };

      # VAM
      vam.knownPlugins = pkgs.vimPlugins // customPlugins;
      vam.pluginDictionaries = [
        { name = "goyo"; }                # Distraction free writing
        { name = "vim-auto-save"; }       # Automatically saves changes to dis
        { name = "vim-nix"; }             # Support for writing Nix expressions in vim
        { name = "haskell-vim"; }         # It’s the filetype plugin for Haskell that should ship with Vim.
        { name = "vim-gitgutter"; }       # A Vim plugin which shows a git diff
        { name = "vim-orgmode"; }         # Orgmode
        { name = "ctrlp"; }               #
        { name = "coc-nvim"; }
        { name = "vim-airline"; }
        { name = "vim-airline-themes"; }
        { name = "ctrlp-py-matcher"; }
        { name = "indenthaskell"; }
        { name = "nerdtree"; }
        { name = "lastpos"; }
        { name = "fugitive"; }
        { name = "tslime"; }
        { name = "neocomplete"; }
        { name = "fzf-vim"; }
        { name = "fzfWrapper"; }
        { name = "neovim-ghcid"; }
        { name = "vim-multiple-cursors"; }
        { name = "nerdcommenter"; }
        { name = "vim-tmux-navigator"; }
        { name = "vim-trailing-whitespace"; }
        { name = "vim-markdown"; }
        { name = "vim-stylish-haskell"; }
        { name = "ack-vim"; }
        { name = "vim-jsx"; }
        { name = "auto-pairs"; }
        { name = "yajs-vim"; }
        { name = "commentary-vim"; }
        { name = "semshi"; }
        { name = "purescript-vim"; }
        { name = "psc-ide-vim"; }
      ];

      pathogen.knownPlugins = vimPlugins;
      pathogen.pluginNames = ["vim-colors-solarized"];

      customRC = builtins.readFile ./config.vim  + builtins.readFile ./config-coc.vim + builtins.readFile ./base16-spacemacs.vim ;

    };
  }

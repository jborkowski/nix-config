{ buildVimPlugin, buildVimPluginFrom2Nix, fetchFromGitHub }:

{
    vim-ripgrep = buildVimPlugin {
        name = "vim-ripgrep";
        src = builtins.fetchTarball {
        name   = "RipGrep-v1.0.2";
        url    = "https://github.com/jremmen/vim-ripgrep/archive/v1.0.2.tar.gz";
        sha256 = "1by56rflr0bmnjvcvaa9r228zyrmxwfkzkclxvdfscm7l7n7jnmh";
        };
    };
    fzf-hoogle = buildVimPlugin {
        name = "fzf-hoogle-vim";
        src = builtins.fetchTarball {
        name   = "fzf-hoogle-vim-v2.3.0";
        url    = "https://github.com/monkoose/fzf-hoogle.vim/archive/v2.3.0.tar.gz";
        sha256 = "00ay9250wdl8ym70dpv4zbs49g40dla6i48bk1zl95lp62kld4hr";
        };
    };
    nvim-metals = buildVimPluginFrom2Nix {
        name = "nvim-metals";
        src  = fetchFromGitHub {
        owner  = "scalameta";
        repo   = "nvim-metals";
        rev    = "69a5cf9380defde5be675bd5450e087d59314855";
        sha256 = "1kjr7kgwvg1c4gglipmasvpyrk4gar4yi9kd8xdfqyka9557vyy9";
        };
    };
    neovim-ghcid = buildVimPluginFrom2Nix {
      name = "ghcid";
      src = (fetchFromGitHub {
        owner  = "ndmitchell";
        repo   = "ghcid";
        rev    = "5d7f859bc6dd553bdf93e6453391353cf310e232";
        sha256 = "1gyasmk6k2yqlkny27wnc1fn2khphgv400apfh1m59pzd9mdgsc2";
      }) + "/plugins/nvim";
    };

     psc-ide-vim = buildVimPluginFrom2Nix {
       pname = "psc-ide-vim";
       version = "2019-09-17";
       src = fetchFromGitHub {
         owner = "frigoeu";
         repo = "psc-ide-vim";
         rev = "5fb4e329e5c0c7d80f0356ab4028eee9c8bd3465";
         sha256 = "0gzbxsq6wh8d9z9vyrff4hdpc66yg9y8hnxq4kjrz9qrccc75c1f";
       };
       meta.homepage = "https://github.com/frigoeu/psc-ide-vim/";
     };

    papercolor-theme = buildVimPluginFrom2Nix {
      name = "papercolor-theme";
      src = fetchFromGitHub {
        owner = "NLKNguyen";
        repo = "papercolor-theme";
        rev = "ddd0986";
        sha256 = "1dhbnd99xs6l5alqhn9m1nynmr9sbvrqj2137l23ysisprl3rgmr";
      };
    };

    indenthaskell = buildVimPluginFrom2Nix {
      name = "indenthaskell";
      src = fetchFromGitHub {
        owner = "vim-scripts";
        repo = "indenthaskell.vim";
        rev = "17380713774ea4f3ca5da1de455126fa1cce82f7";
        sha256 = "1cs9qkn40fk3c8a9kvbdm3d6izf944awiagpmllkvlb4ci9m6lk7";
      };
    };

    nerdtree = buildVimPluginFrom2Nix {
      name = "nerdtree";
      src = fetchFromGitHub {
        owner = "scrooloose";
        repo = "nerdtree";
        rev = "e47e588705bd7d205a3b5a60ac7090c9a2504ba2";
        sha256 = "15ai00k7w0brbjvmsj920hpnqy4iz1y3b0pw04m3mlcx20pkfy9s";
      };
    };

    lastpos = buildVimPluginFrom2Nix {
      name = "lastpos";
      src = fetchFromGitHub {
        owner = "vim-scripts";
        repo = "lastpos.vim";
        rev = "21a22ce4a11117cae8a0017c1cd9a9094fe5adf2";
        sha256 = "0b4xd87a8pxhdf6g8digvjc1a83y572qk4qfdccda2r5m4knidm4";
      };
    };

    yajs-vim = buildVimPluginFrom2Nix {
       name = "yajs.vim";
       src = fetchFromGitHub {
         owner = "othree";
         repo = "yajs.vim";
         rev = "437be4ccf0e78fe54cb482657091cff9e8479488";
         sha256 = "157q2w2bq1p6g1wc67zl53n6iw4l04qz2sqa5j6mgqg71rgqzk0p";
       };
    };

    commentary-vim = buildVimPluginFrom2Nix {
       name = "commentary.vim";
       src = fetchFromGitHub {
         owner = "tpope";
         repo = "vim-commentary";
         rev = "f8238d70f873969fb41bf6a6b07ca63a4c0b82b1";
         sha256 = "09d81q9na7pvvrmxxqy09ffdzsx5v5dikinb704c9wm4ys2bidr9";
       };
    };

    neocomplcache = buildVimPluginFrom2Nix {
      name = "neocomplcache";
      src = fetchFromGitHub {
        owner = "Shougo";
        repo = "neocomplcache.vim";
        rev = "778181767467b8f8016828898779a646074d883a";
        sha256 = "080h24fqv9gsv9ny33gxzsy03w9wyx1xw8f1xwqyll9c6hw62ygy";
      };
    };
}
{ config, lib, pkgs, ... }:

let
  shellAliases = {
    l = "exa";
    ls = "exa";
    g = "git";
    e = "eval $EDITOR";
    ee = "e (fzf)";
  };
in
{
  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = rec {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = false;
    enableAutosuggestions = true;

    history = {
      size = 50000000;
      save = 50000000;
      path = "${dotDir}/history";
      ignoreDups = true;
      share = true;
    };

    shellAliases = {
      vim = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      custom = "${dotDir}/functions";
      plugins = ["git" "brew" "cabal" "docker" "docker-compose" "emacs" "gitignore"];
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
    ];

    localVariables = {
      PATH="$HOME/.local/bin:/usr/local/bin:$HOME/.cabal/bin:/Users/jobo/.ghcup/bin:$PATH";
      NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels";
    };

  };
  
  programs.autojump.enable = true;

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration  = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration  = true;
  };

  programs.jq = {
    enable = true;
  };
}

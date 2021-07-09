{ config, lib, pkgs, ... }:

let
  shellAliases = {
    l = "exa";
    ls = "exa";
    copy = "xclip -i -selection clipboard";
    g = "git";
    e = "eval $EDITOR";
    ee = "e (fzf)";
  };
in
{
  programs.broot = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = rec {
    enable = true;
    dotDir = "${config.xdg.dataHome}/.config/zsh";
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
      plugins = ["git" "rbenv" "gitignore" "sbt" "scala" "mvn" "cp" "history" "rsync" "vagrant" ];
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

{ config, lib, pkgs, ... }:

let
  shellAliases = {
    l = "exa";
    ls = "exa";
    copy = "xclip -i -selection clipboard";
    g = "git";
    e = "eval $EDITOR";
    ee = "e (fzf)";
    download = "aria2c --file-allocation=none --seed-time=0";
  };
in
{
  home.packages = with pkgs; [
    # Programs used by shell config defined below.
    exa
    aria
    nodePackages.castnow
    direnv
  ];

  programs.broot = {
    enable = true;
    enableBashIntegration = true;
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

    # localVariables = ''
    #   NIX_IGNORE_SYMLINK_STORE=1
    #   PATH=$PATH:/nix/var/nix/profiles/default/bin
    # '';

    # loginShellInit = [
    #   ". $HOME/.nix-profile/etc/profile.d/nix.sh"
    # ];

    initExtra = ''
    export NIX_IGNORE_SYMLINK_STORE=1
    export PATH=$PATH:/nix/var/nix/profiles/default/bin:$HOME/.local/bin
    
    if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh;
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
    fi # added by Nix installer
    '';


    # interactiveShellInit = ''


  };
  

  programs.bash = {
    enable = true;
    historyIgnore = [ "l" "ls" "cd" "exit" ];
    historyControl = [ "erasedups" ];
    enableAutojump = true;
    inherit shellAliases;
    initExtra = ''
    if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh;
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
    fi # added by Nix installer
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration  = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration  = true;
  };

  programs.jq = {
    enable = true;
  };

}

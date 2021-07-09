{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "nvim";
    };
    init.defaultBranch = "main";
    merge.tool = "vimdiff";
    mergetool = {
      cmd    = "nvim -f -c \"Gvdiffsplit!\" \"$MERGED\"";
      prompt = false;
    };
    pull.rebase = false;
    protocol.keybase.allow = "always";
    submodule = {
      recurse = true;
    };
  };
in
{
  home.packages = with pkgs; [
  ];
 
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Jonatan Borkowski";
    userEmail = "jonatan.borkowski@pm.me";
    ignores = [
      "#*#"
      "*~"
      ".#*"
      "*.a"
      "*.aux"
      "*.dylib"
      "*.elc"
      "*.glob"
      "*.la"
      "*.o"
      "*.so"
      "*.v.d"
      "*.vo"
      "*~"
      ".clean"
      ".direnv"
      ".envrc"
      ".envrc.override"
      ".ghc.environment.x86_64-darwin-*"
      ".makefile"
      "TAGS"
      "cabal.project.local"
      "dist-newstyle"
      "result"
      "result-*"
      "tags"
      "*.bloop"
      "*.bsp"
      "*.metals"
      "*.metals.sbt"
      "*metals.sbt"
      "*hie.yaml"      # ghcide files
      "*.mill-version" # used by metals
      "*.jvmopts"      # should be local to every project
    ];
    aliases = {
      amend = "commit --amend -m";
      co    = "checkout";
      ci    = "commit";
      s     = "status";
      st    = "status";
      d     = "diff";
      pr    = "pull --rebase";
      l     = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
    };
    extraConfig = gitConfig;
  };
}

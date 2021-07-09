{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.ii
  ];

  programs.irssi = {
    enable = true;

    networks = {
      freenode = {
        nick = "jonatanb";
        server = {
          address = "chat.freenode.net";
          port = 6697;
          autoConnect = true;
        };
        channels = {
          nixos.autoJoin = true;
        };
      };
    };
  };
}


# Configuration for the eDP display of the MBP13 
{ config, lib, pkgs, stdenv, ... }:

let
  base = pkgs.callPackage ../../home.nix { inherit config lib pkgs stdenv; };

  laptopBar = pkgs.callPackage ../polybar/bar.nix {
    font0 = 15;
    font1 = 12;
    font2 = 24;
    font3 = 18;
    font4 = 10;
  };

  myspotify = import ../spotify/default.nix { opts = ""; inherit pkgs; };

  statusBar = import ../polybar/default.nix {
    inherit config pkgs;
    mainBar = laptopBar;
    openCalendar = "";
  };

  terminal = import ../alacritty/default.nix { fontSize = 10; inherit pkgs; };
in
{
  imports = [
    ../../home.nix
    statusBar
    terminal
  ];

  home.packages = base.home.packages ++ [ myspotify ];
}
{ config, lib, pkgs, ... }:
let
  nativeOnly = false;
  steam = pkgs.steam.override {
    extraPkgs = innerPkgs:
      with innerPkgs; [
        mono
        gtk3
        gtk3-x11
        libgdiplus
        zlib
        libffi
      ];
    inherit nativeOnly;
  };
in {

  home.packages = [
    (with pkgs; if nativeOnly then steam-run-native else steam-run)
    steam
  ];
}

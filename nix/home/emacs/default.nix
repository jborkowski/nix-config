{ pkgs, ... }:
let
  sources = import ../../sources.nix;
  doom-emacs = pkgs.callPackage sources.nix-doom-emacs {
    doomPrivateDir = ./doom.d;
  };
in {
  home.packages = [
    doom-emacs
    pkgs.ispell
    # (pkgs.callPackage ./xterm-24bit.nix {})
  ];
  home.file.".emacs.d/init.el".text = ''
     (load "default.el")
  '';
}
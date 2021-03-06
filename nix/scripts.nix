{ config, pkgs, ... }:

let
  mkScript = name: script: pkgs.writeScriptBin name
  ''
    #!${pkgs.runtimeShell}
    ${script}
  '';
  mkAlias = name: cli: mkScript name "exec ${cli}";
in
  {
    home.packages = with pkgs; [
      (mkAlias "screenshot" "${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png; ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -o > ~/Screenshots/Screenshot_$(date +%F-%H:%M:%S).png")
    ];
  }

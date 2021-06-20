{ config, pkgs, ... }:

{
  boot = {
    cleanTmpDir = true;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = false;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "monadic-killer";
    interfaces.wlo1.useDHCP = true;
    interfaces.eno2.useDHCP = true;
  };


}

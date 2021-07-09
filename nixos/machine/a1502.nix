{ config, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/apple/macbook-pro/12-1>
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    supportedFilesystems = [ "exfat" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [
      "hid_apple.swap_opt_cmd=1"
      "hid_apple.swap_fn_leftctrl=1"
    ];
  };

  networking = {
    hostName = "mbp13nixos";
    interfaces.wlp3s0.useDHCP = true;  
  };

  services = {
    # automatically change xrandr profiles on display change
    autorandr.enable = true;

    # monitor and manage CPU temp, throttling as needed
    thermald.enable = true;

    # monitor and control Macbook Pro fans
    mbpfan = {
      # see mbpfan.nix file in nixpkgs for extra config options
      enable = true;
      lowTemp = 61;
      highTemp = 64;
      maxTemp = 84;
    };

    # Remap what happens on power key press so it suspends rather than
    # shutting don immediately
    logind = {
      extraConfig = ''
        HandlePowerKey=suspend
      '';
    };
  };
}


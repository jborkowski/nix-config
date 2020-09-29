{ config, pkgs ? null , ... }:

let
  hostName = "monadic-killer";
  sources = import ../nix/sources.nix;
  nixos-hardware = import sources.nixos-hardware;
  nixpkgs = if pkgs == null then sources.nixpkgs else pkgs;
  lib = sources.nixpkgs + "/lib";
  home-manager = sources.home-manager + "/nixos";
  cpu_intel = sources.nixos-hardware + "/common/cpu/intel";
  ssd = sources.nixos-hardware + "/common/pc/ssd";
in {

  imports =
    [
      /etc/nixos/hardware-configuration.nix
      home-manager
      cpu_intel
      ssd
      ../nixos/asus-hardware.nix
      ../nixos/fonts.nix
      ../nixos/i3.nix
      ../nixos/caches.nix
      ../nixos/openvpn.nix
      ../nixos/postgresql.nix
    ];

  home-manager.users.jonatanb = (import ../nix/home.nix {
    inherit pkgs config hostName sources nixpkgs;
  } );

  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # EFI boot
  boot = {
    cleanTmpDir = true;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = false;
    # Always use the latest available kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import (import ../nix/sources.nix).emacs-overlay)
      (import (import ../nix/sources.nix).emacs-pgtk-nativecomp-overlay)
    ];
  };
  nix.trustedUsers = [ "root" "jonatanb" ];

  networking = {
    inherit hostName;
    wireless.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 22 ];
    };
    useDHCP = false;
    interfaces = {
      eno2.useDHCP = true;
      wlo1.useDHCP = true;
    };
  };

  virtualisation.docker.enable = true;
  security.apparmor.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  environment.systemPackages = with pkgs; [
    ntfs3g
    _1password
    _1password-gui
    chromium
    rxvt_unicode
  ];

  environment.interactiveShellInit = ''
    alias vim='nvim'
  '';

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.openssh = {
    enable = true;
    ports = [22];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "pl";
  # services.xserver.xkbOptions = "eurosign:e";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonatanb = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "lxd" ];
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}


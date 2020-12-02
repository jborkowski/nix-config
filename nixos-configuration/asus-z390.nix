{ config, pkgs ? null , ... }:

let
  hostName = "monadic-killer";
  sources = import ../nix/sources.nix;
  nurpkgs = import sources.nixpkgs { };
  nurNoPkgs = import sources.NUR { inherit pkgs nurpkgs; };
  nixos-hardware = import sources.nixos-hardware;
  nixpkgs = if pkgs == null then sources.nixpkgs else pkgs;
  lib = sources.nixpkgs + "/lib";
  home-manager = sources.home-manager + "/nixos";
  cpu_intel = sources.nixos-hardware + "/common/cpu/intel";
  ssd = sources.nixos-hardware + "/common/pc/ssd";
  full_urxvt_unicode = pkgs.rxvt-unicode.override { configure = { availablePlugins, ... }: {
    plugins = with availablePlugins; [ perls resize-font perl ];
    };
  };

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
      ../nixos/yubikey.nix
    ];

  location = {
    latitude = 52.229676;
    longitude = 21.012229;
  };

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
  };

  # Nix daemon config
  nix = {
    # Automate `nix-store --optimise`
    autoOptimiseStore = true;

    # Automate garbage collection
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };

    # Avoid unwanted garbage collection when using nix-direnv
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
    '';

    # Required by Cachix to be used as non-root user
    trustedUsers = [ "root" "jonatanb" ];
  };

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
    google-chrome
    full_urxvt_unicode
    clipmenu
    nurNoPkgs.repos.onny.foliate
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

  services.clipmenu.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonatanb = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "lxd" ];
    shell = pkgs.zsh;
  };

  services.redshift = {
    enable = true;
    brightness = {
      # Note the string values below.
      day = "1";
      night = "1";
    };
    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}


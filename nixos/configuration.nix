{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./machine/z390.nix
      ./wm/xmonad.nix
      ./ledger.nix
    ];

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    # Enables wireless support and openvpn via network manager.
    networkmanager = {
      enable   = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };

  environment = {
    # List packages installed in system profile.
    systemPackages = with pkgs; [
      # basic
      wget lsof vim feh redshift

      # services
      light powertop lm_sensors networkmanagerapplet
      brightnessctl playerctl

      chromium tdesktop slack
      _1password _1password-gui nextcloud-client
    ];
  };

  programs.gnupg.agent = {
    enable           = true;
    enableSSHSupport = true;
  };

  powerManagement = {
    powertop.enable = true;
  };

  networking.firewall.enable = false;

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };


  services = {
    openssh = {
      enable = true;
      allowSFTP = true;
    };

    sshd.enable = true;

    # monitor and manage CPU temp, throttling as needed
    thermald.enable = true;

    # Enable dbus + dconf to manage system dialogs
    dbus = {
      enable = true;
      socketActivated = true;
      packages = with pkgs; [ gnome3.dconf ];
    };

    # Enable printing with Brother drivers
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint gutenprintBin brlaser ];
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_11;
      enableTCPIP = true;

      authentication = ''
        local all all trust
        host all all 0.0.0.0/0 trust
      '';
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;

    fontconfig = {
      enable = true;
      antialias = true;
      useEmbeddedBitmaps = true;

      defaultFonts = {
        serif = [ "Source Serif Pro" "DejaVu Serif" ];
        sansSerif = [ "Source Sans Pro" "DejaVu Sans" ];
        monospace = [ "Fira Code" "Hasklig" ];
      };
    };

    fonts = with pkgs; [
      hasklig
      source-code-pro
      overpass
      nerdfonts
      fira
      fira-code
      fira-code-symbols
      fira-mono

      noto-fonts-emoji

      # For fish powerline plugin
      powerline-fonts
      nerdfonts
      terminus_font
      emacs-all-the-icons-fonts
      font-awesome-ttf
      google-fonts
      hack-font
      iosevka
    ];
  };

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  # Hardware options
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    bluetooth = {
      enable = true;
      config = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    ledger.enable = true;
  };

  users.groups.plugdev = {};

  # Define a user account.
  users.users.jobo = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "video" "docker" "plugdev" ];
    createHome = true;
    uid = 1000;
    shell = pkgs.zsh;
  };

  users.extraGroups.vboxusers.members = [ "jobo" ];
  
  nix = {
    trustedBinaryCaches = [
      "https://hydra.iohk.io"
      "https://iohk.cachix.org"
      "https://cachix.cachix.org"
      "https://nixcache.reflex-frp.org"
      "https://all-hies.cachix.org"
      "https://srid.cachix.org"
    ];

    binaryCachePublicKeys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
      "srid.cachix.org-1:MTQ6ksbfz3LBMmjyPh0PLmos+1x+CdtJxA/J2W+PQxI="
    ];
    
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
    trustedUsers = [ "root" "jobo" ];

  };

  nixpkgs.config = {
    allowUnfree = true;
  }
;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}


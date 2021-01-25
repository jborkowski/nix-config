{ config, pkgs, ... }:

{
  imports =
    [ ./a1502-hardware.nix
      <nixos-hardware/apple/macbook-pro/12-1>
      ../redshift.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.supportedFilesystems = [ "exfat" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPatches = [
    { name = "hid-apple-keyboard"; patch = ./hid-apple-keyboard.patch; }
  ];
  boot.kernelParams = [
    "hid_apple.swap_opt_cmd=1"
    "hid_apple.swap_fn_leftctrl=1"
  ];

  networking.hostName = "mbp13nixos";
  networking.networkmanager.enable = true;
 
  time.timeZone = "Europe/Warsaw";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  environment = {
    variables.EDITOR = "emacs";

    # List packages installed in system profile.
    systemPackages = with pkgs; [
      # basic
      wget lsof vim feh redshift

      # services
      light powertop lm_sensors networkmanagerapplet
      brightnessctl playerctl

      chromium tdesktop 
      _1password _1password-gui nextcloud-client
    ];
  };

  powerManagement = {
    # run powertop --auto-tune on startup
    powertop.enable = true;
  };

  # List services that you want to enable:

  services = {
    openssh.enable = true;

    # automatically change xrandr profiles on display change
    autorandr.enable = true;

    # bluetooth control
    blueman.enable = true;
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

    # Enable dbus + dconf to manage system dialogs
    dbus = {
      packages = with pkgs; [ gnome3.dconf ];
    };

    # Remap what happens on power key press so it suspends rather than
    # shutting don immediately
    logind = {
      extraConfig = ''
        HandlePowerKey=suspend
      '';
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

    # Enable the X11 windowing system
    xserver = {
      enable = true;
      autorun = true;
      dpi = 192;
      layout = "pl";

      xkbOptions = "caps:escape";
      # support external monitors via DisplayPort in addition to the
      # default screen eDP (use `xrandr` to list)
      xrandrHeads = [ "eDP" "DisplayPort-0" ];

      desktopManager = {
        xterm.enable = false;
      };

      displayManager.defaultSession = "none+i3";

      displayManager.lightdm = {
        enable = true;
      };

      displayManager = {
        autoLogin.enable = false;
        autoLogin.user = "jobo";
        sessionCommands = ''
          feh --bg-fill ${./wallpapers/pexels-magda-ehlers-1599452.jpg}
          nm-applet &
          telegram-desktop &
          1password &
          nextcloud --background &
        '';
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };


      # Enable touchpad support
      libinput = {
        enable = true;
        naturalScrolling = true;
      };
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

  # Hardware options
  sound.enable = true;
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
  };

  # Define a user account.
  users.extraUsers.jobo = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "video" ];
    createHome = true;
    uid = 1000;
  };

  nix.trustedBinaryCaches = [
     "https://hydra.iohk.io"
     "https://cachix.cachix.org"
     "https://nixcache.reflex-frp.org"
     "https://all-hies.cachix.org"
     "https://srid.cachix.org"
  ];

  nix.binaryCachePublicKeys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
    "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
    "srid.cachix.org-1:MTQ6ksbfz3LBMmjyPh0PLmos+1x+CdtJxA/J2W+PQxI="
  ];

   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "jobo" ];
  # Allow unfree packages system-wide. To allow access to unfree packages
  # in nix-env, also set:
  #
  # ~/.config/nixpkgs/config.nix to { allowUnfree = true; }
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
  system.stateVersion = "20.09"; # Did you read the comment?

}


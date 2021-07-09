{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    # Enable dbus + dconf to manage system dialogs
    dbus = {
      enable = true;
      socketActivated = true;
      packages = with pkgs; [ gnome3.dconf ];
    };

    # Enable the X11 windowing system
    # Screen is 13,3" at 2560x1440 (16:9), so 28.65x17.9cm. Using
    # steps of 25% from the standard 96dpi, the closest we get is
    # 225% or 227dpi (28.65x17.9cm reported by xdpyinfo).
    # https://wiki.archlinux.org/index.php/Xorg#Setting_DPI_manually
    # Display size: 11.28" × 7.05" = 79.5in² (28.65cm × 17.9cm = 512.91cm²) at 226.98 PPI, 0.1119mm dot pitch, 51521 PPI²
    # https://www.sven.de/dpi/
 
    xserver = {
      enable = true;

      autorun = true;
      dpi = 227;

      xkbOptions = "caps:escape";

      # support external monitors via DisplayPort in addition to the
      # default screen eDP (use `xrandr` to list)
      xrandrHeads = [ "eDP" "DisplayPort-0" ];

      layout = "pl";

      libinput = {
        enable = true;
        naturalScrolling = true;
        touchpad.disableWhileTyping = true;
      };

      serverLayoutSection = ''
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime"     "0"
      '';

      displayManager = {
        autoLogin.enable = false;
        autoLogin.user = "jobo";
        defaultSession = "none+xmonad";
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  systemd.services.upower.enable = true;
}
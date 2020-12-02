{ config, pkgs, ...}:

{
  services = {
    gnome3.gnome-keyring.enable = true;

    dbus = {
      enable = true;
      socketActivated = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    xserver = {
      enable = true;

      startDbusSession = true;

      layout = "pl";
      xkbOptions = "caps:escape";

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
      autoRepeatInterval = 80;
      autoRepeatDelay = 220;
      libinput.naturalScrolling = true;
      displayManager = {
        autoLogin = { enable = false; user = "jonatanb"; };
        defaultSession = "none+i3";
        sessionCommands = ''

        xrdb -merge <(python3 ${./PyURxvtMeta8})

        xrdb "${./xresources}"
        nextcloud --background &

      '';
      };

      desktopManager = {
        # To make home-manager's i3 available in system X session
        # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/8
        session = [
          {
            name = "home-manager";
            start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
          }
        ];
        xterm.enable = false;
      };
    };
  };
}

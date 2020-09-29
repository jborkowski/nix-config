{ config, pkgs, ...}:

{
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    autoRepeatInterval = 50;
    autoRepeatDelay = 50;
    libinput.naturalScrolling = true;
    displayManager = {
      defaultSession = "none+i3";
      sessionCommands = ''
        xrdb "${./xresources}"
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
}

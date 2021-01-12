{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  xsession.scriptPath = ".hm-xsession"; # Ref: https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/8
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = mod;

      fonts = ["DejaVu Sans Mono, FontAwesome 6"];

      keybindings = lib.mkOptionDefault {
        "${mod}+p"        = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+x"        = "exec screenshot";
        "${mod}+Shift+x"  = "exec lockscreen";
        "${mod}+Return"   = "exec alacritty";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Split
        "${mod}+b" = "split h";
        "${mod}+v" = "split v";

        # Toggle
        "${mod}+Shit+space" = "floating toggle";
        "${mod}+space"      = "mode_toggle";

        # Emacs
        "${mod}+i" = "exec emacs -ib 16";

        # Pulse Audio controls
        "XF86AudioRaiseVolume"  = "exec --no-startup-id pactl set-sink-volume 0 +5%"; #increase sound volume
        "XF86AudioLowerVolume"  = "exec --no-startup-id pactl set-sink-volume 0 -5%"; #decrease sound volume
        "XF86AudioMute"         = "exec --no-startup-id pactl set-sink-mute 0 toggle"; # mute sound

        # Sreen brightness controls
        "XF86MonBrightnessUp"   = "exec brightnessctl set +4%"; # increase screen brightness
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-"; # decrease screen brightness

        # Media player controls
        "XF86AudioPlay"   = "exec playerctl play";
        "XF86AudioPause"  = "exec playerctl pause";
        "XF86AudioNext"   = "exec playerctl next";
        "XF86AudioPrev"   = "exec playerctl previous";

      };

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
        }
      ];
    };
    extraConfig = ''
      for_window [class="floating"] floating enable;
      for_window [class="1password"] floating enable;
    '';

  };
}

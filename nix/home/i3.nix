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
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+x" = "exec screenshot";
        "${mod}+Ctrl+x" = "exec screenshot-to-zettelkasten";
        "${mod}+Shift+x" = "exec lockscreen";

        "${mod}+c" = "exec ${pkgs.clipmenu}/bin/clipcopy";
        "${mod}+v" = "exec ${pkgs.clipmenu}/bin/clippaste";

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
        "${mod}+s"   = "split h";
        "${mod}+s+v" = "split v";
        
        # Emacs
        "${mod}+i"      = "exec emacsclient -c";
        "${mod}+Ctrl+i" = "exec pkill emacs && emacs --daemon && emacsclient -c";
        "${mod}+Shift+i" = "exec emacs -ib 16";
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

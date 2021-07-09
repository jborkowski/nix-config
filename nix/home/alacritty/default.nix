{ fontSize, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      background_opacity = 0.9;
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "#ffffff";
      };

      # Doom theme alacritty
      # https://user-images.githubusercontent.com/15976214/71608435-55326c00-2b4f-11ea-93e0-c99cd1aa7b9f.png
      colors = {
        primary = {
          background = "#282c34";
          foreground = "#bbc2cf";
        };
        normal = {
          black   = "#282c34";
          red     = "#ff6c6b";
          green   = "#98be65";
          yellow  = "#ecbe7b";
          blue    = "#51afef";
          magenta = "#c678dd";
          cyan    = "#46d9ff";
          white   = "#bbc2cf";
        };
      };
      font = {
        normal = { family = "FiraCode Nerd Font Mono"; };
        glyph_offset = {
          x = 0;
          y = -1;
        };
        use_thin_strokes = false;
        size = fontSize;
      };
      selection.save_to_clipboard = true;
      shell.program = "${pkgs.zsh}/bin/zsh";
      window = {
        decorations = "full";
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}

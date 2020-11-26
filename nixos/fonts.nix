{ config, lib, pkgs, ... }:

{
   fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      noto-fonts-emoji

      # For fish powerline plugin
      powerline-fonts
      nerdfonts

      #hermit
      source-code-pro
      terminus_font
      emacs-all-the-icons-fonts
      #fantasque-sans-mono
      fira-code
      fira-code-symbols
      font-awesome-ttf
      google-fonts
      hack-font
      hasklig
      nerdfonts
      iosevka
      #material-icons
    ];
  };
}

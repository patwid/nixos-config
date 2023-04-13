{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    roboto-mono
    hack-font
    font-awesome
  ];

  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Emoji" "Font Awesome" ];
      monospace = [ "Roboto Mono" "Hack" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };
}

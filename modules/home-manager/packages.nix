{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cage
    curl
    gnome.adwaita-icon-theme
    grim
    imagemagick
    imv
    jq
    libreoffice-fresh
    menu-pass
    menu-run
    pavucontrol
    ripgrep
    slurp
    sway-contrib.grimshot
    swaybg
    swaylock
    unzip
    whatsapp
    wl-clipboard
    xdg-open
    zip
  ];
}

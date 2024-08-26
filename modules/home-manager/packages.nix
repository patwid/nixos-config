{ pkgs, ... }:
{
  home.packages = with pkgs; [
    adwaita-icon-theme
    cage
    curl
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
    unzip
    whatsapp
    wl-clipboard
    xdg-open
    zip
  ];
}

{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  environment.defaultPackages = [ ];

  home-manager.users.${user.name} = {
    home.packages = with pkgs; [
      curl
      gnome.adwaita-icon-theme
      gnome.nautilus
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
      wl-clipboard
      xdg-open
      zip
    ];
  };
}

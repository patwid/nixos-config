{ lib, osConfig, pkgs, ... }:
let
  inherit (osConfig.nixpkgs) hostPlatform;
in
{
  home.packages = with pkgs; [
    adwaita-icon-theme
    cage
    curl
    grim
    imagemagick
    imv
    jq
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
  ] ++ lib.optionals (!lib.hasPrefix "aarch64" hostPlatform.system) [
    # Build failure on aarch64, see https://github.com/NixOS/nixpkgs/issues/339942
    libreoffice-fresh
  ];
}

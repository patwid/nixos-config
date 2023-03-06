{ config, lib, pkgs, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    home.packages = with pkgs; [
      curl
      imagemagick
      jq
      ripgrep
      unzip
      wget
      wl-clipboard
      zip
    ];

    programs.fzf.enable = true;
    programs.htop.enable = true;
  };
}

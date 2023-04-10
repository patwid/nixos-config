{ args, lib, pkgs, ... }:
let
  inherit (args) user;
in
{
  home-manager.users.${user} = {
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

{ lib, pkgs, ... }:
let
  user = import ./user.nix;
in {
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

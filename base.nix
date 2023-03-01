{ lib, pkgs, args, ... }:
{
  home-manager.users.${args.user} = {
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

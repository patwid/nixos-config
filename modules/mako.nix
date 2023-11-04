{ config, pkgs, ... }:
let
  inherit (config) user colors;
in
{
  home-manager.users.${user} = {
    home.packages = [ pkgs.libnotify ];

    services.mako = {
      enable = true;
      font = "sans-serif 10";
      icons = false;
      padding = "12";
      anchor = "bottom-right";
      width = 320;
      borderSize = 2;
      backgroundColor = colors.black;
      borderColor = colors.darkestGrey;
      progressColor = "over ${colors.red}"; # TODO: usage?
      textColor = colors.white;
    };
  };
}

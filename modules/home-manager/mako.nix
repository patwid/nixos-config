{ osConfig, pkgs, ... }:
let
  inherit (osConfig) colors;
in
{
  home.packages = [ pkgs.libnotify ];

  services.mako = {
    enable = true;
    icons = false;
    padding = "8";
    borderSize = 2;
    backgroundColor = colors.inverse.background;
    borderColor = colors.inverse.background;
    progressColor = "over ${colors.red}"; # TODO: usage?
    textColor = colors.inverse.foreground;
  };
}

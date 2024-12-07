{ osConfig, pkgs, ... }:
let
  inherit (osConfig) colors;
in
{
  home.packages = [ pkgs.libnotify ];

  services.mako = {
    enable = true;
    font = "monospace 10";
    icons = false;
    padding = "12";
    anchor = "bottom-right";
    width = 320;
    borderSize = 2;
    backgroundColor = colors.inverse.background;
    borderColor = colors.inverse.background;
    progressColor = "over ${colors.red}"; # TODO: usage?
    textColor = colors.inverse.foreground;
  };
}

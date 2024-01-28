{ nixosConfig, pkgs, ... }:
let
  inherit (nixosConfig) colors;
in
{
  home.packages = [ pkgs.libnotify ];

  services.mako = {
    enable = true;
    font = "sans-serif 10";
    icons = false;
    padding = "12";
    anchor = "bottom-right";
    width = 320;
    borderSize = 2;
    backgroundColor = colors.background;
    borderColor = colors.backgroundInactive;
    progressColor = "over ${colors.red}"; # TODO: usage?
    textColor = colors.foreground;
  };
}

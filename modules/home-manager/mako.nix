{ osConfig, pkgs, ... }:
let
  inherit (osConfig) colors;
in
{
  home.packages = [ pkgs.libnotify ];

  services.mako = {
    enable = true;
    settings = {
      font = "sans-serif 10";
      icons = "false";
      padding = "8";
      border-size = "2";
      background-color = colors.backgroundInactive;
      border-color = colors.backgroundInactive;
      progress-color = "over ${colors.red}"; # TODO: usage?
      text-color = colors.foreground;
    };
  };
}

{ config, pkgs, wrappers, ... }:
let
  inherit (config) colors;
in
wrappers.wrapperModules.mako.apply {
  inherit pkgs;
  settings = {
    font = "sans-serif 10";
    icons = "false";
    padding = "8";
    border-size = "1";
    background-color = colors.backgroundInactive;
    border-color = colors.backgroundActive;
    progress-color = "over ${colors.red}"; # TODO: usage?
    text-color = colors.foreground;
  };
}

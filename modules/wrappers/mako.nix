{
  inputs,
  config,
  pkgs,
  ...
}:
let
  inherit (inputs) wrappers;
  inherit (config) colors;
in
wrappers.wrappedModules.mako.wrap {
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

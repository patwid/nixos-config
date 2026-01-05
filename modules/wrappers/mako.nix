{ inputs, config, pkgs, ... }:
let
  inherit (inputs) wrappers;
  inherit (config) colors;
in
wrappers.wrapperModules.mako.wrap {
  inherit pkgs;
  # TODO: see https://github.com/BirdeeHub/nix-wrapper-modules/pull/112
  filesToPatch = [
    "share/dbus-1/services/fr.emersion.mako.service"
    "share/systemd/user/mako.service"
    "lib/systemd/user/mako.service"
  ];
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

{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (osConfig) work;
in
lib.mkIf (work.enable) {
  home.packages = with pkgs; [
    _1password
    mattermost
    medbase
    outlook
    rds
    sanacare
    smartaz
    teams
    teleport_16
  ];
}

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
    outlook
    rds
    smartaz
    teleport_16
    teams
  ];
}

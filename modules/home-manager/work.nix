{ osConfig, lib, pkgs, ... }:
let
  inherit (osConfig) work;
in
lib.mkIf (work.enable) {
  home.packages = with pkgs; [
    jtt
    mattermost
    outlook
    smartaz
    teleport
    teams
  ];
}

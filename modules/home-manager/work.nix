{ nixosConfig, lib, pkgs, ... }:
let
  inherit (nixosConfig) work;
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

{ config, lib, pkgs, ... }:
let
  inherit (config) user work;
in
{
  options.work = {
    enable = lib.mkEnableOption { };
    remote = lib.mkEnableOption { };
  };

  config = lib.mkIf (work.enable) {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        jtt
        mattermost
        outlook
        smartaz
        teleport
        teams
      ];
    };
  };
}

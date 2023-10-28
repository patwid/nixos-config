{ config, args, lib, pkgs, ... }:
let
  inherit (config) work;
  inherit (args) user;
in
{
  options.work = {
    enable = lib.mkEnableOption { };
    remote = lib.mkEnableOption { };
  };

  config = lib.mkIf (work.enable) {
    home-manager.users.${user} = {
      home.packages = with pkgs; [
        dbeaver
        jetbrains.idea-ultimate
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

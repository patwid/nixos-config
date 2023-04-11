{ config, args, lib, pkgs, ... }:
let
  inherit (args) user;
in
{
  options.work = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.work {
    home-manager.users.${user} = {
      home.packages = with pkgs; [
        citrix_workspace
        dbeaver
        jetbrains.idea-ultimate
        jtt
        mattermost
        outlook
        smartaz
        teams
      ];
    };
  };
}

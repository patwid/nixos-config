{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) work;
in
{
  options.work = {
    enable = lib.mkEnableOption { };
    remote = lib.mkEnableOption { };
  };

  config = lib.mkIf (work.enable) {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        _1password
        mattermost
        medbase
        outlook
        rds
        sanacare
        smartaz
        teams
        teleport_16
        ;
    };
  };
}

{ config, args, lib, ... }:
let
  inherit (args) user;
  inherit (config) home;

  fsType = "nfs";
  options = [ "nfsvers=3" ];
  nas = "192.168.0.3";
  syncthing = "192.168.0.5";
  transmission = "192.168.0.6";
in
{
  options.home = {
    enable = lib.mkEnableOption { };
    server = lib.mkEnableOption { };
  };

  config = lib.mkMerge [
    (lib.mkIf (home.enable) {
      fileSystems."/home/${user}/music" = {
        device = "${nas}:/mnt/tank/media/music";
        inherit fsType options;
      };

      fileSystems."/home/${user}/videos/movies" = {
        device = "${nas}:/mnt/tank/media/movies";
        inherit fsType options;
      };

      fileSystems."/home/${user}/videos/tv_shows" = {
        device = "${nas}:/mnt/tank/media/tv_shows";
        inherit fsType options;
      };

      networking.extraHosts = ''
        ${nas} nas.local
        ${syncthing} syncthing.local
        ${transmission} transmission.local
      '';
    })

    (lib.mkIf (home.server) {
      services.nfs.server.enable = true;
    })
  ];
}

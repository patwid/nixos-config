{ config, lib, ... }:
let
  inherit (config) user home;

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
      # TODO: enable nohide option on nfs export to mount music share instead of
      # subdirectories (lossless and lossy)
      fileSystems."/home/${user.name}/music/lossless" = {
        device = "${nas}:/mnt/tank/media/music/lossless";
        inherit fsType options;
      };

      fileSystems."/home/${user.name}/music/lossy" = {
        device = "${nas}:/mnt/tank/media/music/lossy";
        inherit fsType options;
      };

      fileSystems."/home/${user.name}/videos/movies" = {
        device = "${nas}:/mnt/tank/media/movies";
        inherit fsType options;
      };

      fileSystems."/home/${user.name}/videos/tv_shows" = {
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

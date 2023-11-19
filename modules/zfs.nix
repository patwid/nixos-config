{ args, config, lib, ... }:

let
  inherit (config) home;
in
lib.mkIf (home.server) {
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  boot.zfs.extraPools = [ "tank" ];

  # networking.hostId = hostId;

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
}

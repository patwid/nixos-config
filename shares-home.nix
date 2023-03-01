{ ... }:
let
  user = import ./user.nix;
  fsType = "nfs";
  options = [ "nfsvers=3" ];
in {
  fileSystems."/home/${user}/music" = {
    device = "192.168.0.3:/mnt/tank/media/music";
    inherit fsType options;
  };

  fileSystems."/home/${user}/videos/movies" = {
    device = "192.168.0.3:/mnt/tank/media/movies";
    inherit fsType options;
  };

  fileSystems."/home/${user}/videos/tv_shows" = {
    device = "192.168.0.3:/mnt/tank/media/tv_shows";
    inherit fsType options;
  };
}

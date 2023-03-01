{ ... }:
let
  user = import ./user.nix;
in {
  fileSystems."/home/${user}/music" = {
    device = "192.168.0.3:/mnt/tank/media/music";
    fsType = "nfs";
    options = [ "nfsvers=3" ];
  };

  fileSystems."/home/${user}/videos/movies" = {
    device = "192.168.0.3:/mnt/tank/media/movies";
    fsType = "nfs";
    options = [ "nfsvers=3" ];
  };

  fileSystems."/home/${user}/videos/tv_shows" = {
    device = "192.168.0.3:/mnt/tank/media/tv_shows";
    fsType = "nfs";
    options = [ "nfsvers=3" ];
  };
}

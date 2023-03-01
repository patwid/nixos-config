{ lib, pkgs, ... }:
let
  user = import ./user.nix;
  fsType = "cifs";
  options = [ ''noauto,user=patwid,domain=ERGON,uid=1000,gid=100'' ];
in {
  # Remove this once https://github.com/NixOS/nixpkgs/issues/34638 is resolved
  # request-key expects a configuration file under /etc
  environment.etc."request-key.conf" = lib.mkForce {
    text = let
      upcall = "${pkgs.cifs-utils}/bin/cifs.upcall";
      keyctl = "${pkgs.keyutils}/bin/keyctl";
    in ''
      #OP     TYPE          DESCRIPTION  CALLOUT_INFO  PROGRAM
      # -t is required for DFS share servers...
      create  cifs.spnego   *            *             ${upcall} -t %k
      create  dns_resolver  *            *             ${upcall} %k
      # Everything below this point is essentially the default configuration,
      # modified minimally to work under NixOS. Notably, it provides debug
      # logging.
      create  user          debug:*      negate        ${keyctl} negate %k 30 %S
      create  user          debug:*      rejected      ${keyctl} reject %k 30 %c %S
      create  user          debug:*      expired       ${keyctl} reject %k 30 %c %S
      create  user          debug:*      revoked       ${keyctl} reject %k 30 %c %S
      create  user          debug:loop:* *             |${pkgs.coreutils}/bin/cat
      create  user          debug:*      *             ${pkgs.keyutils}/share/keyutils/request-key-debug.sh %k %d %c %S
      negate  *             *            *             ${keyctl} negate %k 30 %S
    '';
  };

  fileSystems."/mnt/docs" = {
    device = "//fsdocs/docs";
    inherit fsType options;
  };

  fileSystems."/mnt/home" = {
    device = "//fshome/home";
    inherit fsType options;
  };

  fileSystems."/mnt/projects" = {
    device = "//fsprojects/projects";
    inherit fsType options;
  };

  fileSystems."/mnt/masters" = {
    device = "//fsmasters/masters";
    inherit fsType options;
  };

  fileSystems."/mnt/partner" = {
    device = "//fspartner/partner";
    inherit fsType options;
  };

  fileSystems."/mnt/data/pump" = {
    device = "//fsdata/data/pump";
    inherit fsType options;
  };

  fileSystems."/mnt/data/taifun" = {
    device = "//fsdata/data/taifun";
    inherit fsType options;
  };

  fileSystems."/mnt/usr2" = {
    device = "//fsusr2/usr2";
    inherit fsType options;
  };

  fileSystems."/mnt/hist" = {
    device = "//fshist/hist";
    inherit fsType options;
  };
}

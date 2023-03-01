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

  fileSystems."/docs" = {
    device = "//fsdocs/docs";
    inherit options fsType;
  };

  fileSystems."/ergon_home" = {
    device = "//fshome/home";
    inherit options fsType;
  };

  fileSystems."/projects" = {
    device = "//fsprojects/projects";
    inherit options fsType;
  };

  fileSystems."/masters" = {
    device = "//fsmasters/masters";
    inherit options fsType;
  };

  fileSystems."/partner" = {
    device = "//fspartner/partner";
    inherit options fsType;
  };

  fileSystems."/data/pump" = {
    device = "//fsdata/data/pump";
    inherit options fsType;
  };

  fileSystems."/data/taifun" = {
    device = "//fsdata/data/taifun";
    inherit options fsType;
  };

  fileSystems."/usr2" = {
    device = "//fsusr2/usr2";
    inherit options fsType;
  };

  fileSystems."/hist" = {
    device = "//fshist/hist";
    inherit options fsType;
  };
}

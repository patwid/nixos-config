{ config, lib, pkgs, ... }:
let
  inherit (config) user;
  fsType = "cifs";
  user' = config.users.users.${user.name};
  primary = config.users.users.${user.name}.group;
  group = config.users.groups.${primary};
  uid = if user'.uid == null then "1000" else toString user'.uid;
  gid = if group.gid == null then "100" else toString group.gid;
  options = [ ''noauto,user=${user.name},domain=ERGON,uid=${uid},gid=${gid}'' ];
in
{
  # Remove this once https://github.com/NixOS/nixpkgs/issues/34638 is resolved
  # request-key expects a configuration file under /etc
  environment.etc."request-key.conf" = lib.mkForce {
    text =
      let
        upcall = "${pkgs.cifs-utils}/bin/cifs.upcall";
        keyctl = "${pkgs.keyutils}/bin/keyctl";
      in
      ''
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

  system.activationScripts = {
    createMountDirs = ''
      mkdir -p /mnt/docs
      mkdir -p /mnt/home
      mkdir -p /mnt/projects
      mkdir -p /mnt/masters
      mkdir -p /mnt/partner
      mkdir -p /mnt/data/pump
      mkdir -p /mnt/data/taifun
      mkdir -p /mnt/usr2
      mkdir -p /mnt/hist
    '';
  };
}

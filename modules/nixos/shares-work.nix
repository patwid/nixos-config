{ config, lib, pkgs, ... }:
let
  inherit (config) user work;
in
lib.mkIf (work.enable) (lib.mkMerge [
  {
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

  (
    let
      fsType = "cifs";
      user' = config.users.users.${user.name};
      primary = config.users.users.${user.name}.group;
      group = config.users.groups.${primary};
      uid = if user'.uid == null then "1000" else toString user'.uid;
      gid = if group.gid == null then "100" else toString group.gid;
      options = [ ''noauto,user=${user.name},domain=ERGON,uid=${uid},gid=${gid}'' ];
    in
    lib.mkIf (work.remote) {
      # TODO: remove once https://github.com/NixOS/nixpkgs/issues/34638 is
      # resolved request-key expects a configuration file under /etc
      environment.etc."request-key.conf" = lib.mkForce {
        text =
          let
            upcall = lib.getExe' pkgs.cifs-utils "cifs.upcall";
            keyctl = lib.getExe' pkgs.keyutils "keyctl";
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
            create  user          debug:loop:* *             |${lib.getExe' pkgs.coreutils "cat"}
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
  )

  (
    let
      fsType = "nfs";
      # TODO: set required options
    in
    lib.mkIf (!work.remote) {
      fileSystems."/mnt/docs" = {
        device = "fsdocs:/docs";
        inherit fsType;
      };

      fileSystems."/mnt/home" = {
        device = "fshome:/home";
        inherit fsType;
      };

      fileSystems."/mnt/projects" = {
        device = "fsprojects:/projects";
        inherit fsType;
      };

      fileSystems."/mnt/masters" = {
        device = "fsmasters:/masters";
        inherit fsType;
      };

      fileSystems."/mnt/partner" = {
        device = "fspartner:/partner";
        inherit fsType;
      };

      fileSystems."/mnt/data/pump" = {
        device = "fsdata:/data/pump";
        inherit fsType;
      };

      fileSystems."/mnt/data/taifun" = {
        device = "fsdata:/data/taifun";
        inherit fsType;
      };

      fileSystems."/mnt/usr2" = {
        device = "fsusr2:/usr2";
        inherit fsType;
      };

      fileSystems."/mnt/hist" = {
        device = "fshist:/hist";
        inherit fsType;
      };
    }
  )
])

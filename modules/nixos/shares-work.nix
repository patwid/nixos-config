{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) user work;
in
lib.mkIf (work.enable) (
  let
    fsType = "cifs";
    user' = config.users.users.${user.name};
    primary = config.users.users.${user.name}.group;
    group = config.users.groups.${primary};
    uid = toString (user'.uid or 1000);
    gid = toString (group.gid or 100);
    options = [ "noauto,user=${user.name},domain=ERGON,uid=${uid},gid=${gid}" ];

    upcall = lib.getExe' pkgs.cifs-utils "cifs.upcall";
    keyctl = lib.getExe' pkgs.keyutils "keyctl";

    mounts = {
      "docs" = "//fsdocs/docs";
      "home" = "//fshome/home";
      "projects" = "//fsprojects/projects";
      "masters" = "//fsmasters/masters";
      "partner" = "//fspartner/partner";
      "data/pump" = "//fsdata/data/pump";
      "data/taifun" = "//fsdata/data/taifun";
      "usr2" = "//fsusr2/usr2";
      "hist" = "//fshist/hist";
    };
  in
  {
    system.activationScripts.createMountDirs =
      mounts |> lib.mapAttrsToList (name: _: "mkdir -p /mnt/${name}") |> lib.concatStringsSep "\n";

    # TODO: remove once https://github.com/NixOS/nixpkgs/issues/34638 is
    # resolved request-key expects a configuration file under /etc
    environment.etc."request-key.conf" = lib.mkForce {
      text = ''
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

    fileSystems =
      mounts
      |> lib.mapAttrs' (
        name: device: lib.nameValuePair "/mnt/${name}" { inherit device fsType options; }
      );
  }
)

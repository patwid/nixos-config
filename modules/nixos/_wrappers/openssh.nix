{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  formatValue =
    v:
    if builtins.isBool v then
      (if v then "yes" else "no")
    else if builtins.isInt v then
      toString v
    else
      v;

  formatMatchBlock =
    name: block:
    let
      lines = lib.mapAttrsToList (k: v: "  ${k} ${formatValue v}") block;
    in
    "Host ${name}\n${lib.concatStringsSep "\n" lines}";

  sshConfig = lib.concatStringsSep "\n\n" (
    lib.mapAttrsToList formatMatchBlock config.matchBlocks
  );
in
{
  imports = [ wlib.modules.default ];

  options = {
    enableDefaultConfig = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to include default SSH settings in a catch-all Host * block.";
    };

    matchBlocks = lib.mkOption {
      type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
      default = { };
      description = "SSH client match blocks. Keys are host patterns, values are attrsets of SSH directives.";
    };
  };

  config = {
    flags."-F" = config.constructFiles.config.path;

    package = lib.mkDefault pkgs.openssh;

    matchBlocks = lib.mkIf config.enableDefaultConfig {
      "*" = {
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
      };
    };

    constructFiles.config = {
      relPath = "ssh_config";
      content = sshConfig;
    };

    meta.maintainers = [ ];
  };
}

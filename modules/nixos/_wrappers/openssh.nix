{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  boolToYesNo = v: if v then "yes" else "no";

  formatMatchBlock =
    name: block:
    let
      lines =
        lib.optional (block.hostname != null) "  HostName ${block.hostname}"
        ++ lib.optional (block.user != null) "  User ${block.user}"
        ++ lib.optional (block.proxyJump != null) "  ProxyJump ${block.proxyJump}"
        ++ lib.optional (block.port != null) "  Port ${toString block.port}"
        ++ lib.optional (block.identityFile != null) "  IdentityFile ${block.identityFile}"
        ++ lib.optional (block.identitiesOnly) "  IdentitiesOnly yes"
        ++ [ "  ForwardAgent ${boolToYesNo block.forwardAgent}" ]
        ++ lib.optional (block.addKeysToAgent != null) "  AddKeysToAgent ${block.addKeysToAgent}"
        ++ [ "  Compression ${boolToYesNo block.compression}" ]
        ++ [ "  ServerAliveInterval ${toString block.serverAliveInterval}" ]
        ++ [ "  ServerAliveCountMax ${toString block.serverAliveCountMax}" ]
        ++ [ "  HashKnownHosts ${boolToYesNo block.hashKnownHosts}" ]
        ++ lib.optional (block.userKnownHostsFile != null) "  UserKnownHostsFile ${block.userKnownHostsFile}"
        ++ lib.optional (block.controlMaster != null) "  ControlMaster ${block.controlMaster}"
        ++ lib.optional (block.controlPath != null) "  ControlPath ${block.controlPath}"
        ++ lib.optional (block.controlPersist != null) "  ControlPersist ${block.controlPersist}"
        ++ map (o: "  ${o}") block.extraOptions;
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
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            hostname = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "The hostname to connect to.";
            };
            user = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "The user to log in as.";
            };
            proxyJump = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Proxy jump host.";
            };
            port = lib.mkOption {
              type = lib.types.nullOr lib.types.port;
              default = null;
              description = "The port to connect to.";
            };
            identityFile = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Path to the identity file.";
            };
            identitiesOnly = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Only use the specified identity file.";
            };
            forwardAgent = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Whether to forward the authentication agent.";
            };
            addKeysToAgent = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Whether to add keys to the agent. Values: yes, no, confirm, ask.";
            };
            compression = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Whether to enable compression.";
            };
            serverAliveInterval = lib.mkOption {
              type = lib.types.int;
              default = 0;
              description = "Server alive interval in seconds.";
            };
            serverAliveCountMax = lib.mkOption {
              type = lib.types.int;
              default = 3;
              description = "Maximum number of server alive messages.";
            };
            hashKnownHosts = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Whether to hash known hosts entries.";
            };
            userKnownHostsFile = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Path to the known hosts file.";
            };
            controlMaster = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Control master mode. Values: yes, no, ask, auto, autoask.";
            };
            controlPath = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Path for the control socket.";
            };
            controlPersist = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Whether to persist the control connection.";
            };
            extraOptions = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
              description = "Extra SSH config lines for this host.";
            };
          };
        }
      );
      default = { };
      description = "SSH client match blocks.";
    };
  };

  config = {
    flags."-F" = config.constructFiles.config.path;

    package = lib.mkDefault pkgs.openssh;

    matchBlocks = lib.mkIf config.enableDefaultConfig {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };

    constructFiles.config = {
      relPath = "ssh_config";
      content = sshConfig;
    };

    meta.maintainers = [ ];
  };
}

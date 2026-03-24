{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  formatMatchBlock =
    name: block:
    let
      lines =
        lib.optional (block ? hostname) "  HostName ${block.hostname}"
        ++ lib.optional (block ? user) "  User ${block.user}"
        ++ lib.optional (block ? proxyJump) "  ProxyJump ${block.proxyJump}"
        ++ lib.optional (block ? port) "  Port ${toString block.port}"
        ++ lib.optional (block ? identityFile) "  IdentityFile ${block.identityFile}"
        ++ lib.optional (block ? identitiesOnly && block.identitiesOnly) "  IdentitiesOnly yes"
        ++ lib.optional (block ? forwardAgent && block.forwardAgent) "  ForwardAgent yes"
        ++ map (o: "  ${o}") (block.extraOptions or [ ]);
    in
    "Host ${name}\n${lib.concatStringsSep "\n" lines}";

  sshConfig = lib.concatStringsSep "\n\n" (
    lib.mapAttrsToList formatMatchBlock config.matchBlocks
  );
in
{
  imports = [ wlib.modules.default ];

  options = {
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

    constructFiles.config = {
      relPath = "ssh_config";
      content = sshConfig;
    };

    meta.maintainers = [ ];
  };
}

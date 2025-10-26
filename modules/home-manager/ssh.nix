{ osConfig, lib, ... }:
let
  inherit (osConfig) work;
in
lib.mkIf (work.enable) {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # Default values (Host *):
    # ForwardAgent no
    # ServerAliveInterval 0
    # ServerAliveCountMax 3
    # Compression no
    # AddKeysToAgent no
    # HashKnownHosts no
    # UserKnownHostsFile ~/.ssh/known_hosts
    # ControlMaster no
    # ControlPath ~/.ssh/master-%r@%n:%p
    # ControlPersist no

    matchBlocks = {
      qs-auto-test = {
        proxyJump = "ergon";
        hostname = "192.168.70.5";
        user = "testing-user";
      };

      hildegard = {
        proxyJump = "ergon";
        hostname = "192.168.70.10";
        user = "testing-user";
      };

      heidi = {
        proxyJump = "ergon";
        hostname = "192.168.70.15";
        user = "testing-user";
      };

      helena = {
        proxyJump = "ergon";
        hostname = "192.168.70.20";
        user = "testing-user";
      };

      ergon = {
        hostname = "linux.ergon.ch";
      };
    };
  };
}

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
        hostname = "10.139.70.5";
        user = "testing-user";
      };

      hildegard = {
        proxyJump = "ergon";
        hostname = "10.139.70.10";
        user = "testing-user";
      };

      heidi = {
        proxyJump = "ergon";
        hostname = "10.139.70.15";
        user = "testing-user";
      };

      helena = {
        proxyJump = "ergon";
        hostname = "10.139.70.20";
        user = "testing-user";
      };

      # Thomas/Aaron
      axenita-tower-remote-vm-1 = {
        proxyJump = "ergon";
        hostname = "10.139.70.203";
        user = "testing-user";
      };

      # Jan
      axenita-tower-remote-vm-2 = {
        proxyJump = "ergon";
        hostname = "10.139.70.204";
        user = "testing-user";
      };

      # Patrick
      axenita-tower-remote-vm-3 = {
        proxyJump = "ergon";
        hostname = "10.139.70.205";
        user = "testing-user";
      };

      ergon = {
        hostname = "linux.ergon.ch";
      };
    };
  };
}

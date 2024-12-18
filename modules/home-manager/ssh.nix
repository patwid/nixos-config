{ osConfig, lib, ... }:
let
  inherit (osConfig) work;
in
lib.mkIf (work.enable) {
  programs.ssh = {
    enable = true;

    extraConfig = ''
      Host qs-auto-test
        ProxyJump ergon
        HostName 192.168.70.5
        User testing-user

      Host hildegard
        ProxyJump ergon
        HostName 192.168.70.10
        User testing-user

      Host heidi
        ProxyJump ergon
        HostName 192.168.70.15
        User testing-user

      Host helena
        ProxyJump ergon
        HostName 192.168.70.20
        User testing-user

      Host ergon
        HostName linux.ergon.ch
    '';
  };
}

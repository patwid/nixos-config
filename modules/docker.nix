{ config, args, lib, pkgs, ... }:
let
  inherit (config) work;
  inherit (args) user;
in
lib.mkIf (work.enable) (lib.mkMerge [
  {
    virtualisation.docker.enable = true;
    virtualisation.docker.daemon.settings = {
      "registry-mirrors" = [ "https://docker-mirror.ergon.ch" ];
    };

    users.users.${user}.extraGroups = [ "docker" ];

    # Required for elasticsearch container
    boot.kernel.sysctl = { "vm.max_map_count" = 262144; };

    home-manager.users.${user} = {
      home.packages = [ pkgs.docker-compose ];
    };
  }

  # Default address pool settings are documented here:
  #   - https://github.com/moby/libnetwork/blob/master/ipamutils/utils.go
  #   - https://github.com/docker/docs/issues/8663

  (lib.mkIf (work.remote) {
    # In remote work via VPN, the subnets 172.18.0.0/16, 172.20.0.0/16 and
    # 172.25.0.0.16 are routed via VPN. To avoid any conflicts we simply exclude
    # them from the default address pools.

    virtualisation.docker.daemon.settings = {
      "default-address-pools" = [
        { "base" = "172.17.0.0/16"; "size" = 16; }
        { "base" = "172.19.0.0/16"; "size" = 20; }
        { "base" = "172.21.0.0/16"; "size" = 20; }
        { "base" = "172.22.0.0/16"; "size" = 20; }
        { "base" = "172.23.0.0/16"; "size" = 20; }
        { "base" = "172.24.0.0/16"; "size" = 20; }
        { "base" = "172.26.0.0/16"; "size" = 20; }
        { "base" = "172.27.0.0/16"; "size" = 20; }
        { "base" = "172.28.0.0/14"; "size" = 20; }
      ];
    };

    networking.firewall.extraCommands = ''
      iptables -A INPUT -s 172.19.0.0/16 -j ACCEPT
      iptables -A INPUT -s 172.21.0.0/16 -j ACCEPT
      iptables -A INPUT -s 172.22.0.0/16 -j ACCEPT
      iptables -A INPUT -s 172.23.0.0/16 -j ACCEPT
      iptables -A INPUT -s 172.24.0.0/16 -j ACCEPT
      iptables -A INPUT -s 172.26.0.0/16 -j ACCEPT
      iptables -A INPUT -s 172.27.0.0/16 -j ACCEPT
      iptables -A INPUT -s 172.28.0.0/14 -j ACCEPT
    '';
  })

  (lib.mkIf (!work.remote) {
    virtualisation.docker.daemon.settings = {
      "default-address-pools" = [
        { "base" = "172.17.0.0/16"; "size" = 16; }
        { "base" = "172.18.0.0/16"; "size" = 20; }
        { "base" = "172.19.0.0/16"; "size" = 20; }
        { "base" = "172.20.0.0/14"; "size" = 20; }
        { "base" = "172.24.0.0/14"; "size" = 20; }
        { "base" = "172.28.0.0/14"; "size" = 20; }
      ];
    };

    networking.firewall.extraCommands = ''
      iptables -A INPUT -s 172.18.0.0/16 -j ACCEPT
      iptables -A INPUT -s 172.19.0.0/16 -j ACCEPT
      iptables -A INPUT -s 172.20.0.0/14 -j ACCEPT
      iptables -A INPUT -s 172.24.0.0/14 -j ACCEPT
      iptables -A INPUT -s 172.28.0.0/14 -j ACCEPT
    '';
  })
])

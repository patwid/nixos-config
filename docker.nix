{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    "default-address-pools" = [
      { "base" = "172.17.0.0/16"; "size" = 16; }
      { "base" = "172.19.0.0/16"; "size" = 16; }
      { "base" = "172.21.0.0/16"; "size" = 16; }
      { "base" = "172.22.0.0/16"; "size" = 16; }
      { "base" = "172.23.0.0/16"; "size" = 16; }
      { "base" = "172.24.0.0/16"; "size" = 16; }
      { "base" = "172.26.0.0/16"; "size" = 16; }
      { "base" = "172.27.0.0/16"; "size" = 16; }
      { "base" = "172.28.0.0/14"; "size" = 16; }
      { "base" = "192.168.0.0/16"; "size" = 20; }
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
    iptables -A INPUT -s 192.168.0.0/16 -j ACCEPT
  '';

  users.users.${user}.extraGroups = [ "docker" ];

  home-manager.users.${user} = {
    home.packages = [ pkgs.docker-compose ];
  };
}

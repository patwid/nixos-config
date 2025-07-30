{ lib, pkgs, config, ... }:
let
  inherit (config) user work;
in
{
  networking.networkmanager = {
    enable = true;
    plugins = lib.optionals (work.remote) [ pkgs.networkmanager-openvpn ];
  };

  # Allow incoming traffic from axenita-onlyoffice.ergon.ch (nslookup <domain>)
  networking.firewall.extraCommands = ''
    iptables -I INPUT -s 87.239.210.194 -j ACCEPT
    iptables -I INPUT -s 192.169.0.0/24 -j ACCEPT
  '';

  users.users.${user.name}.extraGroups = [ "networkmanager" ];
}

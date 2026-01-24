{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config) user work;
in
{
  networking.networkmanager = {
    enable = true;
    plugins = lib.optionals (work.remote) [ pkgs.networkmanager-openvpn ];
  };

  # Allow incoming traffic from axenita-onlyoffice.ergon.ch (nslookup <domain>)
  networking.firewall.extraInputRules = ''
    ip saddr {
      87.239.210.194,
      192.169.0.0/24
    } accept
  '';

  users.users.${user.name}.extraGroups = [ "networkmanager" ];
}

{ config, ... }:
let
  inherit (config) user;
in
{
  networking.networkmanager.enable = true;

  users.users.${user}.extraGroups = [ "networkmanager" ];
}

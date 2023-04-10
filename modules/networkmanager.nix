{ args, ... }:
let
  inherit (args) user;
in
{
  networking.networkmanager.enable = true;

  users.users.${user}.extraGroups = [ "networkmanager" ];
}

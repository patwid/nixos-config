{ args, ... }:
{
  networking.networkmanager.enable = true;

  users.users.${args.user}.extraGroups = [ "networkmanager" ];
}

{ pkgs, args, ... }:
{
  programs.openvpn3.enable = true;

  home-manager.users.${args.user} = {
    home.packages = [ pkgs.networkmanager-openvpn ];
  };
}

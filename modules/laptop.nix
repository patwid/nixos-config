{ pkgs, args, ... }:
{
  services.tlp.enable = true;

  home-manager.users.${args.user} = {
    home.packages = [ pkgs.brightnessctl ];
  };
}

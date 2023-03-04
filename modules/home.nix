{ config, home-manager, args, ... }:

{
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.${args.user} = {
    home.username = "${args.user}";
    home.homeDirectory = "/home/${args.user}";

    home.stateVersion = "${config.system.stateVersion}";
  };
}

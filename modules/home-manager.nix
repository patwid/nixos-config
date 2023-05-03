{ args, config, home-manager, ... }:
let
  inherit (args) user;
  inherit (config.system) stateVersion;
in
{
  imports = [
    home-manager.nixosModule
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.${user} = {
    home.username = "${user}";
    home.homeDirectory = "/home/${user}";

    home.stateVersion = stateVersion;
  };
}

{ config, home-manager, ... }:
let
  inherit (config) user;
in
{
  imports = [
    home-manager.nixosModule
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.${user.name} = {
    home.username = "${user.name}";
    home.homeDirectory = "/home/${user.name}";

    home.stateVersion = "${config.system.stateVersion}";
  };
}

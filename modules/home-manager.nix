{ config, home-manager, ... }:
let
  inherit (config) user system;
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

    home.stateVersion = system.stateVersion;
  };
}

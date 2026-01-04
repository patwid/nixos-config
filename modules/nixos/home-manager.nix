{
  nix-jetbrains-plugins,
  config,
  lib,
  home-manager,
  ...
}@inputs:
let
  inherit (config) user system hostPlatform;
in
{
  imports = [
    home-manager.nixosModules.default
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.extraSpecialArgs = {
    inherit nix-jetbrains-plugins;
  };

  home-manager.users.${user.name} = {
    home.username = "${user.name}";
    home.homeDirectory = "/home/${user.name}";

    home.stateVersion = system.stateVersion;

    imports = lib.modulesIn hostPlatform ../home-manager;
  };
}

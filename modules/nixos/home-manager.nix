{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (inputs) self home-manager;
  inherit (config) user system hostPlatform;
in
{
  imports = [
    home-manager.nixosModules.default
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.extraSpecialArgs = {
    inherit inputs;
  };

  home-manager.users.${user.name} = {
    home.username = "${user.name}";
    home.homeDirectory = "/home/${user.name}";

    home.stateVersion = system.stateVersion;

    imports = self.lib.filesystem.modulesIn hostPlatform ../_home-manager;
  };
}

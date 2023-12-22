{ nixosConfig, config, lib, lib', home-manager, ... }@inputs:
let
  inherit (config) user system;
  inherit (nixosConfig) hostPlatform;
in
{
  imports = [
    home-manager.nixosModule
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.extraSpecialArgs = { inherit lib'; };

  home-manager.users.${user.name} = {
    home.username = "${user.name}";
    home.homeDirectory = "/home/${user.name}";

    home.stateVersion = system.stateVersion;

    imports = lib'.modulesIn hostPlatform ../home-manager;
  };
}

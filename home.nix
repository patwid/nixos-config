{ config, home-manager, ... }:

let
  user = import ./user.nix;
in {
  imports = [
    home-manager.nixosModule

    ./laptop.nix
    ./sway.nix
    ./work.nix
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.${user} = {
    home.username = "${user}";
    home.homeDirectory = "/home/${user}";

    home.stateVersion = "${config.system.stateVersion}";
  };
}

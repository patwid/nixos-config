{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  virtualisation.docker.enable = true;

  users.users.${user}.extraGroups = [ "docker" ];

  home-manager.users.${user} = {
    home.packages = [ pkgs.docker-compose ];
  };
}

{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  imports = [
    ./docker.nix
  ];

  home-manager.users.${user.name} = {
    home.packages = with pkgs; [
      citrix_workspace
      dbeaver
      jetbrains.idea-ultimate
      jtt
      mattermost
      outlook
      smartaz
      teams
    ];
  };
}

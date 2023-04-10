{ args, pkgs, ... }:
let
  inherit (args) user;
in
{
  imports = [
    ./docker.nix
  ];

  home-manager.users.${user} = {
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

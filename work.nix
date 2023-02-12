{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  imports = [
    ./local-pkgs.nix
    ./docker.nix
  ];

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      citrix_workspace
      dbeaver
      jetbrains.idea-ultimate
      mattermost
      outlook
      smartaz
      teams
    ];
  };
}

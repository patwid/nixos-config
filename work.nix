{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  imports = [
    ./localpkgs.nix
    ./docker.nix
    ./openvpn.nix
    ./shares-work.nix
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

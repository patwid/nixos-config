{ pkgs, args, ... }:
{
  imports = [
    ./localpkgs.nix
    ./docker.nix
    ./openvpn.nix
    ./shares-work.nix
  ];

  home-manager.users.${args.user} = {
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

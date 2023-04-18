{ args, pkgs, ... }:
let
  inherit (args) user;
in
{
  home-manager.users.${user} = {
    home.packages = with pkgs; [
      imv
    ];
  };
}

{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  home-manager.users.${user} = {
    home.packages = [ pkgs.aerc ];
  };
}

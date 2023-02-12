{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  services.tlp.enable = true;

  home-manager.users.${user} = {
    home.packages = [ pkgs.brightnessctl ];
  };
}

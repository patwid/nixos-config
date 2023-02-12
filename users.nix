{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };
}

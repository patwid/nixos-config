{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  users.users.${user.name} = {
    isNormalUser = true;
    description = "${user.name}";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
  };
}

{ args, pkgs, ... }:
let
  inherit (args) user;
in
{
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
  };
}

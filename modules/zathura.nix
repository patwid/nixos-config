{ args, pkgs, ... }:
let
  inherit (args) user;
in
{
  home-manager.users.${user} = {
    programs.zathura.enable = true;
  };
}

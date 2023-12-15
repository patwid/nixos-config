{ config, lib, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    programs.password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_KEY =
          lib.concatStringsSep " " (lib.attrNames (builtins.readDir ../keys));
      };
    };
  };
}

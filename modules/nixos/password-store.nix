{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) user;
in
{
  environment = {
    sessionVariables = {
      PASSWORD_STORE_DIR = "/home/${user.name}/.local/share/password-store";
      PASSWORD_STORE_KEY = lib.concatStringsSep " " (lib.attrNames (builtins.readDir ../../keys));
    };

    systemPackages = builtins.attrValues {
      inherit (pkgs) pass-wayland;
    };
  };
}

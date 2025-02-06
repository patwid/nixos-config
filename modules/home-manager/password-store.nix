{ lib, ... }:
{
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_KEY = lib.concatStringsSep " " (lib.attrNames (builtins.readDir ../../keys));
    };
  };
}

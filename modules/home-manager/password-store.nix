{ lib, pkgs, ... }:
{
  programs.password-store = {
    enable = true;
    package = pkgs.pass-wayland;
    settings = {
      PASSWORD_STORE_KEY = lib.concatStringsSep " " (lib.attrNames (builtins.readDir ../../keys));
    };
  };
}

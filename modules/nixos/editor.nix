{ lib, pkgs, ... }:
{
  environment = {
    sessionVariables = {
      EDITOR = lib.getExe pkgs.helix;
    };
  };
}

{ lib, pkgs, ... }:
{
  environment = {
    sessionVariables = {
      BROWSER = lib.getExe pkgs.qutebrowser;
    };
  };
}

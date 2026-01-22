{ config, ... }:
let
  inherit (config) user;
in
{
  environment.sessionVariables = {
    XDG_SCREENSHOTS_DIR = "/home/${user.name}/pictures/screenshots";
  };
}

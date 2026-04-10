{ config, ... }:
let
  inherit (config) user;
  inherit (config.users.users.${user.name}) group;
in
{
  services.syncthing = {
    enable = true;
    user = user.name;
    inherit group;
    configDir = "/home/${user.name}/.config/syncthing";
    dataDir = "/home/${user.name}/.local/share/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      options = {
        urAccepted = -1; # Disable anonymous usage data
      };
    };
  };
}

{ config, ... }:
let
  inherit (config) user;
in
{
  services.syncthing = {
    enable = true;
    user = user.name;
    group = "users";
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

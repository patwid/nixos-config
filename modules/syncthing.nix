{ config, ... }:
let
  inherit (config) user;
in
{
  services.syncthing = {
    enable = true;
    user = user.name;
    group = "users";
    dataDir = "/home/${user.name}";
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      options = {
        urAccepted = -1; # Disable anonymous usage data
      };
    };
  };
}

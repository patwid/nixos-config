{ config, ... }:
let
  inherit (config) user;
in
{
  services.syncthing = {
    enable = true;
    user = "${user.name}";
    dataDir = "/home/${user.name}/sync";
    configDir = "/home/${user.name}/.config/syncthing";
  };
}

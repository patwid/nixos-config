{ args, ... }:
let
  inherit (args) user;
in
{
  services.syncthing = {
    enable = true;
    user = "${user}";
    dataDir = "/home/${user}";
    configDir = "/home/${user}/.config/syncthing";
  };
}

{ args, ... }:
let
  inherit (args) user;
in
{
  services.syncthing = {
    enable = true;
    user = "${user}";
    dataDir = "/home/${user}/sync";
    configDir = "/home/${user}/.config/syncthing";
  };
}

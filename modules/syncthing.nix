{ config, ... }:
let
  inherit (config) user;
in
{
  services.syncthing = {
    enable = true;
    inherit user;
    group = "users";
    dataDir = "/home/${user}";
  };
}

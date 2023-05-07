{ args, ... }:
let
  inherit (args) user;
in
{
  services.syncthing = {
    enable = true;
    inherit user;
    dataDir = "/home/${user}";
  };
}

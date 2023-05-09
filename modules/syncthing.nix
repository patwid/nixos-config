{ args, ... }:
let
  inherit (args) user;
in
{
  services.syncthing = {
    enable = true;
    inherit user;
    group = "users";
    dataDir = "/home/${user}";
  };
}

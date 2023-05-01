{ args, ... }:
let
  inherit (args) user;
in
{
  services.transmission = {
    enable = true;
    inherit user;
    settings = {
      alt-speed-up = 0;
      download-dir = "/home/${user}/downloads";
      speed-limit-up = 0;
      speed-limit-up-enabled = true;
    };
  };
}

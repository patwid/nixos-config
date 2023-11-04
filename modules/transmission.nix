{ config, ... }:
let
  inherit (config) user;
in
{
  services.transmission = {
    enable = false;
    inherit user;
    settings = {
      alt-speed-up = 0;
      download-dir = "/home/${user}/downloads";
      speed-limit-up = 0;
      speed-limit-up-enabled = true;
    };
  };
}

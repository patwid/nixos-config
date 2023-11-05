{ config, ... }:
let
  inherit (config) user home;
in
{
  services.transmission = {
    enable = home.server;
    inherit user;
    settings = {
      alt-speed-up = 0;
      download-dir = "/home/${user}/downloads";
      speed-limit-up = 0;
      speed-limit-up-enabled = true;
    };
  };
}

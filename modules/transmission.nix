{ config, ... }:
let
  inherit (config) user home;
in
{
  services.transmission = {
    enable = home.server;
    user = user.name;
    settings = {
      alt-speed-up = 0;
      download-dir = "/home/${user.name}/downloads";
      speed-limit-up = 0;
      speed-limit-up-enabled = true;
    };
  };
}

{ args, ... }:
let
  inherit (args) user;
in
{
  home-manager.users.${user} = {
    services.wlsunset = {
      enable = true;
      latitude = "47.3";
      longitude = "8.5";
    };
  };
}

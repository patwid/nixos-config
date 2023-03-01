{ args, ... }:
{
  home-manager.users.${args.user} = {
    services.wlsunset = {
      enable = true;
      latitude = "47.3";
      longitude = "8.5";
    };
  };
}

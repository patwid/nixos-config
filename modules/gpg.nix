{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  # Required for pinentry flavor gnome3 to work on non-gnome systems
  services.dbus.packages = [ pkgs.gcr ];

  home-manager.users.${user.name} = {
    home.packages = [ pkgs.pinentry-gnome ];

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "gnome3";
      defaultCacheTtl = 60480000;
      maxCacheTtl = 60480000;
    };
  };
}

{ pkgs, args, ... }:
{
  # Required for pinentry flavor gnome3 to work on non-gnome systems
  services.dbus.packages = [ pkgs.gcr ];

  home-manager.users.${args.user} = {
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

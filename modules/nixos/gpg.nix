{ pkgs, ... }:
{
  # Required for pinentry flavor gnome3 to work on non-gnome systems
  services.dbus.packages = [ pkgs.gcr ];
}

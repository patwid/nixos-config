{ ... }:
self: super: {
  waybar = super.waybar.override { wireplumberSupport = false; };
}

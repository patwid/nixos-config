{ lib, osConfig, ... }:

let
  inherit (osConfig) colors;
in
lib.mkMerge [
  {
    gtk.enable = true;

    gtk.gtk3.bookmarks = [
      "file:///tmp"
    ];
  }

  (lib.mkIf (colors.variant == "dark") {
    gtk.gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = 1
    '';

    gtk.gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk.gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    # home.sessionVariables = {
    #   TODO: necessary? here or in nixos module?
    #   ADW_DISABLE_PORTAL = 1;
    # };
  })
]

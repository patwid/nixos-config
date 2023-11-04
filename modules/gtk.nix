{ config, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user} = {
    gtk.gtk3.bookmarks = [
      "file:///tmp"
    ];
  };
}

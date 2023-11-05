{ config, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    gtk.gtk3.bookmarks = [
      "file:///tmp"
    ];
  };
}

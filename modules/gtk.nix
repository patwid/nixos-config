{ args, ... }:
let
  inherit (args) user;
in
{
  home-manager.users.${user} = {
    gtk.gtk3.bookmarks = [
      "file:///tmp"
    ];
  };
}

{
  config,
  ...
}:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    gtk.enable = true;

    gtk.gtk3.bookmarks = [
      "file:///tmp"
    ];
  };
}

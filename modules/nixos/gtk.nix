{
  config,
  ...
}:
let
  inherit (config) user;
  homeDir = "/home/${user.name}";
in
{
  environment.etc."xdg/gtk-3.0/bookmarks".text = ''
    file:///tmp
  '';
}

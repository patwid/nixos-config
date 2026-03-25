{
  config,
  pkgs,
  ...
}:
let
  inherit (config) user;
  bookmarks = pkgs.writeText "gtk-bookmarks" ''
    file:///tmp
  '';
in
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) dconf;
  };

  system.activationScripts.gtkBookmarks.text = ''
    install -Dm644 -o ${user.name} -g users ${bookmarks} /home/${user.name}/.config/gtk-3.0/bookmarks
  '';
}

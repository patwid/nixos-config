{ writeShellApplication, coreutils, dmenu, findutils, menu, sway }:

writeShellApplication {
  name = "menu-run";
  runtimeInputs = [
    coreutils # dmenu_path depends on coreutils (cat)
    dmenu
    findutils
    menu
    sway
  ];
  text = ''
    dmenu_path | menu | xargs --no-run-if-empty swaymsg exec --
  '';
}

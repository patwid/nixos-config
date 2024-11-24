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
    exec swaymsg exec -- "$(dmenu_path | menu)"
  '';
}

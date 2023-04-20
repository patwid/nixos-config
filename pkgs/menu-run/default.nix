{ writeShellApplication, coreutils, dmenu, findutils, wmenu, sway }:

writeShellApplication {
  name = "menu-run";
  runtimeInputs = [
    coreutils # dmenu_path depends on coreutils (cat)
    dmenu
    findutils
    wmenu
    sway
  ];
  text = ''
    dmenu_path | wmenu | xargs --no-run-if-empty swaymsg exec --
  '';
}

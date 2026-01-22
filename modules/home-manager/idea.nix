{
  inputs,
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (osConfig) work;
in
lib.mkIf (work.enable) {
  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
    set ideajoin
  '';
}

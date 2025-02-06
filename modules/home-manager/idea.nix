{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (osConfig) work ideaExtraVmopts;
in
lib.mkIf (work.enable) {
  home.packages = with pkgs; [ jetbrains.idea-ultimate ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
    set ideajoin
  '';
}

{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (osConfig) work ideaExtraVmopts;

  idea-ultimate = pkgs.jetbrains.idea-ultimate.override {
    vmopts =
      ''
        -Dawt.toolkit.name=WLToolkit
      ''
      + ideaExtraVmopts;
  };
in
lib.mkIf (work.enable) {
  home.packages = [
    (pkgs.jetbrains.plugins.addPlugins idea-ultimate [ "ideavim"])
  ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
    set ideajoin
  '';
}

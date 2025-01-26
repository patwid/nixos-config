{ osConfig, lib, pkgs, ... }:
let
  inherit (osConfig) work ideaExtraVmopts;
in
lib.mkIf (work.enable) {
  home.packages = with pkgs; [
    (jetbrains.plugins.addPlugins (jetbrains.idea-ultimate.override {
      vmopts = ''
        -Dawt.toolkit.name=WLToolkit
      '' + ideaExtraVmopts;
    }) [ "ideavim" ])
  ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
    set ideajoin
  '';
}

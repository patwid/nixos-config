{ nixosConfig, lib, pkgs, ... }:
let
  inherit (nixosConfig) work;
  inherit (pkgs) jetbrains;

  idea-ultimate = jetbrains.idea-ultimate.override {
    vmopts = ''
      -Xms4g
      -Xmx4g
    '';
  };

  idea-ultimate' = jetbrains.plugins.addPlugins idea-ultimate [ "ideavim" ];
in
lib.mkIf (work.enable) {
  home.packages = [ idea-ultimate' ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
  '';
}

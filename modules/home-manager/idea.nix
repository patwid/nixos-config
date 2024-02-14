{ nixosConfig, lib, pkgs, ... }:
let
  inherit (nixosConfig) work;
in
lib.mkIf (work.enable) {
  home.packages = with pkgs; [
    (jetbrains.plugins.addPlugins jetbrains.idea-ultimate [ "ideavim" ])
  ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
  '';
}

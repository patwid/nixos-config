{ nixosConfig, lib, pkgs, ... }:
let
  inherit (nixosConfig) work;
in
lib.mkIf (work.enable) {
  home.packages = with pkgs; [ jetbrains.idea-ultimate ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
  '';
}

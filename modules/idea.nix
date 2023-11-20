{ config, lib, pkgs, ... }:
let
  inherit (config) user work;
in
lib.mkIf (work.enable) {
  home-manager.users.${user.name} = {
    home.packages = with pkgs; [
      jetbrains.idea-ultimate
    ];

    xdg.configFile."ideavim/ideavimrc".text = ''
      set clipboard+=unnamedplus,ideaput
    '';
  };
}

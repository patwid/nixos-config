{ config, lib, pkgs, ... }:
let
  inherit (config) user work;
in
lib.mkIf (work.enable) {
  home-manager.users.${user} = {
    programs.vscode = {
      enable = true;
      # Swapping escape and caps (xkb options) does not work properly
      # extensions = with pkgs.vscode-extensions; [
      #   vscodevim.vim
      # ];
    };
  };
}

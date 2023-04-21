{ config, args, lib, pkgs, ... }:
let
  inherit (args) user;
  inherit (config) work;
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

{ config, args, lib, pkgs, ... }:
let
  inherit (args) user;
  inherit (config) work;
in
lib.mkIf (work.enable) {
  home-manager.users.${user} = {
    programs.vscode = {
      enable = true;
      # XkbOptions seem to cause some issues, eg. swapping escape and caps does
      # not seem to work properly in VSCode.
      # extensions = with pkgs.vscode-extensions; [
      #   vscodevim.vim
      # ];
    };
  };
}

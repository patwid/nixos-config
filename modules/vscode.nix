{ config, args, lib, pkgs, ... }:
let
  inherit (args) user;
  inherit (config) work;
in
lib.mkIf (work.enable) {
  home-manager.users.${user} = {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ];
    };
  };
}

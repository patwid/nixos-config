{ config, args, lib, pkgs, ... }:
let
  inherit (args) user;
in
lib.mkIf config.work.enable {
  home-manager.users.${user} = {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ];
    };
  };
}

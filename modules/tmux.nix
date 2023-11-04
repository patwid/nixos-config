{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user} = {
    programs.tmux = {
      enable = true;
      prefix = "C-a";
      baseIndex = 1;
      extraConfig = ''
        set -g status-left "#S"
        set -g status-left-style "reverse"
        set -g status-right ""
        set -g status-style "none"
        set -g window-status-current-format ""
        set -g window-status-format ""
      '';
    };
  };
}

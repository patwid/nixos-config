{ config, lib, ... }:
let
  inherit (config) user colors terminal;
in
{
  options.terminal.fontsize = lib.mkOption {
    type = lib.types.int;
    default = 11;
  };

  config = {
    home-manager.users.${user.name} = {
      programs.foot = {
        enable = true;
        settings = {
          main.font = "monospace:size=${toString terminal.fontsize}";
          main.pad = "8x8";
          main.term = "xterm-256color";
          cursor.blink = "yes";
          colors = {
            foreground = lib.colors.withoutPrefix colors.darkerGrey;
            background = lib.colors.withoutPrefix colors.white;
            regular0 = lib.colors.withoutPrefix colors.black;
            regular1 = lib.colors.withoutPrefix colors.red;
            regular2 = lib.colors.withoutPrefix colors.green;
            regular3 = lib.colors.withoutPrefix colors.yellow;
            regular4 = lib.colors.withoutPrefix colors.blue;
            regular5 = lib.colors.withoutPrefix colors.magenta;
            regular6 = lib.colors.withoutPrefix colors.cyan;
            regular7 = lib.colors.withoutPrefix colors.lighterGrey;
            bright0 = lib.colors.withoutPrefix colors.darkGrey;
            bright1 = lib.colors.withoutPrefix colors.red;
            bright2 = lib.colors.withoutPrefix colors.green;
            bright3 = lib.colors.withoutPrefix colors.yellow;
            bright4 = lib.colors.withoutPrefix colors.blue;
            bright5 = lib.colors.withoutPrefix colors.magenta;
            bright6 = lib.colors.withoutPrefix colors.cyan;
            bright7 = lib.colors.withoutPrefix colors.white;
          };
        };
      };
    };
  };
}

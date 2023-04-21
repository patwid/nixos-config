{ args, config, lib, ... }:
let
  inherit (args) user terminal;
  inherit (config) colors;

  colorWithoutPrefix = color: lib.strings.removePrefix "#" color;
in
{
  home-manager.users.${user} = {
    programs.foot = {
      enable = true;
      settings = {
        main.font = "monospace:size=${toString terminal.fontsize}";
        main.pad = "8x8";
        cursor.blink = "yes";
        colors = {
          foreground = colorWithoutPrefix colors.lighterGrey;
          background = colorWithoutPrefix colors.black;
          regular0 = colorWithoutPrefix colors.black;
          regular1 = colorWithoutPrefix colors.red;
          regular2 = colorWithoutPrefix colors.green;
          regular3 = colorWithoutPrefix colors.yellow;
          regular4 = colorWithoutPrefix colors.blue;
          regular5 = colorWithoutPrefix colors.magenta;
          regular6 = colorWithoutPrefix colors.cyan;
          regular7 = colorWithoutPrefix colors.lighterGrey;
          bright0 = colorWithoutPrefix colors.darkGrey;
          bright1 = colorWithoutPrefix colors.red;
          bright2 = colorWithoutPrefix colors.green;
          bright3 = colorWithoutPrefix colors.yellow;
          bright4 = colorWithoutPrefix colors.blue;
          bright5 = colorWithoutPrefix colors.magenta;
          bright6 = colorWithoutPrefix colors.cyan;
          bright7 = colorWithoutPrefix colors.white;
        };
      };
    };
  };
}

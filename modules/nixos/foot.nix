{ config, lib, ... }:
let
  inherit (config) colors terminal;
in
{
  programs.foot = {
    enable = true;
    settings = {
      main.font = "monospace:size=${toString terminal.fontsize}";
      main.pad = "8x4";
      main.term = "xterm-256color";
      cursor.blink = "yes";
      colors = with lib.colors; {
        foreground = withoutPrefix colors.foreground;
        background = withoutPrefix colors.background;

        regular0 = withoutPrefix colors.black;
        regular1 = withoutPrefix colors.red;
        regular2 = withoutPrefix colors.green;
        regular3 = withoutPrefix colors.yellow;
        regular4 = withoutPrefix colors.blue;
        regular5 = withoutPrefix colors.magenta;
        regular6 = withoutPrefix colors.cyan;
        regular7 = withoutPrefix colors.lighterGrey;

        bright0 = withoutPrefix colors.darkerGrey;
        bright1 = withoutPrefix colors.red;
        bright2 = withoutPrefix colors.green;
        bright3 = withoutPrefix colors.yellow;
        bright4 = withoutPrefix colors.blue;
        bright5 = withoutPrefix colors.magenta;
        bright6 = withoutPrefix colors.cyan;
        bright7 = withoutPrefix colors.white;

        # Greyscale colors (from dark to light)
        "232" = withoutPrefix colors.black;
        "233" = withoutPrefix colors.black;
        "234" = withoutPrefix colors.black;
        "235" = withoutPrefix colors.darkestGrey;
        "236" = withoutPrefix colors.darkestGrey;
        "237" = withoutPrefix colors.darkestGrey;
        "238" = withoutPrefix colors.darkerGrey;
        "239" = withoutPrefix colors.darkerGrey;
        "240" = withoutPrefix colors.darkerGrey;
        "241" = withoutPrefix colors.darkGrey;
        "242" = withoutPrefix colors.darkGrey;
        "243" = withoutPrefix colors.darkGrey;
        "244" = withoutPrefix colors.lightGrey;
        "245" = withoutPrefix colors.lightGrey;
        "246" = withoutPrefix colors.lightGrey;
        "247" = withoutPrefix colors.lighterGrey;
        "248" = withoutPrefix colors.lighterGrey;
        "249" = withoutPrefix colors.lighterGrey;
        "250" = withoutPrefix colors.lightestGrey;
        "251" = withoutPrefix colors.lightestGrey;
        "252" = withoutPrefix colors.lightestGrey;
        "253" = withoutPrefix colors.white;
        "254" = withoutPrefix colors.white;
        "255" = withoutPrefix colors.white;
      };
    };
  };
}

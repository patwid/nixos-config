{ nixosConfig, lib', ... }:
let
  inherit (nixosConfig) colors terminal;
in
{
  programs.foot = {
    enable = true;
    settings = {
      main.font = "monospace:size=${toString terminal.fontsize}";
      main.pad = "8x4";
      main.term = "xterm-256color";
      cursor.blink = "yes";
      colors = with lib'.colors; {
        foreground = withoutPrefix colors.lighterGrey;
        background = withoutPrefix colors.black;
        regular0 = withoutPrefix colors.black;
        regular1 = withoutPrefix colors.red;
        regular2 = withoutPrefix colors.green;
        regular3 = withoutPrefix colors.yellow;
        regular4 = withoutPrefix colors.blue;
        regular5 = withoutPrefix colors.magenta;
        regular6 = withoutPrefix colors.cyan;
        regular7 = withoutPrefix colors.lighterGrey;
        bright0 = withoutPrefix colors.darkGrey;
        bright1 = withoutPrefix colors.red;
        bright2 = withoutPrefix colors.green;
        bright3 = withoutPrefix colors.yellow;
        bright4 = withoutPrefix colors.blue;
        bright5 = withoutPrefix colors.magenta;
        bright6 = withoutPrefix colors.cyan;
        bright7 = withoutPrefix colors.white;
      };
    };
  };
}

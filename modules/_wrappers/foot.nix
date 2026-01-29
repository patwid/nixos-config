{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (inputs) wrappers;
  inherit (config) colors terminal;

  colors' = colors |> builtins.mapAttrs (_: color: lib.colors.withoutPrefix color);
in
wrappers.wrappedModules.foot.wrap {
  inherit pkgs;

  settings = {
    main.font = "monospace:size=${toString terminal.fontsize}";
    main.pad = "8x4";
    main.term = "xterm-256color";
    cursor.blink = "yes";
    colors = {
      foreground = colors'.foreground;
      background = colors'.background;

      regular0 = colors'.black;
      regular1 = colors'.red;
      regular2 = colors'.green;
      regular3 = colors'.yellow;
      regular4 = colors'.blue;
      regular5 = colors'.magenta;
      regular6 = colors'.cyan;
      regular7 = colors'.lighterGrey;

      bright0 = colors'.darkerGrey;
      bright1 = colors'.red;
      bright2 = colors'.green;
      bright3 = colors'.yellow;
      bright4 = colors'.blue;
      bright5 = colors'.magenta;
      bright6 = colors'.cyan;
      bright7 = colors'.white;

      # Greyscale colors (from dark to light)
      "232" = colors'.black;
      "233" = colors'.black;
      "234" = colors'.black;
      "235" = colors'.darkestGrey;
      "236" = colors'.darkestGrey;
      "237" = colors'.darkestGrey;
      "238" = colors'.darkerGrey;
      "239" = colors'.darkerGrey;
      "240" = colors'.darkerGrey;
      "241" = colors'.darkGrey;
      "242" = colors'.darkGrey;
      "243" = colors'.darkGrey;
      "244" = colors'.lightGrey;
      "245" = colors'.lightGrey;
      "246" = colors'.lightGrey;
      "247" = colors'.lighterGrey;
      "248" = colors'.lighterGrey;
      "249" = colors'.lighterGrey;
      "250" = colors'.lightestGrey;
      "251" = colors'.lightestGrey;
      "252" = colors'.lightestGrey;
      "253" = colors'.white;
      "254" = colors'.white;
      "255" = colors'.white;
    };
  };
}

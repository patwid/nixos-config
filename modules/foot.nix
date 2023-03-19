{ config, lib, ... }:
let
  inherit (config) user colors;
in
{
  home-manager.users.${user.name} = {
    programs.foot = {
      enable = true;
      settings = {
        main.font = "monospace:size=7";
        main.pad = "8x8";
        cursor.blink = "yes";
        colors = {
          foreground = lib.strings.removePrefix "#" "${colors.darkerGrey}";
          background = lib.strings.removePrefix "#" "${colors.white}";
          regular0 = lib.strings.removePrefix "#" "${colors.black}";
          regular1 = lib.strings.removePrefix "#" "${colors.red}";
          regular2 = lib.strings.removePrefix "#" "${colors.green}";
          regular3 = lib.strings.removePrefix "#" "${colors.yellow}";
          regular4 = lib.strings.removePrefix "#" "${colors.blue}";
          regular5 = lib.strings.removePrefix "#" "${colors.magenta}";
          regular6 = lib.strings.removePrefix "#" "${colors.cyan}";
          regular7 = lib.strings.removePrefix "#" "${colors.lighterGrey}";
          bright0 = lib.strings.removePrefix "#" "${colors.darkGrey}";
          bright1 = lib.strings.removePrefix "#" "${colors.red}";
          bright2 = lib.strings.removePrefix "#" "${colors.green}";
          bright3 = lib.strings.removePrefix "#" "${colors.yellow}";
          bright4 = lib.strings.removePrefix "#" "${colors.blue}";
          bright5 = lib.strings.removePrefix "#" "${colors.magenta}";
          bright6 = lib.strings.removePrefix "#" "${colors.cyan}";
          bright7 = lib.strings.removePrefix "#" "${colors.white}";
        };
      };
    };
  };
}

{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (config) colors;
in
{
  imports = [ inputs.nix-wrapper-modules.nixosModules.helix ];

  wrappers.helix = {
    enable = true;

    settings = {
      theme = "focus";

      editor = {
        # Sync clipboard with system clipboard
        default-yank-register = "+";
      };

      editor.cursor-shape = {
        insert = "bar";
      };

      keys.select = {
        "^" = "goto_first_nonwhitespace";
        "$" = "goto_line_end";
      };
    };

    themes = {
      focus = ''
        "ui.selection" = { bg = "blue-0" }
        "ui.cursor" = { fg = "white", bg = "black" }
        "ui.cursor.match" = { bg = "light-gray" }
        "ui.linenr" = { fg = "light-gray" }
        "ui.linenr.selected" = { fg = "default" }
        "ui.statusline" = { bg = "light-gray" }
        "ui.menu" = { bg = "light-gray" }
        "ui.menu.selected" = { modifiers = [ "reversed" ] }
        "ui.text.focus" = { modifiers = [ "bold" ] }
        "ui.text.inactive" = { fg = "light-gray" }
        "ui.popup" = { bg = "light-gray" }
        "ui.popup.info" = { bg = "default" }
        "diagnostic" = { underline = { style = "line" } }

        "comment" = { fg = "light-gray-0", modifiers = [ "italic" ] }
        "keyword" = { modifiers = [ "bold" ] }
        "punctuation.special" = { modifiers = [ "bold" ] }
        "special" = { modifiers = [ "bold" ] }
        "type" = { modifiers = [ "bold" ] }
        "variable.builtin" = { modifiers = [ "bold" ] }

        [palette]
        light-gray-0 = "${colors.lightGrey}"
        blue-0 = "#d3e4f9"
      '';
    };
  };

  environment.sessionVariables.EDITOR = lib.getExe config.wrappers.helix.wrapper;
}

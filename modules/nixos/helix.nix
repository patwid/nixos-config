{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (inputs.nix-wrapper-modules.wrappers) helix;
  inherit (config) colors;

  wrappedHelix = helix.wrap {
    inherit pkgs;

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
in
{
  environment = {
    systemPackages = [ wrappedHelix ];
    sessionVariables.EDITOR = lib.getExe wrappedHelix;
  };
}

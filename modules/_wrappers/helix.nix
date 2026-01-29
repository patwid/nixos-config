{ inputs, pkgs, ... }:
let
  inherit (inputs) wrappers;

  toToml = (pkgs.formats.toml { }).generate;
in
wrappers.lib.wrapPackage [
  { inherit pkgs; }
  (
    { pkgs, ... }:
    {
      package = pkgs.helix;

      flags."--config" = toToml "helix.toml" {
        theme = "focus";

        editor = {
          # Sync clipboard with system clipboard
          default-yank-register = "+";
        };

        editor.cursor-shape = {
          insert = "bar";
        };

        # keys.normal = {
        #   "#" = "toggle_comments"
        #   "^" = "goto_first_nonwhitespace"
        #   "$" = "goto_line_end"
        # };

        keys.select = {
          "^" = "goto_first_nonwhitespace";
          "$" = "goto_line_end";
        };
      };

      suffixVar = [
        [
          "HELIX_RUNTIME"
          ":"
          "${pkgs.helix-theme-focus}/lib/runtime"
        ]
      ];
    }
  )
]

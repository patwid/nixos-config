{ inputs, pkgs, ... }:
let
  inherit (inputs) wrappers;
in
wrappers.lib.wrapPackage [
  { inherit pkgs; }
  (
    { pkgs, ... }:
    {
      package = pkgs.helix;
      flags."--config" = pkgs.writeText "helix.toml" ''
        theme = "simple"

        [editor]
        # Sync clipboard with system clipboard
        default-yank-register = "+"

        [keys.normal]
        # "#" = "toggle_comments"
        # "^" = "goto_first_nonwhitespace"
        # "$" = "goto_line_end"

        [keys.select]
        "^" = "goto_first_nonwhitespace"
        "$" = "goto_line_end"
      '';
      suffixVar = [
        [
          "HELIX_RUNTIME"
          ":"
          "${pkgs.helix-theme-simple}/lib/runtime"
        ]
      ];
    }
  )
]

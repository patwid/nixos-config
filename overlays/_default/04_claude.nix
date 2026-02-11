{ inputs, ... }:
let
  inherit (inputs) claude-code;
in
claude-code.overlays.default

{ inputs, lib, ... }:
let
  inherit (inputs) nixos-apple-silicon;
in
lib.composeManyExtensions [
  nixos-apple-silicon.overlays.default
  (import ./_apple-silicon)
]

{ nixpkgs-jbr21, ... }:
self: super:
let
  pkgs = import nixpkgs-jbr21 {
    inherit (super) system;
    config.allowUnfree = super.config.allowUnfree;
  };
in
{
  inherit (pkgs) jetbrains;
}

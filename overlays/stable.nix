{ inputs, ... }:
final: prev:
let
  inherit (inputs) nixpkgs-stable;

  stable = import nixpkgs-stable {
    inherit (final) config;
    inherit (final.stdenv.hostPlatform) system;
  };
in
{ }

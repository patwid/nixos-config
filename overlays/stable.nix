{ inputs, ... }:
final: prev:
let
  inherit (inputs) nixpkgs-stable;

  stable = import nixpkgs-stable {
    inherit (prev) config;
    inherit (prev.stdenv.hostPlatform) system;
  };
in
{
  inherit stable;
}

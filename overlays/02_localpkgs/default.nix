{ lib, ... }:
final: prev:
let
  localpkgs = import ../../packages {
    inherit lib;
    pkgs = final;
  };
in
localpkgs

{ ... }@inputs:
final: prev:
let
  localpkgs = import ../pkgs (inputs // { pkgs = prev; });
in
localpkgs;

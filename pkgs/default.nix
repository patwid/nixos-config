{ pkgs, lib, ... }:

let
  callPackage = lib.callPackageWith (pkgs // localPkgs);
  localPkgs =
    builtins.readDir ./.
    |> lib.filterAttrs (n: _: n != "default.nix")
    |> builtins.mapAttrs (p: _: callPackage ./${p} { });
in
localPkgs

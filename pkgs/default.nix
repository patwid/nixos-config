{ pkgs, lib, ... }:

let
  callPackage = lib.callPackageWith (pkgs // localPkgs);
  localPkgs =
    builtins.readDir ./.
    |> lib.filterAttrs (n: _: n != "default.nix")
    |> lib.mapAttrs' (p: _: lib.nameValuePair (lib.removeSuffix ".nix" p) (callPackage ./${p} { }));
in
localPkgs

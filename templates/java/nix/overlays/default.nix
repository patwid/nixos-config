{ lib }:
final: prev:
let
  localpkgs =
    builtins.readDir ../packages
    |> lib.mapAttrs' (
      name: _:
      lib.nameValuePair (lib.removePrefix ".nix" name) (final.callPackage ../packages/${name} { })
    );
in
{
  jdk = prev.jdk21;
  gradle = prev.gradle.override { java = final.jdk; };
}
// localpkgs

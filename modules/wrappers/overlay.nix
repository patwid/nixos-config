{ config, lib, wrappers }:
final: prev:
  builtins.readDir ../wrappers
  |> lib.filterAttrs (name: _: name != "overlay.nix")
  |> lib.mapAttrs' (
    name: _:
    lib.nameValuePair (lib.removeSuffix ".nix" name) (
      import ../wrappers/${name} {
        inherit config lib wrappers;
        pkgs = prev;
      }
    )
  )

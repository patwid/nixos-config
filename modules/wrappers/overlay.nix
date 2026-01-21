{
  inputs,
  config,
  lib,
}:
final: prev:
builtins.readDir ../wrappers
|> lib.filterAttrs (name: _: name != "overlay.nix")
|> lib.mapAttrs' (
  name: _:
  lib.nameValuePair (lib.removeSuffix ".nix" name) (
    import ../wrappers/${name} {
      inherit inputs config lib;
      pkgs = prev;
    }
  )
)
|> lib.mapAttrs' (
  name: value:
  lib.nameValuePair
    # Prevent infinite recursion
    (if name == "git" then "${name}'" else name)
    value
)

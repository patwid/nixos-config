{
  inputs,
  config,
  lib,
}:
builtins.readDir ../wrappers
|> builtins.attrNames
|> lib.filter (name: name != "overlay.nix")
|> map (
  name:
  let
    pname = lib.removeSuffix ".nix" name;
    # Prevent infinite recursion
    pname' = if pname == "git" then "${pname}'" else pname;
  in
  final: prev: {
    ${pname'} = import ../wrappers/${name} {
      inherit inputs config lib;
      pkgs = prev;
    };
  }
)
|> lib.composeManyExtensions

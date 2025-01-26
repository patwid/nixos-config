{ lib, ... }@inputs:
builtins.readDir ./.
|> lib.attrNames
|> lib.filter (n: n != "default.nix")
|> map (p: import ./${p} inputs)
|> lib.composeManyExtensions

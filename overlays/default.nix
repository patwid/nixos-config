{ nur, lib, ... }@inputs:
let
  overlays =
    builtins.readDir ./.
    |> lib.attrNames
    |> lib.filter (n: n != "default.nix")
    |> map (p: import ./${p} inputs);
in
[ nur.overlay ] ++ overlays

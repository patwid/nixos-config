inputs:
let
  localPkgs = import ../pkgs inputs;
in
_: _:
localPkgs

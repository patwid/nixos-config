{ nur, ... }@attrs:
let
  localpkgs = import ./localpkgs.nix attrs;
  pass = import ./pass.nix attrs;
  wmenu = import ./wmenu attrs;
  stablepkgs = import ./stablepkgs.nix attrs;
in
[
  nur.overlay
  localpkgs.overlay
  pass.overlay
  wmenu.overlay
  stablepkgs.overlay
]

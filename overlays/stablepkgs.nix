{ nixpkgs-stable, ... }:
self: super: {
  stable = import nixpkgs-stable {
    inherit (super) config system;
  };
}

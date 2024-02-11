{ nixpkgs-stable, ... }:
self: super: {
  stable = import nixpkgs-stable {
    inherit (super) system;
    config.allowUnfree = super.config.allowUnfree;
  };
}

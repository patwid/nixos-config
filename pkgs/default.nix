{ pkgs, lib, ... }:

let
  callPackage = lib.callPackageWith (pkgs // localPkgs);

  vimPlugins =
    builtins.readDir ./vim-plugins |> builtins.mapAttrs (p: _: callPackage ./vim-plugins/${p} { });

  localPkgs =
    (
      builtins.readDir ./.
      |> lib.filterAttrs (n: _: n != "default.nix")
      |> lib.filterAttrs (n: _: n != "vim-plugins")
      |> builtins.mapAttrs (p: _: callPackage ./${p} { })
    )
    // {
      inherit vimPlugins;
    };
in
localPkgs

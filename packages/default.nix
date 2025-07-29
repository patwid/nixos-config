{ pkgs, lib, ... }:

let
  callPackage = lib.callPackageWith (pkgs // localPkgs);

  localPkgs =
    (
      builtins.readDir ./.
      |> lib.filterAttrs (
        n: _:
        !builtins.elem n [
          "default.nix"
          "vim-plugins"
        ]
      )
      |> builtins.mapAttrs (p: _: callPackage ./${p} { })
    )
    // {
      vimPlugins =
        builtins.readDir ./vim-plugins |> builtins.mapAttrs (p: _: callPackage ./vim-plugins/${p} { });
    };
in
localPkgs

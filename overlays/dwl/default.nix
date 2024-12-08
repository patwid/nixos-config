{ lib, pkgs, ... }:
final: prev:
let
  dwl = prev.dwl.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (prev.fetchpatch {
        url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/swallow/swallow.patch";
        hash = "sha256-1Vdt0FgbV7jHjr4wqWqDnaqVk5FcRnlYKb8/U0VUesM=";
      })

      (prev.fetchpatch {
        url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/bar/bar-0.7.patch";
        hash = "sha256-WbT3wp3hIp6ixud9q27F+hn7zq/4be6ZUpGWtCWX9tw=";
      })
    ];

    buildInputs = (old.buildInputs or [ ]) ++ (with prev; [
      libdrm # bar patch
      fcft # bar patch
    ]);
  });
in
{
  dwl = dwl.override { configH = ./config.h; };
}

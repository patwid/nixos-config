lib: {
  modulesIn =
    system: modulesPath:
    lib.filesystem.listFilesRecursive modulesPath
    |> lib.filter (lib.hasSuffix ".nix")
    |> lib.filter (
      path:
      path
      |> lib.path.removePrefix modulesPath
      |> lib.path.subpath.components
      |> lib.all (component: !(lib.hasPrefix "+" component) || lib.hasPrefix component "+${system}")
    );
}

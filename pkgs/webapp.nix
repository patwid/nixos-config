{ writeShellApplication, chromium, name ? "", url ? "" }:

writeShellApplication {
  inherit name;
  runtimeInputs = [ chromium ];
  text = ''
    exec chromium --app='${url}'
  '';
}

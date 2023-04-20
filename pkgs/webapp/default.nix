{ writeShellApplication, chromium, app, url }:

writeShellApplication {
  name = "${app}";
  runtimeInputs = [ chromium ];
  text = ''
    exec chromium --app='${url}'
  '';
}

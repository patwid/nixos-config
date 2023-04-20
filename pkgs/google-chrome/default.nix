{ writeShellApplication, chromium }:

writeShellApplication {
  name = "google-chrome";
  runtimeInputs = [ chromium ];
  text = ''exec chromium "$@"'';
}

{ lib, osConfig, ... }:
let
  inherit (osConfig) appleSilicon output;

  formatOutputs = builtins.attrNames output |> map formatOutput |> builtins.concatStringsSep "\n\n";

  formatOutput = name: ''
    output "${name}" {
        ${format "scale" output.${name}}
        ${formatPosition output.${name}}
    }
  '';

  formatPosition =
    output:
    lib.optionalString (output ? position) (
      let
        position = builtins.split " " output.position;
      in
      "position x=${lib.head position} y=${lib.tail position}"
    );

  format = name: output: lib.optionalString (output ? ${name}) "${name} ${output.${name}}";
in
{
  programs.bash = {
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec niri-session -l >/dev/null 2>&1
      fi
    '';
  };

  xdg.configFile."niri/config.kdl".text =
    builtins.readFile ./niri/config.kdl
    + lib.optionalString appleSilicon.enable ''

      // Asahi workaround: `ls -l /dev/dri`
      debug {
          render-drm-device "/dev/dri/renderD128"
      }
    ''
    + formatOutputs;
}

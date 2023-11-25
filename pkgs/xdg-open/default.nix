{ writeShellApplication, file }:

let
  name = "xdg-open";
in
writeShellApplication {
  inherit name;
  runtimeInputs = [ file ];
  text = ''
    targ=$1
    scheme=''${targ%%:*}

    handle_mimetype() {
            case "$mt" in
                    application/pdf)
                            exec zathura "$targ"
                            ;;
                    *openxml*|*opendocument*)
                            exec libreoffice "$targ"
                            ;;
                    image/*)
                            exec imv "$targ"
                            ;;
                    video/*|audio/*)
                            exec mpv "$targ"
                            ;;
                    text/*)
                            exec foot "$EDITOR" "$targ"
                            ;;
                    *)
                            echo "${name}: failed to open $targ" >&2
                            exit 1
                            ;;
            esac
    }

    case "$scheme" in
            http|https)
                    exec "$BROWSER" "$targ"
                    ;;
            mailto)
                    exec aerc "$targ"
                    ;;
            *)
                    mt=$(file --mime-type "$targ")
                    mt=''${mt##* }
                    handle_mimetype
                    ;;
    esac
  '';
}

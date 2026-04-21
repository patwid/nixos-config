{
  flutterPackages,
  fetchgit,
  lib,
  sqlite,
  gst_all_1,
}:
flutterPackages.v3_41.buildFlutterApplication {
  pname = "goguma";
  version = "0.9.1-unstable-2026-04-21";

  src = fetchgit {
    url = "https://codeberg.org/emersion/goguma.git";
    rev = "0d013edcfd9b34f45dd0a4fbfbafe3964deccf50";
    hash = "sha256-rGS/yrnlYWvHDGYEytxDqKVoV3LoSj8R+BAGCako32Q=";
  };

  pubspecLock = lib.importJSON ./pubspec.lock.json;

  gitHashes = {
    scrollable_positioned_list = "sha256-fPNFQ1aWLpGLBNykvoywMZp5B1ef2PlTYS8bP8QNSV4=";
  };

  buildInputs = [
    sqlite
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
  ];

  postInstall = ''
    install -Dm644 linux/fr.emersion.goguma.desktop $out/share/applications/fr.emersion.goguma.desktop
    install -Dm644 linux/fr.emersion.goguma.metainfo.xml $out/share/metainfo/fr.emersion.goguma.metainfo.xml
  '';

  meta = with lib; {
    description = "An IRC client for mobile devices";
    homepage = "https://codeberg.org/emersion/goguma";
    license = licenses.agpl3Plus;
    maintainers = [ ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    mainProgram = "goguma";
  };
}

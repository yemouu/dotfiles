{ pkgs, ... }:
let
  wrapped-bemenu = pkgs.writeScriptBin "bemenu" (
    builtins.replaceStrings
      [
        "#!/bin/sh"
        "/usr/bin/bemenu"
      ]
      [
        "#!${pkgs.bash}/bin/sh"
        "${pkgs.bemenu}/bin/bemenu"
      ]
      (builtins.readFile ../../data/shellscripts/bemenu)
  );

  wrapped-bemenu-run = pkgs.writeScriptBin "bemenu-run" (
    builtins.replaceStrings
      [
        "#!/bin/sh"
        "/usr/bin/bemenu-run"
      ]
      [
        "#!${pkgs.bash}/bin/sh"
        "${pkgs.bemenu}/bin/bemenu-run"
      ]
      (builtins.readFile ../../data/shellscripts/bemenu-run)
  );
in
pkgs.symlinkJoin {
  name = "bemenu";
  paths = [
    wrapped-bemenu
    wrapped-bemenu-run
    pkgs.bemenu
  ];
}

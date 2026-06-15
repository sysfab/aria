{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
    pname = "Moga-Cursor";
    version = "latest";

    src = ./Moga-Cursor;

    buildPhase = ''
        mkdir -p $out/share/icons/Moga-Cursor
        cp -r * $out/share/icons/Moga-Cursor/
    '';
}
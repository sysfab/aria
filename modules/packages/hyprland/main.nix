{ lib, ... }:

{
    flake.mkHyprlandConfig = { extraConfig ? "" }:
        lib.strings.concatStringsSep "\n" (
            (map builtins.readFile (
                lib.filesystem.listFilesRecursive ./config
            )) ++ [ extraConfig ]
        );
}

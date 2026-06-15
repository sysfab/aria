{ lib, inputs, ... }:

{
    flake.mkHyprland = { pkgs, extraConfig ? "" }:
        inputs.wrappers.lib.wrapPackage {
            inherit pkgs;
            package = pkgs.hyprland;
            flags = {
                "--config" = pkgs.writeText "config.lua" (
                    lib.strings.concatStringsSep "\n" (
                        (map builtins.readFile (
                            lib.filesystem.listFilesRecursive ./config
                        )) ++ [ extraConfig ]
                    )
                );
            };
        };

    perSystem = { pkgs, ... }: {
        packages.hyprland = inputs.self.mkHyprland { inherit pkgs; };
    };
}
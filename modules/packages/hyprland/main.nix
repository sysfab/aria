{ lib, ... }:

{
    flake.nixosModules.hyprlandPlugins = { pkgs, ... }:
    let
        plugin_paths = [
            "/run/current-system/sw/lib/libhypr-dynamic-cursors.so"
        ];

        load-script = pkgs.writeShellScriptBin "aria-load-hyprland-plugins" ''
            ${builtins.concatStringsSep "\n" (map (path: ''
                hyprctl plugin unload ${path} || true
            '') plugin_paths)}

            ${builtins.concatStringsSep "\n" (map (path: ''
                hyprctl plugin load ${path}
            '') plugin_paths)}
        '';
    in
    {
        environment.systemPackages = [
            load-script
            pkgs.hyprlandPlugins.hypr-dynamic-cursors
        ];
    };

    flake.mkHyprlandConfig = { extraConfig ? "" }:
        lib.strings.concatStringsSep "\n" (
            (map builtins.readFile (
                lib.filesystem.listFilesRecursive ./config
            )) ++ [ extraConfig ]
        );
}

{ lib, ... }:

{
    flake.nixosModules.hyprlandPlugins = { pkgs, ... }:
    let
        plugin_paths = [
            "/run/current-system/sw/lib/libhypr-dynamic-cursors.so"
        ];

        load-plugins = pkgs.writeShellScriptBin "aria-hyprland-load-plugins" ''
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
            load-plugins
            pkgs.hyprlandPlugins.hypr-dynamic-cursors
        ];
    };

    flake.nixosModules.hyprland = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            hyprshot
            hyprshutdown
        ];
    };

    flake.homeModules.hyprland = { ... }: {
        xdg.config.files = {
            "hypr/hyprtoolkit.conf".source = ./hyprtoolkit.conf;
        };
    };

    flake.mkHyprlandConfig = { extraConfig ? "" }:
        lib.strings.concatStringsSep "\n" (
            (map builtins.readFile (
                lib.filesystem.listFilesRecursive ./config
            )) ++ [ extraConfig ]
        );
}

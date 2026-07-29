{ lib, ... }:

{
    flake.nixosModules.hyprlandPlugins = { pkgs, ... }:
    let
        plugin_paths = [
            #"/run/current-system/sw/..."
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
            #pkgs.hyprlandPlugins.
        ];
    };

    flake.nixosModules.hyprland = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            hyprshot
            hyprshutdown
        ];

        nix.settings = {
            substituters = ["https://hyprland.cachix.org"];
            trusted-substituters = ["https://hyprland.cachix.org"];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
            trusted-users = ["root" "@wheel"];
          };
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

{ self, lib, ... }:

{
    flake.nixosModules.hyprland = { config, pkgs, ... }:
    let
        plugin_paths = [
            #"/run/current-system/sw/..."
        ];

        unload-plugins = pkgs.writeShellScriptBin "aria-hyprland-unload-plugins" ''
            ${builtins.concatStringsSep "\n" (map (path: ''
                hyprctl plugin unload ${path} || true
            '') plugin_paths)}
        '';

        load-plugins = pkgs.writeShellScriptBin "aria-hyprland-load-plugins" ''
            aria-hyprland-unload-plugins
            ${builtins.concatStringsSep "\n" (map (path: ''
                hyprctl plugin load ${path}
            '') plugin_paths)}
        '';
    in
    {
        options.aria.hyprland = {
            enable = lib.mkOption {
                type = lib.types.bool;
                default = true;
            };
        };

        config = lib.mkIf config.aria.hyprland.enable {
            aria.pickers.power.commands = {
                shutdown.command = "hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl shutdown now'";
                reboot.command = "hyprshutdown -t 'Restarting...' --post-cmd 'systemctl reboot'";
                logout.command = "hyprshutdown -t 'Loggining off...'";
            };

            environment.systemPackages = [
                pkgs.hyprshot
                pkgs.hyprshutdown

                unload-plugins
                load-plugins
            ];

            programs.hyprland = {
                enable = lib.mkForce true;
                withUWSM = lib.mkForce true;
            };

            nix.settings = {
                substituters = ["https://hyprland.cachix.org"];
                trusted-substituters = ["https://hyprland.cachix.org"];
                trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
                trusted-users = ["root" "@wheel"];
            };
        };
    };

    flake.homeModules.hyprland = { config, ... }: {
        options.aria.hyprland = {
            extraConfig = lib.mkOption {
                type = lib.types.str;
                default = "";
            };
        };

        config = {
            xdg.config.files = {
                "hypr/hyprland.lua".text = self.mkHyprlandConfig { extraConfig = config.aria.hyprland.extraConfig; };
                "hypr/hyprtoolkit.conf".source = ./hyprtoolkit.conf;
            };
        };
    };

    flake.mkHyprlandConfig = { extraConfig ? "" }:
        lib.strings.concatStringsSep "\n" (
            (map builtins.readFile (
                lib.filesystem.listFilesRecursive ./config
            )) ++ [ "-- extraConfig:" extraConfig ]
        );
}

{ lib, ... }:

{
    flake.nixosModules.waybar = { pkgs, ... }: {
        aria.pickers.actions.commands = {
            toggle-bar = {
                name = "Toggle bar";
                order = lib.mkDefault 200;

                command = "pkill -USR1 waybar";
            };
        };

        environment.systemPackages = with pkgs; [
            waybar
        ];
    };

    flake.homeModules.waybar = { ... }: {
        xdg.config.files = {
            "waybar/config.jsonc".source = ./config.jsonc;
            "waybar/style.css".source = ./style.css;
        };
    };
}

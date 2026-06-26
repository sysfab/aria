{ ... }:

{
    flake.nixosModules.waybar = { pkgs, ... }: {
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

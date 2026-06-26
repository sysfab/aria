{ ... }:

{
    flake.nixosModules.swaync = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            swaynotificationcenter
        ];
    };

    flake.homeModules.swaync = { ... }: {
        xdg.config.files = {
            "swaync/config.json".source = ./config.json;
            "swaync/style.css".source = ./style.css;
        };
    };
}

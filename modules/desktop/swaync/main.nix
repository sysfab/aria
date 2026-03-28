{ ... }:

let
    style = builtins.readFile ./style.css;
in
{
    flake.homeModules.swaync = { pkgs, ... }: {
        services.swaync = {
            enable = true;

            style = style;
            settings.source = ./config.json;
        };
    };
}
{ ... }:

let
    style = builtins.readFile ./style.css;
in
{
    flake.homeModules.swaync = { pkgs, ... }: {
        programs.waybar = {
            enable = true;

            settings.text = import ./_config/main.nix;
            style = style;

            systemd.enable = false;
        };
    };
}
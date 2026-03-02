{ ... }:

let
    config = builtins.readFile ./config.rasi;
in
{
    flake.homeModules.rofi = { pkgs, ... }: {
        programs.rofi = {
            enable = true;

            theme = ./theme.rasi;
            extraConfig = {
                modi = "drun";
                show-icons = false;
                terminal = "kitty";

                drun-display-format = "{name}";
                cycle = true;

                matching = "normal";
                case-sensitive = false;
            };
        };
    };
}
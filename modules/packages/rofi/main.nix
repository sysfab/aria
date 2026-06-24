{ ... }:

{
    flake.nixosModules.rofi = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            rofi
        ];
    };

    flake.homeModules.rofi = { ... }: {
        xdg.config.files = {
            "rofi/config.rasi".source = ./config.rasi;
            "rofi/theme.rasi".source = ./theme.rasi;
        };
    };
}

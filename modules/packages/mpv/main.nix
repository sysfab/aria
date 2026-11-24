{ ... }:

{
    flake.nixosModules.mpv = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            mpv.override {
                scripts = with pkgs.mpvScripts; [
                    uosc
                ];
            }
        ];
    };

    flake.homeModules.mpv = { ... }: {
        xdg.config.files = {
            "mpv/mpv.conf".source = ./mpv.conf;
            "mpv/script-opts/uosc.conf".source = ./scripts/uosc.conf;
        };
    };
}

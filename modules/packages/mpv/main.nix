{ ... }:

{
    flake.nixosModules.mpv = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            mpv
        ];
    };

    flake.homeModules.mpv = { ... }: {
        xdg.config.files = {
            "mpv/mpv.conf".source = ./mpv.conf;
        };
    };
}

{ ... }:

{
    flake.nixosModules.foot = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            foot
        ];
    };

    flake.homeModules.foot = { ... }: {
        xdg.config.files = {
            "foot/foot.ini".source = ./foot.ini;
        };
    };
}

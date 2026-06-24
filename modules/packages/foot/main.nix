{ ... }:

{
    flake.nixosModules.foot = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            foot
        ];
    };

    flake.homeModules.foot = { ... }: {
        xdg.config.files = {
            "foot/foot.init".source = ./foot.ini;
        };
    };
}

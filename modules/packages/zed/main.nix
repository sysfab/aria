{ ... }:

{
    flake.nixosModules.zed = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            zed-editor
            nixd
            nil
        ];
    };

    flake.homeModules.zed = { ... }: {
        xdg.config.files = {
            "zed/settings.json".source = ./settings.json;
        };
    };
}

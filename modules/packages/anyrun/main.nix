{ inputs, ... }:

{
    flake.nixosModules.anyrun = { ... }: {
        environment.systemPackages = [
            inputs.anyrun.packages.x86_64-linux.anyrun-with-all-plugins
        ];

        aria.picker.handler = "anyrun --plugins libstdin.so";

        nix.settings = {
            builders-use-substitutes = true;
            substituters = ["https://anyrun.cachix.org"];
            trusted-substituters = ["https://anyrun.cachix.org"];
            trusted-public-keys = ["anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="];
            trusted-users = ["root" "@wheel"];
        };
    };

    flake.homeModules.anyrun = { ... }: {
        xdg.config.files = {
            "anyrun/config.ron".source = ./config.ron;
            "anyrun/style.css".source = ./style.css;

            "anyrun/nix-run.ron".source = ./plugins/nix-run.ron;
            "anyrun/websearch.ron".source = ./plugins/websearch.ron;
        };
    };
}

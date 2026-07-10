{ inputs, ... }:

{
    flake.nixosModules.walker = { pkgs, ... }: {
        environment.systemPackages = [
            pkgs.elephant
            inputs.walker.packages.x86_64-linux.default
        ];

        nix.settings = {
            extra-substituters = [
                "https://nix-community.cachix.org"
                "https://walker.cachix.org"
                "https://walker-git.cachix.org"
            ];
            extra-trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
                "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
            ];
        };
    };

    flake.homeModules.walker = { ... }: {
        xdg.config.files = {
            "walker/config.toml".source = ./config.toml;
            "walker/themes/aria".source = ./theme;
        };
    };
}

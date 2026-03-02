{ inputs, ... }:

{
    flake.nixosConfigurations.example = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = inputs.aria.all.system ++ [
            inputs.home-manager.nixosModules.home-manager {
                home-manager = {
                    sharedModules = inputs.aria.all.home;
                    extraSpecialArgs = { inherit inputs; };

                    useGlobalPkgs = true;
                    useUserPackages = true;

                    users.example = {
                        home.stateVersion = "25.05";
                    };
                };
            }
        ];
    };
}
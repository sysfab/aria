{
    description = "Minimalistic NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        parts = {
            url = "github:nix-aria/parts";
            inputs.nixpkgs-lib.follows = "nixpkgs";
        };

        hjem = {
            url = "github:feel-co/hjem";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        anyrun.url = "github:anyrun-org/anyrun";
        zen-browser = {
            url = "github:youwen5/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ { self, ... }:
    let
        modules = (inputs.parts.import ./modules);
    in
    inputs.parts.lib.mkFlake { inherit inputs; } {
        flake = {
            parts = inputs.parts;

            lib = {
                import = inputs.parts.import;
                mkFlake = inputs.parts.lib.mkFlake;
            };

            modules = {
                system = [
                    inputs.hjem.nixosModules.default
                    inputs.nix-index-database.nixosModules.default
                    ({...}: {
                        hjem = {
                            clobberByDefault = true;
                            linker = null;
                        };
                    })
                ] ++ builtins.attrValues self.nixosModules;

                home = builtins.attrValues self.homeModules;
            };
        };

        imports = [
            ({lib, ...}: {
                options.flake = {
                    homeModules = lib.mkOption {
                        type = lib.types.lazyAttrsOf lib.types.deferredModule;
                        default = { };
                    };

                    lib = lib.mkOption {
                        type = lib.types.lazyAttrsOf lib.types.raw;
                        default = {};
                    };
                };
            })
        ] ++ modules;
    };
}

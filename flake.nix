{
    description = "Minimalistic NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        parts.url = "github:hercules-ci/flake-parts";

        hjem = {
            url = "github:feel-co/hjem";
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
        importlib = import ./import.nix;
        modules = (importlib ./modules);
    in
    inputs.parts.lib.mkFlake { inherit inputs; } {
        flake = {
            parts = inputs.parts;

            lib = {
                import = importlib;
                mkFlake = inputs.parts.lib.mkFlake;
            };

            modules = {
                system = [
                    inputs.hjem.nixosModules.default
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
            ({lib, flake-parts-lib, ...}: {
                options.flake = flake-parts-lib.mkSubmoduleOptions {
                    homeModules = lib.mkOption {
                        type = lib.types.lazyAttrsOf lib.types.deferredModule;
                        default = { };
                    };
                };
            })
        ] ++ modules;
    };
}

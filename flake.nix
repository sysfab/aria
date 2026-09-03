{
    description = "Minimalistic NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-parts.url = "github:hercules-ci/flake-parts";

        hjem = {
            url = "github:feel-co/hjem";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # other
        anyrun.url = "github:anyrun-org/anyrun";
        zen-browser = {
            url = "github:youwen5/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ { self, ... }:
        let
            modules = let importTree = import ./import.nix; in
                (importTree ./modules).imports;
        in
        inputs.flake-parts.lib.mkFlake { inherit inputs; }
            {
                systems = ["x86_64-linux"];

                flake.all = {
                    home = builtins.attrValues self.homeModules;

                    system = [
                        inputs.hjem.nixosModules.default
                        ({...}: let
                            modules = builtins.attrValues self.homeModules;
                        in {
                            hjem = {
                                extraModules = modules;
                                clobberByDefault = true;
                            };
                        })
                    ] ++ (builtins.attrValues self.nixosModules);
                };

                imports = [
                    (
                        {lib, flake-parts-lib, ...}: {
                            options = {
                                flake = flake-parts-lib.mkSubmoduleOptions {
                                    homeModules = lib.mkOption {
                                        type = lib.types.lazyAttrsOf lib.types.deferredModule;
                                        default = { };
                                    };
                                };
                            };
                        }
                    )
                ] ++ modules;
            };
}

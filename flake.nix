{
    description = "Minimalistic NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        wrappers.url = "github:lassulus/wrappers";

        hjem = {
            url = "github:feel-co/hjem";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        flake-parts.url = "github:hercules-ci/flake-parts";
        import-tree.url = "github:vic/import-tree";
    };

    outputs = inputs @ { self, ... }:
        let
            modules = [ (inputs.import-tree ./modules) ];
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
                            hjem.extraModules = modules;
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
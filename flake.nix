{
    description = "Minimalistic x86_64 NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        flake-parts.url = "github:hercules-ci/flake-parts";
        import-tree.url = "github:vic/import-tree";
    };

    outputs = inputs @ { self, ... }:
        let
            modules = (inputs.import-tree ./modules).imports;
        in
        inputs.flake-parts.lib.mkFlake { inherit inputs; }
            {
                systems = ["x86_64-linux"];

                flake.all = {
                    system = builtins.attrValues self.nixosModules;
                    home = builtins.attrValues self.homeModules;
                };

                imports = modules ++ [
                    inputs.home-manager.flakeModules.home-manager
                ];
            };
}
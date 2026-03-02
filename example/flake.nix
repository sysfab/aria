{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        flake-parts.url = "github:hercules-ci/flake-parts";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        aria.url = "github:sysfab/aria";
        import-tree.url = "github:vic/import-tree";
    };

    outputs = inputs @ { self, ... }:
        let
            modules = (inputs.import-tree ./modules).imports;
        in
        inputs.flake-parts.lib.mkFlake { inherit inputs; }
            {
                systems = ["x86_64-linux"];

                imports = modules ++ [
                    inputs.home-manager.flakeModules.home-manager
                ];
            };
}
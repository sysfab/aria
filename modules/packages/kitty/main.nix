{ inputs, ... }:

{
    perSystem = { pkgs, ... }: {
        packages.kitty = inputs.wrappers.lib.wrapPackage {
            inherit pkgs;
            package = pkgs.kitty;

            flags = {
                "--config" = ./config.conf;
            };
        };
    };
}
{ inputs, ... }:

{
    perSystem = { pkgs, ... }: {
        packages.waybar = inputs.wrappers.lib.wrapPackage {
            inherit pkgs;
            package = pkgs.waybar;

            flags = {
                "--config" = ./config.jsonc;
                "--style"  = ./style.css;
            };
        };
    };
}

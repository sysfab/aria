{ inputs, ... }:

{
    perSystem = { pkgs, ... }: {
        packages.swaync = inputs.wrappers.lib.wrapPackage {
            inherit pkgs;
            package = pkgs.swaynotificationcenter;

            flags = {
                "--config" = ./config.json;
                "--style"  = ./style.css;
            };
        };
    };
}

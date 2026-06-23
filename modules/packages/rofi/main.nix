{ inputs, ... }:

{
    perSystem = { pkgs, ... }: {
        packages.rofi = inputs.wrappers.lib.wrapPackage {
            inherit pkgs;
            package = pkgs.rofi;

            flags = {
                "-config" = ./config.rasi;
                "-theme"  = ./theme.rasi;
            };
        };
    };
}

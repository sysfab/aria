{ inputs, ... }:

{
    perSystem = { pkgs, ... }: {
        packages.foot = inputs.wrappers.lib.wrapPackage {
            inherit pkgs;
            package = pkgs.foot;

            flags = {
                "--config" = ./foot.ini;
            };
        };
    };
}

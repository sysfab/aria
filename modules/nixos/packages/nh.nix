{ ... }:

{
    flake.nixosModules.nh = { ... }: {
        programs.nh = {
            enable = true;

            clean = {
                enable = true;
                extraArgs = "--keep 3 --keep-since 3d";
            };
        };
    };
}

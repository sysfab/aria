{ ... }:

{
    flake.nixosModules.nh = { lib, config, ... }: {
        options.aria.flake = lib.mkOption {
            type = lib.types.str;
            default = "";
        };

        config = {
            programs.nh = {
                enable = lib.mkForce true;
                flake = lib.mkForce config.aria.flake;

                clean = {
                    enable = true;
                    extraArgs = "--keep 3 --keep-since 3d";
                };
            };

            assertions = [
                {
                    assertion = config.aria.flake != "";
                    message = "aria.flake must be defined - it's your system flake path";
                }
            ];
        };
    };
}

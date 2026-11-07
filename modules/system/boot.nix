{ ... }:

{
    flake.nixosModules.boot = { ... }: {
        boot = {
            loader = {
                limine = {
                    enable = true;
                    maxGenerations = 20;

                    style = {
                        wallpapers = [];
                        backdrop = "000000";
                    };

                    extraConfig = ''
                        quiet: yes
                    '';
                };

                timeout = 1;
            };

            consoleLogLevel = 0;
            kernelParams = [
                "quiet"
                "loglevel=3"
            ];
        };
    };
}

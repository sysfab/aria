{ ... }:

{
    flake.nixosModules.boot = { ... }: {
        boot = {
            loader = {
                grub = {
                    enable = true;

                    theme = ./grub-theme;
                    splashImage = ./grub-theme/background.jpeg;
                };

                timeout = 3;
            };

            consoleLogLevel = 3;

            kernelParams = [
                "quiet"
                "systemd.show_status=false"
                "rd.udev.log_level=3"
            ];
        };
    };
}

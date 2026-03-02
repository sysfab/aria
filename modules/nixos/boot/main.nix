{ ... }:

{
    flake.nixosModules.boot = { pkgs, ... }: {
        boot = {
            loader = {
                grub = {
                    enable = true;

                    efiSupport = true;
                    device = "nodev";

                    theme = ./grub-theme;
                    splashImage = ./grub-theme/background.jpeg;
                };

                timeout = 1;
                efi.canTouchEfiVariables = true;
            };

            consoleLogLevel = 0;

            kernelParams = [
                "8250.nr_uarts=0"

                "quiet"

                "systemd.show_status=false"
                "rd.systemd.show_status=false"

                "rd.udev.log_level=3"
                "loglevel=3"

                "boot.shell_on_fail"
            ];

            initrd.systemd.enable = true;
            initrd.verbose = false;
        };
    };
}
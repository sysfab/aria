{ ... }:

{
    flake.nixosModules.desktop = { pkgs, ... }: {
        services.gvfs.enable = true;

        environment.systemPackages = with pkgs; [
            gsettings-desktop-schemas
            glib
            virtiofsd
            libnotify
            xdg-utils
            libxcvt
            pulseaudio #for cli commands
            wl-clipboard
        ];
    };

    flake.homeModules.desktop = { lib, pkgs, ... }: {
        xdg.portal.enable = lib.mkForce false;

        home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
        };

        home.packages = with pkgs; [
            adw-gtk3
            adwaita-icon-theme
            papirus-icon-theme
            gnome-themes-extra

            swww
            hyprshot
            
            kitty
            nautilus
            pavucontrol
            coppwr
            clapper
            decibels
            loupe
            gnome-system-monitor
        ];
    };
}
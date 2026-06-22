{ moduleWithSystem, ... }: 

{
    flake.nixosModules.desktop = moduleWithSystem (
        perSystem@{ self', ... }:
        { pkgs, ...}:
        {
            services.gvfs.enable = true;
            programs.dconf.enable = true;

            environment.systemPackages = with pkgs; [
                #utils, libs
                gsettings-desktop-schemas
                glib
                virtiofsd
                libnotify
                xdg-utils
                libxcvt
                pulseaudio
                wl-clipboard

                #themes
                adw-gtk3
                adwaita-icon-theme
                papirus-icon-theme
                gnome-themes-extra

                #packages
                awww
                hyprshot
                nautilus
                pavucontrol
                coppwr
                decibels
                loupe
                gnome-system-monitor

                #wrapped packages
                perSystem.self'.packages.waybar
                perSystem.self'.packages.swaync
                perSystem.self'.packages.rofi
                perSystem.self'.packages.foot
                perSystem.self'.packages.vscodium
            ];
        }
    );
}
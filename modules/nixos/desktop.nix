{ ... }:

{
    flake.nixosModules.desktop = { pkgs, ... }: {
        services.gvfs.enable = true;
        programs.dconf.enable = true;

        environment.systemPackages = with pkgs; [
            # utils, libs
            gsettings-desktop-schemas
            glib
            virtiofsd
            libnotify
            xdg-utils
            libxcvt
            pulseaudio
            wl-clipboard

            # themes
            adw-gtk3
            adwaita-icon-theme
            papirus-icon-theme
            gnome-themes-extra

            # packages
            awww
            nautilus
            pavucontrol
            qpwgraph
            decibels
            loupe
            gnome-system-monitor
        ];
    };
}

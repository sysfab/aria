{ inputs, ... }:

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
            wtype

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
            inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
    };
}

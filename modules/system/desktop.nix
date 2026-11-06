{ ... }:

{
    flake.nixosModules.desktop = { pkgs, ... }: {
        # for nautilus
        services.gvfs.enable = true;

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
            gnome-themes-extra

            # packages
            nautilus
            pavucontrol
            qpwgraph
            gnome-system-monitor
        ];
    };
}

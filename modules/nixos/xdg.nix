{ ... }:

{
    flake.nixosModules.xdg = { pkgs, ... }: {
        xdg = {
            icons.enable = true;

            mime = {
                enable = true;
                defaultApplications = {
                    "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
                    "application/octet-stream" = "org.gnome.Nautilus.desktop";

                    "x-scheme-handler/http" = [ "io.github.zen_browser.zen.desktop" ];
                    "x-scheme-handler/https" = [ "io.github.zen_browser.zen.desktop" ];
                    "text/html" = [ "io.github.zen_browser.zen.desktop" ];

                    "text/plain" = [ "codium.desktop" ];
                    "text/x-python" = [ "codium.desktop" ];
                    "text/x-shellscript" = [ "codium.desktop" ];
                    "text/x-csrc" = [ "codium.desktop" ];
                    "text/x-c++src" = [ "codium.desktop" ];
                    "text/x-java-source" = [ "codium.desktop" ];
                    "application/json" = [ "codium.desktop" ];
                    "application/xml" = [ "codium.desktop" ];
                    "application/javascript" = [ "codium.desktop" ];
                    "application/x-yaml" = [ "codium.desktop" ];

                    "audio/*" = [ "mpv.desktop" ];
                    "video/*" = [ "mpv.desktop" ];
                    "application/x-matroska" = [ "mpv.desktop" ];

                    "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
                    "image/png" = [ "org.gnome.Loupe.desktop" ];
                    "image/gif" = [ "org.gnome.Loupe.desktop" ];
                    "image/webp" = [ "org.gnome.Loupe.desktop" ];
                    "image/tiff" = [ "org.gnome.Loupe.desktop" ];
                    "image/bmp" = [ "org.gnome.Loupe.desktop" ];
                    "image/svg+xml" = [ "org.gnome.Loupe.desktop" ];
                    "image/vnd.microsoft.icon" = [ "org.gnome.Loupe.desktop" ];
                };
            };

            portal = {
                enable = true;
                xdgOpenUsePortal = true;

                extraPortals = [
                    pkgs.xdg-desktop-portal-gnome
                    pkgs.xdg-desktop-portal-gtk
                ];

                config = {
                    common = {
                        "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
                        "org.freedesktop.impl.portal.Settings" = [ "gnome" ];
                    };

                    hyprland = {
                        "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
                        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
                        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];

                        default = [ "hyprland" "gtk" ];
                    };
                };
            };
        };
    };
}

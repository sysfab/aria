{ ... }:

{
    flake.nixosModules.xdg = { pkgs, ... }:
    let
        nautilus = "org.gnome.Nautilus.desktop";
        zen = "io.github.zen_browser.zen.desktop";
        codium = "codium.desktop";
        mpv = "mpv.desktop";
    in
    {
        xdg = {
            icons.enable = true;

            mime = {
                enable = true;
                defaultApplications = {
                    "inode/directory" = [ nautilus ];
                    "application/octet-stream" = [ nautilus ];

                    "x-scheme-handler/http" = [ zen ];
                    "x-scheme-handler/https" = [ zen ];
                    "text/html" = [ zen ];

                    "text/plain" = [ codium ];
                    "text/x-python" = [ codium ];
                    "text/x-shellscript" = [ codium ];
                    "text/x-csrc" = [ codium ];
                    "text/x-c++src" = [ codium ];
                    "text/x-java-source" = [ codium ];
                    "application/json" = [ codium ];
                    "application/xml" = [ codium ];
                    "application/javascript" = [ codium ];
                    "application/x-yaml" = [ codium ];

                    "audio/*" = [ mpv ];
                    "video/*" = [ mpv ];
                    "application/x-matroska" = [ mpv ];

                    "image/jpeg" = [ mpv ];
                    "image/png" = [ mpv ];
                    "image/gif" = [ mpv ];
                    "image/webp" = [ mpv ];
                    "image/tiff" = [ mpv ];
                    "image/bmp" = [ mpv ];
                    "image/svg+xml" = [ mpv ];
                    "image/vnd.microsoft.icon" = [ mpv ];
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

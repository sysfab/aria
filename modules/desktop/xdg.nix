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

                    "x-scheme-handler/http" = [ "google-chrome.desktop" ];
                    "x-scheme-handler/https" = [ "google-chrome.desktop" ];
                    "text/html" = [ "google-chrome.desktop" ];

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

                    "audio/mpeg" = [ "org.gnome.Decibels.desktop" ];
                    "audio/flac" = [ "org.gnome.Decibels.desktop" ];
                    "audio/mp4" = [ "org.gnome.Decibels.desktop" ];
                    "audio/ogg" = [ "org.gnome.Decibels.desktop" ];
                    "audio/x-wav" = [ "org.gnome.Decibels.desktop" ];
                    "audio/aac" = [ "org.gnome.Decibels.desktop" ];

                    "video/mp4" = [ "com.github.rafostar.Clapper.desktop" ];
                    "video/x-matroska" = [ "com.github.rafostar.Clapper.desktop" ];
                    "video/webm" = [ "com.github.rafostar.Clapper.desktop" ];
                    "video/quicktime" = [ "com.github.rafostar.Clapper.desktop" ];
                    "video/x-flv" = [ "com.github.rafostar.Clapper.desktop" ];
                    "video/x-msvideo" = [ "com.github.rafostar.Clapper.desktop" ];
                    "application/x-matroska" = [ "com.github.rafostar.Clapper.desktop" ];
                
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
                    pkgs.xdg-desktop-portal-hyprland
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
{ ... }:

{
    flake.nixosModules.styling = { ... }: {
        programs.dconf = {
            enable = true;

            profiles.user.databases = [
                {
                    settings."org/gnome/desktop/interface" = {
                        color-scheme = "prefer-dark";
                    };
                }
            ];
        };

        qt = {
            enable = true;
            style = "adwaita-dark";
        };

        environment.sessionVariables = {
            COLOR_SCHEME = "prefer-dark";
            QT_STYLE_OVERRIDE = "adwaita-dark";
            QT_QPA_PLATFORMTHEME = "gnome";
        };
    };

    flake.homeModules.styling = { ... }: {
        xdg.config.files."gtk-3.0/settings.ini".text = ''
            [Settings]
            gtk-theme-name=Adwaita-dark
            gtk-application-prefer-dark-theme=1
        '';

        xdg.config.files."gtk-4.0/gtk.css".text = ''
            :root {
                --window-bg-color: #000000;
                --view-bg-color: #000000;
                --headerbar-bg-color: #000000;
                --sidebar-bg-color: #000000;
                --headerbar-border-color: #000000;
                --headerbar-backdrop-color: #000000;
                --sidebar-backdrop-color: #000000;
                --window-border: none;
            }
            window { background-color: #000000; }

            popover > contents {
                background-color: #000000;
                color: #ffffff;
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 12px;
            }

            popover arrow {
                background-color: #000000;
                border-color: rgba(255, 255, 255, 0.2);
            }

            popover modelbutton {
                color: #ffffff;
            }

            popover modelbutton:hover {
                background-color: rgba(255, 255, 255, 0.15);
                color: #ffffff;
            }
        '';
    };
}

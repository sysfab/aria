{ ... }:

{
    flake.homeModules.gtk = { ... }: {
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

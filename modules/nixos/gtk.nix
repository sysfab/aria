{ ... }:

{
    flake.homeModules.gtk = { ... }: {
        xdg.config.files."gtk-4.0/gtk.css".text = ''
            /* --- Main Window --- */
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

            /* The container of the menu */
            popover > contents {
                background-color: #000000;
                color: #ffffff;
                /* Essential: Add a border so the menu stands out against the black window */
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 12px;
            }

            /* The little arrow pointing to where you clicked */
            popover arrow {
                background-color: #000000;
                border-color: rgba(255, 255, 255, 0.2);
            }

            /* Menu Items (Buttons) */
            popover modelbutton {
                color: #ffffff;
            }

            /* Hover effect: When you mouse over "Copy", "Paste", etc. */
            popover modelbutton:hover {
                background-color: rgba(255, 255, 255, 0.15);
                color: #ffffff;
            }
        '';
    };
}

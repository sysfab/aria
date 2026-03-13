{ ... }:

{
    flake.homeModules.gtk = { pkgs, ... }: 
    let
        yamis-icons = (pkgs.callPackage ./_icons.nix {});
    in
    {
        dconf = {
            enable = true;
            settings."org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
            };
        };

        gtk = {
            enable = true;

            theme = {
                name = "Adwaita-dark";
                package = pkgs.gnome-themes-extra;
            };

            iconTheme = {
                name = "YAMIS";
                package = yamis-icons;
            };

            cursorTheme = {
                name = "Vimix-cursors";
                package = pkgs.vimix-cursors;
            };


            gtk4.extraCss = ''
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

                /* --- Context Menus (Popovers) --- */
                
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
    };
}
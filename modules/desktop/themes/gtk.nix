{ ... }:

{
    flake.homeModules.gtk = { pkgs, ... }: 
    let
        yamis-icons = pkgs.stdenv.mkDerivation {
            pname = "yet-another-monochrome-icon-set";
            version = "latest";

            src = pkgs.fetchgit {
                url = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set.git";
                rev = "2b3ad4983f1943e2d6c48951d6b6970ca97b4fa5"; 
                sha256 = "sha256-rt2oMlGQAM5xKzye8JgEeJY5KQ8DCWseaCZux2zCOGQ=";
            };

            installPhase = ''
                mkdir -p $out/share/icons/YAMIS
                cp -r * $out/share/icons/YAMIS/
            '';
        };
    in
    {
        programs.dconf.enable = true;
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
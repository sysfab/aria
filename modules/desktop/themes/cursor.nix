{ ... }:

{
    flake.homeModules.cursor = { pkgs, ... }: {
        home.pointerCursor = {
            enable = true;
            package = pkgs.vimix-cursors;
            name = "Vimix-cursors";
            size = 22;
            gtk.enable = true;
        };
    };
}
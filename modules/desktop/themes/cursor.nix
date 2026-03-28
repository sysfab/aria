{ ... }:

{
    flake.homeModules.cursor = { pkgs, ... }:
    let
        moga-cursor = (pkgs.callPackage ./assets/Moga-Cursor/_package.nix {});
    in
    {
        home.pointerCursor = {
            enable = true;
            package = moga-cursor;
            name = "Moga-Cursor";
            size = 22;
            gtk.enable = true;
        };
    };
}
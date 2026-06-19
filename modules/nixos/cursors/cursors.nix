{ ... }:

{
    flake.nixosModules.cursors = { pkgs, ... }:
    let
        cursor = (pkgs.callPackage ./assets/Moga-Cursor/_package.nix {});
    in
    {
        environment.systemPackages = [
            cursor
        ];
    };

    flake.homeModules.cursors = { ... }:
    let
        cursor-path = ./assets/Moga-Cursor/Moga-Cursor;
    in
    {
        files.".icons/default".source = cursor-path; 
    };
}
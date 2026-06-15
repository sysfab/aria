{ ... }:

{
    flake.nixosModules.cursors = { pkgs, ... }:
    let
        moga-cursor = (pkgs.callPackage ./assets/Moga-Cursor/_package.nix {});
    in
    {
        environment.systemPackages = [
            moga-cursor
        ];
    };
}
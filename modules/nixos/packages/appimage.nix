{ ... }:

{
    flake.nixosModules.appimage = { pkgs, ... }: {
        programs.appimage = {
            enable = true;
            binfmt = true;
        };
    };
}
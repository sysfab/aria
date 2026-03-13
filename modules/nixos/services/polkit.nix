{ ... }:

{
    flake.nixosModules.polkit = { pkgs, ... }: {
        security.soteria.enable = true;
    };
}
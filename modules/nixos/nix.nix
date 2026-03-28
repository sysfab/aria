{ inputs, ... }:

{
    flake.nixosModules.nix = { pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
    };
}
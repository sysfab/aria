{ ... }:

{
    flake.nixosModules.network-manager = { pkgs, ... }: {
        networking.networkmanager.enable = true;
        systemd.services.NetworkManager-wait-online.enable = false;
    };
}
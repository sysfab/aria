{ ... }:

{
    flake.nixosModules.network = { pkgs, lib, config, ... }: {
        networking.networkmanager.enable = lib.mkDefault true;

        # Fixes
        environment.etc."ssl/cert.pem".source = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
        systemd.services = lib.mkIf config.networking.networkmanager.enable {
            NetworkManager-wait-online.enable = lib.mkDefault false;
        };
    };
}

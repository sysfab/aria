{ ... }:

{
    flake.nixosModules.shell-packages = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            zip
            unzip
            fd
            jq
            wget
            curl
            usbutils
        ];
    };
}

{ ... }:

{
    flake.nixosModules.shell-packages = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            zip
            unzip
            bat
            eza
            ripgrep
            fd
            jq
            wget
            curl
            usbutils
        ];
    };
}
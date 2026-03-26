{ ... }:

{
    flake.nixosModules.nix-ld = { pkgs, ... }: {
        programs.nix-ld = {
            enable = true;

            libraries = with pkgs; [
                zlib
                glib
                libGL
                libx11
                libxext
                libxrender
                libxi
                libxrandr
                libxcursor
                libxfixes
                libxinerama
                libxcb
                libdrm
                wayland-protocols
                wayland
                pkg-config
                libxkbcommon
                libgcc
                gccNGPackages_15.libstdcxx 
                zstd
                stdenv.cc.cc
                curl
                openssl
                attr
                libssh
                bzip2
                libxml2
                acl
                libsodium
                util-linux
                xz
                systemd
            ];
        };
    };
}
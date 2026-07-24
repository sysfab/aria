{ ... }:

{
    flake.nixosModules.nix-ld = { pkgs, ... }: {
        programs.nix-ld = {
            enable = true;

            libraries = with pkgs; [
                glib
                zlib
                stdenv.cc.cc
                libgcc

                # X11
                libx11
                libxcb
                libxext
                libxrender
                libxi
                libxrandr
                libxcursor
                libxfixes
                libxinerama

                # Wayland
                wayland
                libxkbcommon

                # GPU
                libdrm

                # Common
                zstd
                curl
                openssl
                bzip2
                xz
            ];
        };
    };
}

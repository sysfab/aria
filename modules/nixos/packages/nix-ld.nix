{ ... }:

{
    flake.nixosModules.nix-ld = { pkgs, ... }: {
        programs.nix-ld = {
            enable = true;

            libraries = with pkgs; [
                libgcc gccNGPackages_15.libstdcxx zlib zstd stdenv.cc.cc curl openssl attr libssh bzip2 libxml2 acl libsodium util-linux xz systemd
            ];
        };
    };
}
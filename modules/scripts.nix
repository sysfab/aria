{ lib, ... }:

{
    flake.nixosModules.scripts = { config, pkgs, ... }: {
        options.aria.flake = lib.mkOption {
            type = lib.types.str;
            default = "";
        };

        config = let
            setup-github-token = ''if token=$(gh auth token); then
                export NIX_CONFIG="access-tokens = github.com=$token"
            fi'';

            rebuild = pkgs.writeShellScriptBin "rebuild" ''
                set -e
                ${setup-github-token}
                nh os switch
            '';

            update = pkgs.writeShellScriptBin "update" ''
                set -e
                ${setup-github-token}
                pushd "''${NH_OS_FLAKE:-$NH_FLAKE}"
                nix flake update
                popd
            '';

            collect-garbage = pkgs.writeShellScriptBin "collect-garbage" ''
                set -e
                nh clean all
            '';
        in {
            environment.systemPackages = [
                rebuild
                update
                collect-garbage
            ];

            programs.nh = {
                enable = lib.mkForce true;
                flake = lib.mkForce config.aria.flake;

                clean = {
                    enable = true;
                    extraArgs = "--keep 3 --keep-since 3d";
                };
            };

            assertions = [
                {
                    assertion = config.aria.flake != "";
                    message = "aria.flake must be defined - it's your system flake path";
                }
            ];
        };
    };
}

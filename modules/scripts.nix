{ self, lib, ... }:

{
    flake.lib.setup-github-token = ''
        if token=$(gh auth token 2>/dev/null); then
            export NIX_CONFIG="''${NIX_CONFIG:-}
        access-tokens = github.com=$token"
        fi
    '';

    flake.nixosModules.scripts = { config, pkgs, ... }: {
        options.aria = {
            flake = lib.mkOption {
                type = lib.types.str;
                default = "";
            };

            scripts = lib.mkOption {
                type = lib.types.attrsOf lib.types.str;
                default = {};
            };
        };

        config = {
            aria.scripts = {
                rebuild = ''
                    ${self.lib.setup-github-token}
                    exec nh os switch "$@"
                '';

                update = ''
                    ${self.lib.setup-github-token}
                    cd ${lib.escapeShellArg config.aria.flake}
                    exec nix flake update "$@"
                '';

                upgrade = ''
                    update
                    exec rebuild "$@"
                '';

                collect-garbage = ''
                    exec nh clean all "$@"
                '';
            };

            environment.systemPackages = lib.mapAttrsToList
                (name: script: pkgs.writeShellScriptBin name ''
                    set -euo pipefail
                    ${script}
                '')
                config.aria.scripts;

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

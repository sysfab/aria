{ ... }:

{
    flake.nixosModules.shell = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            bat
            eza
            ripgrep
            zoxide
        ];

        programs.zsh = {
            enable = true;
            syntaxHighlighting.enable = true;
        };

        programs.starship.enable = true;

        programs.command-not-found.enable = false;
        programs.nix-index.enableZshIntegration = false;
    };

    flake.homeModules.shell = { lib, config, ... }: {
        options.aria.shell = {
            aliases = lib.mkOption {
                type = lib.types.attrsOf lib.types.str;
                default = {};
                description = "Shell aliases";
            };

            extraConfig = lib.mkOption {
                type = lib.types.str;
                default = "";
            };

            extraProfile = lib.mkOption {
                type = lib.types.str;
                default = "";
            };
        };

        config = let
            mkAliases = aliases:
                lib.concatStringsSep "\n" (
                    lib.mapAttrsToList (name: command:
                        "alias ${lib.escapeShellArg name}=${lib.escapeShellArg command}"
                    ) aliases
                ) + "\n";
        in {
            aria.shell.aliases = lib.mapAttrs (
                _: value: lib.mkDefault value
            ) {
                cd = "z";
                cdi = "zi";
                cat = "bat";
                catp = "bat --plain";
                ls = "eza --long --color=always --no-user --no-permissions --no-filesize --no-time";
                lsf = "eza --long";
            };

            files = {
                ".zshrc".text = mkAliases config.aria.shell.aliases + builtins.readFile zsh/.zshrc + config.aria.shell.extraConfig;
                ".zprofile".text = builtins.readFile zsh/.zprofile + config.aria.shell.extraProfile;
            };

            xdg.config.files = {
                "starship.toml".source  = starship/starship.toml;
            };
        };
    };
}

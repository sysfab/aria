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

    flake.homeModules.shell = { ... }: {
        files = {
            ".zprofile".source = zsh/.zprofile;
            ".zshrc".source = zsh/.zshrc;
        };

        xdg.config.files = {
            "starship.toml".source  = starship/starship.toml;
        };
    };
}

{ ... }:

{
    flake.nixosModules.shell = { ... }: {
        programs.zsh = {
            enable = true;
            syntaxHighlighting.enable = true;
        };

        programs.starship = {
            enable = true;
        };
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

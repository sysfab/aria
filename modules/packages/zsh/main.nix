{ ... }:

{
    flake.nixosModules.zsh = { ... }: {
        programs.zsh = {
            enable = true;
        };
    };

    flake.homeModules.zsh = { ... }: {
        files = {
            ".zprofile".source = ./.zprofile;
            ".zshrc".source = ./.zshrc;
        };
    };
}

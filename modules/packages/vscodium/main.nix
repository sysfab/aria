{ pkgs, ... }:

{
    flake.homeModules.vscodium = { ... }: {
        xdg.config.files."VSCodium/User/settings.json".source = ./settings.json;
    };

    perSystem = { pkgs, ... }: {
        packages.vscodium = pkgs.vscode-with-extensions.override {
            vscode = pkgs.vscodium;
            vscodeExtensions = with pkgs.vscode-extensions; [
                bbenoist.nix
                        
                donjayamanne.githistory
                usernamehw.errorlens
                viktorqvarfordt.vscode-pitch-black-theme
            ];
        };
    };
}
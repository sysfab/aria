{ pkgs, ... }:

{
    flake.homeModules.vscode = { pkgs, ... }: {
        programs.vscode = {
            enable = true;
            package = pkgs.vscodium;

            mutableExtensionsDir = false;

            profiles = {
                "default" = {
                    enableUpdateCheck = false;
                    enableExtensionUpdateCheck = false;

                    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);

                    extensions = with pkgs.vscode-extensions; [
                        bbenoist.nix
                        
                        donjayamanne.githistory
                        usernamehw.errorlens
                        viktorqvarfordt.vscode-pitch-black-theme
                    ];
                };
            };
        };
    };
}
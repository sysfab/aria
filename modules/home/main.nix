{ ... }:

let
    bashrc = builtins.readFile ./.bashrc;
    bash_profile = builtins.readFile ./.bash_profile;
in
{
    flake.homeModules.home = { pkgs, ... }: {
        dconf.enable = true;

        home.file = {
            "Pictures/Wallpapers/aria.jpg".source = ./aria.jpg;
            ".aria/.keep".text = "";
        };

        home.packages = [
            (pkgs.callPackage ./_bin/pick-power.nix {})

            (pkgs.callPackage ./_bin/pick-wallpaper.nix {})
            (pkgs.callPackage ./_bin/update-wallpaper.nix {})
        ];

        programs.bash = {
            enable = true;

            bashrcExtra = bashrc;
            initExtra = bash_profile;

            shellAliases = {
                cat = "bat";
                ls = "eza --long --color=always --icons=always --no-user --no-permissions";
                sd = "rg";
                code = "codium";
            };

            enableCompletion = true;
        };
    };
}
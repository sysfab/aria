{ ... }:

{
    flake.homeModules.home = { ... }: {
        files = {
            "Pictures/Wallpapers/aria.jpg".source = ./aria.jpg;
            ".aria/.keep".text = "";

            ".bashrc".source = ./.bashrc;
            ".bash_profile".source = ./.bash_profile;
        };
    };
}

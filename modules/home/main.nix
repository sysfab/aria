{ ... }:

{
    flake.homeModules.home = { ... }: {
        files = {
            "Pictures/Wallpapers/aria.jpg".source = ./aria.jpg;
            ".aria/.keep".text = "";
        };
    };
}

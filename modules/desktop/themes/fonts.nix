{ ... }:

{
    flake.homeModules.fonts = { pkgs, ... }: {
        home.packages = with pkgs; [
            font-awesome
            corefonts
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-cjk-serif
            noto-fonts-color-emoji
        ];

        fonts = {
            fontconfig = {
                enable = true;

                defaultFonts = {
                    emoji = ["Noto Color Emoji"];
                };
            };
        };
    };
}
{ ... }:

{
    flake.nixosModules.fonts = { pkgs, ... }: {
        fonts = {
            packages = with pkgs; [
                noto-fonts
                noto-fonts-cjk-sans
                noto-fonts-cjk-serif
                noto-fonts-color-emoji

                font-awesome

                corefonts
            ];

            fontconfig = {
                defaultFonts = {
                    emoji = ["Noto Color Emoji"];
                };
            };
        };
    };
}

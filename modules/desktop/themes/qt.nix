{ ... }:

{
    flake.homeModules.qt = { pkgs, ... }: 
    let
        yamis-icons = (pkgs.callPackage ./_icons.nix {});
    in
    {
        qt = {
            enable = true;
            style.name = "adwaita-dark";
        };

        home.sessionVariables = {
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "gnome";

            QT_STYLE_OVERRIDE = "adwaita-dark";
        };
    };
}
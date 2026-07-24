{ ... }:

{
    flake.nixosModules.qt = { ... }: {
        qt = {
            enable = true;
            style = "adwaita-dark";
        };

        environment.sessionVariables = {
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "gnome";
            QT_STYLE_OVERRIDE = "adwaita-dark";
        };
    };
}

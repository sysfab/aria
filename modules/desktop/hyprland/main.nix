{ ... }:

{
    flake.homeModules.hyprland = { pkgs, ... }: {
        wayland.windowManager.hyprland = {
            enable = true;
            settings = import ./_config/main.nix {};
            
            plugins = with pkgs.hyprlandPlugins; [
                hyprspace
            ];
        };
    };
}
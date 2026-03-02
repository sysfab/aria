{ ... }:

{
    flake.homeModules.hyprland-config = {
        wayland.windowManager.hyprland.settings = {
            # Define monitors, etc
            monitor = [
                "HDMI-A-1, 1920x1080@100hz, 0x0, 1"
                "DVI-D-1, 1920x1080@60hz, 1920x0, 1"
            ];

            workspace = [
                "1, monitor:HDMI-A-1"
            ];
        };
    };
}
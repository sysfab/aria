start_cmd(
    "dbus-update-activation-environment --systemd --all",

    -- daemons
    "awww-daemon",

    "foot -s",
    "pkill swaync; swaync",
    "pkill waybar; waybar",

    "aria-load-hyprland-plugins",
    "aria-update-wallpaper --instant"
)

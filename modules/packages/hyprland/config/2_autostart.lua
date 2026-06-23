start_cmd(
    "dbus-update-activation-environment --systemd --all",

    -- daemons
    "awww-daemon",

    "foot -s",
    "pkill swaync; swaync",
    "pkill waybar; waybar",

    "aria-update-wallpaper --instant"
)

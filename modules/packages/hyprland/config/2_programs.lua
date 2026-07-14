programs = {}

function add_program(pg)
    if pg.autostart == true then
        start_cmd(pg.start)
    end
    programs[pg.id] = pg
end

function add_programs(...)
    pgs = table.pack(...)
    for i, pg in ipairs(pgs) do
        add_program(pg)
    end
end

add_programs(
    {
        id = "dbus-env",
        start = "dbus-update-activation-environment --systemd --all",
        autostart = true,
    },
    {
        id = "awww",
        start = "awww-daemon",
        kill = "pkill awww-daemon",
        autostart = true,
        kill_on_game = true,
    },
    {
        id = "elephant",
        start = "elephant",
        autostart = true,
    },
    {
        id = "walker",
        start = "walker --gapplication-service",
        kill = "pkill walker",
        autostart = true,
        kill_on_game = true,
    },
    {
        id = "foot",
        start = "foot -s",
        autostart = true,
    },
    {
        id = "swaync",
        start = "pkill swaync; swaync",
        kill = "pkill swaync",
        autostart = true,
    },
    {
        id = "waybar",
        start = "waybar",
        kill = "pkill waybar",
        autostart = true,
        kill_on_game = true,
    },

    {
        id = "aria",
        start = "aria-hyprland-load-plugins; aria-update-wallpaper --instant",
        autostart = true,
    }
)

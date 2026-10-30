Env({
    GTK_USE_PORTAL = "1",
    QT_QPA_PLATFORM = "wayland",

    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_DESKTOP = "Hyprland",
    XDG_SESSION_TYPE = "wayland",

    XCURSOR_THEME = "Moga-Cursor",
    XCURSOR_SIZE = "24",
    HYPRCURSOR_THEME = "Moga-Cursor";
    HYPRCURSOR_SIZE = "24",

    HYPRSHOT_DIR = "Pictures/Screenshots/",
})

--
-- Programs
--
Programs:Register(
    {
        id = "aria",
        commands = {
            load_plugins = {
                "aria-hyprland-load-plugins",
                tags = { "autostart", "on_gamemode_exit" },
            },
            unload_plugins = {
                "aria-hyprland-unload-plugins",
                tags = { "on_gamemode_enter" }
            },
            picker = { "aria-picker" },
        },
    },
    {
        id = "aria-wallpapers",
        commands = {
            daemon = {
                "awww-daemon & sleep 0.001; aria-wallpaper-update --instant",
                tags = { "autostart", "on_gamemode_exit" },
            },
            kill = {
                "pkill awww-daemon",
                tags = { "on_gamemode_enter" }
            }
        },
    },

    {
        id = "anyrun",
        commands = {
            daemon = {
                "anyrun daemon",
                tags = { "autostart" },
            },
            start = {
                "anyrun"
            },
        },
    },

    {
        id = "swaync",
        commands = {
            daemon = {
                "pkill swaync; swaync",
                tags = { "autostart", "on_gamemode_exit" },
            },
            kill = {
                "pkill swaync",
                tags = { "on_gamemode_enter" }
            }
        },
    },
    {
        id = "waybar",
        commands = {
            start = {
                "waybar",
                tags = { "autostart", "on_gamemode_exit" },
            },
            kill = {
                "pkill waybar",
                tags = { "on_gamemode_enter" }
            }
        },
    },

    {
        id = "hyprshot",
        commands = {
            region = { "hyprshot -m region --freeze" },
            window = { "hyprshot -m window --freeze" },
            screen = { "hyprshot -m output --freeze" }
        }
    }
)

--
-- Looks
--
LayerRules({
    match = { namespace = "anyrun" },
    no_anim = true
})

TranslucentLayers(
    "anyrun",
    "swaync-control-center"
)

Translucent(
    "foot",
    "org.gnome.Nautilus",
    "org.gnome.Decibels"
)

--
-- Binds
--
Binds(
    { { SUPER, Q },        "foot" },
    { { SUPER, E },        "nautilus" },

    { { SUPER, R },        Programs("anyrun").Start },
    { { SUPER, SHIFT, R }, Programs("aria").Picker },

    { { SUPER, F },        Window.tag({ tag = "no_share" }) },
    { { SUPER, V },        Window.float({ action = "toggle" }) },

    { { SUPER, C },        Window.close() },
    { { SUPER, SHIFT, C }, Window.kill() },

    { { SUPER, SHIFT, G }, GameMode.Toggle },

    { { SUPER, A },        Layout("togglesplit") },
    { { SUPER, S },        Layout("rotatesplit") },
    { { SUPER, D },        Layout("swapsplit") },

    { { "",    PRINT },    Programs("hyprshot").Region },
    { { SHIFT, PRINT },    Programs("hyprshot").Window },
    { { CTRL,  PRINT },    Programs("hyprshot").Screen },

    { { SUPER, LEFT },     Window.move({ direction = LEFT }) },
    { { SUPER, RIGHT },    Window.move({ direction = RIGHT }) },

    { { SUPER, DOWN },     Window.fullscreen({ mode = "fullscreen", action = "toggle" }) },

    { { SUPER, LMB },      Window.drag(),    { mouse = true } },
    { { SUPER, RMB },      Window.resize(),  { mouse = true } }
)

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    Binds(
        {{SUPER, key},        Focus({ workspace = i })},
        {{SUPER, SHIFT, key}, Window.move({ workspace = i })}
    )
end

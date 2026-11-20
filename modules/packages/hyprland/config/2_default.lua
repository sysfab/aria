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

Autostart(
    "dbus-update-activation-environment --systemd --all",
    "aria-hyprland-load-plugins",
    "aria-wallpaper-update --instant",

    "waybar",
    "systemctl --user start swaync.service"
)

Programs:Register(
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
        id = "hyprshot",
        commands = {
            region = { "hyprshot -m region --freeze" },
            window = { "hyprshot -m window --freeze" },
            screen = { "hyprshot -m output --freeze" }
        }
    }
)

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
    "org.gnome.Nautilus"
)

Binds(
    { { SUPER, Q },          "foot" },
    { { SUPER, E },          "nautilus" },

    { { SUPER, R },          Programs("anyrun").Start },
    { { SUPER, SHIFT, R },   "aria-picker" },

    { { SUPER, F },          Window.tag({ tag = "no_share" }) },
    { { SUPER, V },          Window.float({ action = "toggle" }) },

    { { SUPER, C },          Window.close() },
    { { SUPER, SHIFT, C },   Window.kill() },

    { { SUPER, A },          Layout("togglesplit") },
    { { SUPER, S },          Layout("rotatesplit") },
    { { SUPER, D },          Layout("swapsplit") },

    { { "",    PRINT },      Programs("hyprshot").Region },
    { { SHIFT, PRINT },      Programs("hyprshot").Window },
    { { CTRL,  PRINT },      Programs("hyprshot").Screen },

    { { CTRL,  SHIFT, ESC }, "gnome-system-monitor" },

    { { SUPER, LEFT },       Window.move({ direction = LEFT }) },
    { { SUPER, RIGHT },      Window.move({ direction = RIGHT }) },

    { { SUPER, DOWN },       Window.fullscreen({ mode = "fullscreen", action = "toggle" }) },

    { { SUPER, LMB },        Window.drag(),    { mouse = true } },
    { { SUPER, RMB },        Window.resize(),  { mouse = true } }
)

for i = 1, 10 do
    local key = i % 10
    Binds(
        {{SUPER, key},        Focus({ workspace = i })},
        {{SUPER, SHIFT, key}, Window.move({ workspace = i })}
    )
end

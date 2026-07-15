Config({
    input = {
        kb_layout = "us, ua",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:none,grp:alt_shift_toggle",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = -0.5,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },

    ecosystem = {
        no_donation_nag = true,
    },
})

--
-- Dynamic cursors
-- https://github.com/VirtCode/hypr-dynamic-cursors
--
Plugin("dynamic_cursors", {
    enabled = true,

    mode = "tilt",
    tilt = {
        full = 15,
    },

    shake = {
        enabled = false,
    },
})

--
-- Default Envs
--
Env({
    GTK_USE_PORTAL = "1",

    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_DESKTOP = "Hyprland",
    XDG_SESSION_TYPE = "wayland",

    XCURSOR_THEME = "Moga-Cursor",
    XCURSOR_SIZE = "24",
    HYPRCURSOR_THEME = "Moga-Cursor";
    HYPRCURSOR_SIZE = "24",

    HYPRSHOT_DIR = "Pictures/Screenshots/",
})

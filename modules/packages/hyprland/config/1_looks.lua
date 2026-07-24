Config({
    general = {
        layout = "dwindle",

        gaps_in = 5,
        gaps_out = 10,
        border_size = 0,

        allow_tearing = false,
    },

    dwindle = {
        preserve_split = true,
    },

    decoration = {
        rounding = 10,
        rounding_power = 2.0,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = true,
            size = 1,
            passes = 4,
        },
    },
})

Curves({
    easeOutQuint = {type = "bezier", points = {{0.23,1}, {0.32,1}}},
    easeInOutCubic = {type = "bezier", points = {{0.65,0.05}, {0.36,1}}},
    linear = {type = "bezier", points = {{0,0}, {1,1}}},
    almostLinear = {type = "bezier", points = {{0.5,0.5}, {0.75,1.0}}},
    quick = {type = "bezier", points = {{0.15,0}, {0.1,1}}},
})

Animations(
    {leaf = "global", speed = 10, bezier = "default", enabled = true},
    {leaf = "windows", speed = 4.79, bezier = "easeOutQuint", enabled = true},
    {leaf = "windowsIn", speed = 4.1, bezier = "easeOutQuint", style = "popin 85%", enabled = true},
    {leaf = "windowsOut",speed = 1.49, bezier = "linear", style = "popin 85%", enabled = true},
    {leaf = "layers", speed = 3.81, bezier = "easeOutQuint", enabled = true},
    {leaf = "layersIn", speed = 4, bezier = "easeOutQuint", style = "fade", enabled = true},
    {leaf = "layersOut", speed = 1.5, bezier = "linear", style = "fade", enabled = true},
    {leaf = "fade", speed = 3.03, bezier = "quick", enabled = true},
    {leaf = "fadeIn", speed = 1.73, bezier = "almostLinear", enabled = true},
    {leaf = "fadeOut", speed = 1.46, bezier = "almostLinear", enabled = true},
    {leaf = "fadeLayersIn", speed = 1.79, bezier = "almostLinear", enabled = true},
    {leaf = "fadeLayersOut", speed = 1.39, bezier = "almostLinear", enabled = true},
    {leaf = "border", speed = 5.39, bezier = "easeOutQuint", enabled = true},
    {leaf = "workspaces", speed = 1.94, bezier = "almostLinear", style = "fade", enabled = true},
    {leaf = "workspacesIn", speed = 1.21, bezier = "almostLinear", style = "fade", enabled = true},
    {leaf = "workspacesOut", speed = 1.94, bezier = "almostLinear", style = "fade", enabled = true}
)

WindowRules(
    {
        match = { tag = "no_share" },
        no_screen_share = true,
        border_size = 2,
        border_color = "rgba(ff0000bf) rgba(ff0000bf)",
    }
)

WorkspaceRules(
    {
        workspace = "w[tv1]",
        gaps_in = 0,
        gaps_out = 0,
        no_border = true,
        no_rounding = true,
    }
)

LayerRules(
    {
        match = { namespace = "walker" },
        blur = true,
        ignore_alpha = 0.1
    },
    {
        match = { namespace = "swaync-control-center" },
        blur = true,
        ignore_alpha = 0.1
    }
)

Opaque = function(...)
    for i, class in ipairs({...}) do
        WindowRules({
            match = { class = class },
            opacity = 0.865,
        })
    end
end

Opaque(
    "foot",
    "org.gnome.Nautilus",
    "org.gnome.Decibels"
)

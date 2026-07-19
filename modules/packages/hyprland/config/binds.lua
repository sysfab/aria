SUPER = "SUPER"
SHIFT = "SHIFT"
CTRL = "CTRL"

LMB = "mouse:272"
RMB = "mouse:273"

Binds(
    { { SUPER, "Q" },         Programs("foot").Client },
    { { SUPER, SHIFT, "Q" },  Programs("foot").Standalone },

    { { SUPER, "E" },         Programs("nautilus").Start },

    { { SUPER, "R" },         Programs("walker").Start },
    { { SUPER, SHIFT, "R" },  Programs("aria").Picker },

    { { SUPER, "F" },         window.tag({ tag = "no_share" }) },
    { { SUPER, "V" },         window.float({ action = "toggle" }) },

    { { SUPER, "C" },         window.close() },
    { { SUPER, SHIFT, "C" },  window.kill() },

    { { SUPER, SHIFT, "G" },  GameMode.Toggle },

    { { SUPER, "A" },         layout("togglesplit") },
    { { SUPER, "S" },         layout("rotatesplit") },
    { { SUPER, "D" },         layout("swapsplit") },

    { { "",    "PRINT" },     Programs("hyprshot").Region },
    { { SHIFT, "PRINT" },     Programs("hyprshot").Window },
    { { CTRL,  "PRINT" },     Programs("hyprshot").Screen },

    { { SUPER, "left" },      window.move({ direction = "left" }) },
    { { SUPER, "right" },     window.move({ direction = "right" }) },

    { { SUPER, "down" },      window.fullscreen({ mode = "fullscreen", action = "toggle" }) },

    { { SUPER, LMB },         window.drag(),    { mouse = true } },
    { { SUPER, RMB },         window.resize(),  { mouse = true } }
)

-- Workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    Binds(
        {{SUPER,        key}, focus({ workspace = i })},
        {{SUPER, SHIFT, key}, window.move({ workspace = i })}
    )
end

SUPER = "SUPER"
SHIFT = "SHIFT"
CTRL = "CTRL"

LMB = "mouse:272"
RMB = "mouse:273"

Binds(
    { { SUPER, "Q" },         cmd("footclient") },
    { { SUPER, SHIFT, "Q" },  cmd("foot") },

    { { SUPER, "E" },         cmd("nautilus") },

    { { SUPER, "R" },         cmd("walker") },
    { { SUPER, SHIFT, "R" },  cmd("aria-picker") },

    { { SUPER, "F" },         window.tag({ tag = "no_share" }) },
    { { SUPER, "V" },         window.float({ action = "toggle" }) },

    { { SUPER, "C" },         window.close() },
    { { SUPER, SHIFT, "C" },  window.kill() },

    { { SUPER, SHIFT, "G" },  GameMode.Toggle },

    { { SUPER, "A" },         layout("togglesplit") },
    { { SUPER, "S" },         layout("rotatesplit") },
    { { SUPER, "D" },         layout("swapsplit") },

    { { "",    "PRINT" },     cmd("hyprshot -m region --freeze") },
    { { SHIFT, "PRINT" },     cmd("hyprshot -m window --freeze") },
    { { CTRL,  "PRINT" },     cmd("hyprshot -m output --freeze") },

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

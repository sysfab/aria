config({
    input = {
        kb_layout = "us, ua",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:none,grp:alt_shift_toggle",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = -0.5,
    }
})


local MAIN_MOD = "SUPER"

bind({MAIN_MOD, "G"}, function()
    local game_mode = (get_config("animations.enabled") == false)

    if game_mode then
        for id, pg in pairs(programs) do
            if pg.kill_on_game == true then
                exec_cmd(pg.start)
            end
        end
        exec_cmd("hyprctl reload")
        return
    end

    for id, pg in pairs(programs) do
        if pg.kill_on_game == true then
            exec_cmd(pg.kill)
        end
    end

    for i, rule in ipairs(rules_layer) do rule:set_enabled(false) end
    plugin("dynamic_cursors", { enabled = false })
    config({
        general = {
            gaps_in = 0,
            gaps_out = 0,
            border_size = 0,
        },

        animations = {
            enabled = false,
        },

        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            glow = { enabled = false },
            rounding = 0,
        },

        render = {
            xp_mode = true,
        },

        misc = {
            disable_autoreload = true,
        },
    })
end)

bind({MAIN_MOD, "Q"}, cmd("footclient"))
bind({MAIN_MOD, "SHIFT", "Q"}, cmd("foot"))

bind({MAIN_MOD, "E"}, cmd("nautilus"))

bind({MAIN_MOD, "R"},          cmd("walker"))
bind({MAIN_MOD, "SHIFT", "R"}, cmd("aria-picker"))

bind({MAIN_MOD, "F"}, window.tag({ tag = "no_share" })) -- toggles
bind({MAIN_MOD, "V"}, window.float({ action = "toggle" }))

bind({MAIN_MOD, "C"},          window.close())
bind({MAIN_MOD, "SHIFT", "C"}, window.kill())

bind({MAIN_MOD, "A"}, layout("togglesplit"))
bind({MAIN_MOD, "S"}, layout("rotatesplit"))
bind({MAIN_MOD, "D"}, layout("swapsplit"))

bind({"", "PRINT"},       cmd("hyprshot -m region --freeze"))
bind({"SHIFT", "PRINT"},  cmd("hyprshot -m output --freeze"))
bind({MAIN_MOD, "PRINT"}, cmd("hyprshot -m window --freeze"))

bind({MAIN_MOD, "left"},  window.move({ direction = "left" }))
bind({MAIN_MOD, "right"}, window.move({ direction = "right" }))

bind({MAIN_MOD, "down"}, window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Move/resize windows
bind({MAIN_MOD, "mouse:272"}, window.drag(),   { mouse = true })
bind({ MAIN_MOD, "mouse:273" }, window.resize(), { mouse = true })

-- Workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    bind({MAIN_MOD, key},          focus({ workspace = i }))
    bind({MAIN_MOD, "SHIFT", key}, window.move({ workspace = i }))
end

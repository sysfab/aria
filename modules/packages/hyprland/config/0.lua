--
-- Aria hyprland helpers
--

config = hl.config

cmd = hl.dsp.exec_cmd
window = hl.dsp.window
layout = hl.dsp.layout
focus = hl.dsp.focus
workspace = hl.dsp.workspace

env = function(e)
    for key, value in pairs(e) do
        hl.env(key, value)
    end
end

start_cmd = function(...)
    AUTOSTART = table.pack(...)

    hl.on("hyprland.start", function()
        for i, command in ipairs(AUTOSTART) do
            hl.exec_cmd(command)
        end
    end)
end

bind = function(keybind, action, settings)
    hl.bind(table.concat(keybind, " + "), action, settings)
end

curves = function(_curves)
    for name, curve in pairs(_curves) do
        hl.curve(name, curve)
    end
end

animations = function(...)
    local anims = table.pack(...)

    for i, anim in ipairs(anims) do
        hl.animation(anim)
    end
end

window_rules = function(...)
    local rules = table.pack(...)

    for i, rule in ipairs(rules) do
        hl.window_rule(rule)
    end
end

layer_rules = function(...)
    local rules = table.pack(...)

    for i, rule in ipairs(rules) do
        hl.layer_rule(rule)
    end
end
--
-- Aria hyprland helpers
--

config = hl.config
get_config = hl.get_config

plugin = function(cfg)
    config({ plugin = cfg })
end

exec_cmd = hl.exec_cmd
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

AUTOSTART = {}
start_cmd = function(...)
    NEW_AUTOSTART = table.pack(...)

    for i, command in ipairs(NEW_AUTOSTART) do
        table.insert(AUTOSTART, command)
    end
end

hl.on("hyprland.start", function()
    for i, command in ipairs(AUTOSTART) do
        hl.exec_cmd(command)
    end
end)

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

rules_window = {}
window_rules = function(...)
    local rules = table.pack(...)

    for i, rule in ipairs(rules) do
        table.insert(rules_window, hl.window_rule(rule))
    end
end

workspace_rules = function( ... )
    local rules = table.pack(...)

    for i, rule in ipairs(rules) do
        hl.workspace_rule(rule)
    end
end

rules_layer = {}
layer_rules = function(...)
    local rules = table.pack(...)

    for i, rule in ipairs(rules) do
        table.insert(rules_layer, hl.layer_rule(rule))
    end
end

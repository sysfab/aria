--
-- Aria hyprland helpers
--

config = hl.config
get_config = hl.get_config

plugin = function(id, cfg)
    config({ plugin = { [id] = cfg } })
end

env = function(e)
    for key, value in pairs(e) do
        hl.env(key, value)
    end
end


exec_cmd = hl.exec_cmd
cmd = hl.dsp.exec_cmd

window = hl.dsp.window
layout = hl.dsp.layout
focus = hl.dsp.focus
workspace = hl.dsp.workspace


AUTOSTART = {}
autostart = function(...)
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


MONITORS = {}
DEFAULT_MONITOR = nil
monitors = function(mons)
    for monitor, settings in pairs(mons) do
        local hl_mon = hl.monitor({
            output = monitor,
            mode = settings.mode,
            position = settings.position,
            scale = settings.scale,
        })

        MONITORS[monitor] = hl_mon
        if settings.default == true then
            DEFAULT_MONITOR = hl_mon
            config({
                cursor = {
                    default_monitor = monitor
                }
            })
        end
    end
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


WINDOW_RULES = {}
window_rules = function(...)
    local rules = table.pack(...)

    for i, rule in ipairs(rules) do
        table.insert(WINDOW_RULES, hl.window_rule(rule))
    end
end

workspace_rules = function( ... )
    local rules = table.pack(...)

    for i, rule in ipairs(rules) do
        hl.workspace_rule(rule)
    end
end

LAYER_RULES = {}
layer_rules = function(...)
    local rules = table.pack(...)

    for i, rule in ipairs(rules) do
        table.insert(LAYER_RULES, hl.layer_rule(rule))
    end
end

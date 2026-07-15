--
-- Aria Hyprland API
--
Config = hl.config
GetConfig = hl.get_config

Plugin = function(id, cfg)
    Config({ plugin = { [id] = cfg } })
end

Env = function(env)
    for key, value in pairs(env) do
        hl.env(key, value)
    end
end


exec_cmd = hl.exec_cmd

-- dispatchers
cmd = hl.dsp.exec_cmd
window = hl.dsp.window
layout = hl.dsp.layout
focus = hl.dsp.focus
workspace = hl.dsp.workspace


MONITORS = {}
DEFAULT_MONITOR = nil
Monitors = function(monitors)
    for monitor, settings in pairs(monitors) do
        local hl_mon = hl.monitor({
            output = monitor,
            mode = settings.mode,
            position = settings.position,
            scale = settings.scale,
        })

        MONITORS[monitor] = hl_mon
        if settings.default == true then
            DEFAULT_MONITOR = hl_mon
            Config({
                cursor = {
                    default_monitor = monitor
                }
            })
        end
    end
end


Bind = function(keybind, action, settings)
    hl.bind(table.concat(keybind, " + "), action, settings)
end

Binds = function(...)
    for i, bind in ipairs({...}) do
        Bind(table.unpack(bind))
    end
end


Curves = function(curves)
    for name, curve in pairs(curves) do
        hl.curve(name, curve)
    end
end

Animations = function(...)
    for i, anim in ipairs({...}) do
        hl.animation(anim)
    end
end


WINDOW_RULES = {}
WindowRules = function(...)
    for i, rule in ipairs({...}) do
        table.insert(WINDOW_RULES, hl.window_rule(rule))
    end
end

WorkspaceRules = function(...)
    for i, rule in ipairs({...}) do
        hl.workspace_rule(rule)
    end
end

LAYER_RULES = {}
LayerRules = function(...)
    for i, rule in ipairs({...}) do
        table.insert(LAYER_RULES, hl.layer_rule(rule))
    end
end


-- Helpers
function ToPascalCase(str)
    return (str:gsub("(%a)([%w_]*)", function(first, rest)
        return first:upper() .. rest:lower()
    end):gsub("%-", ""))
end

GameMode = {
    IsEnabled = function()
        return (GetConfig("misc.disable_autoreload") == true)
    end,

    Enable = function()
        Programs:ForEach(function(program)
            program:ForTaggedCommand("on_gamemode_enter", function(_, command)
                exec_cmd(command[1])
            end)
        end)

        for i, rule in ipairs(LAYER_RULES) do
            rule:set_enabled(false)
        end

        Plugin("dynamic_cursors", { enabled = false })
        Config({
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
    end,

    Disable = function()
        Programs:ForEach(function(program)
            program:ForTaggedCommand("on_gamemode_exit", function(_, command)
                exec_cmd(command[1])
            end)
        end)
        exec_cmd("hyprctl reload")
    end,

    Toggle = function()
        if GameMode.IsEnabled() then
            GameMode.Disable()
        else
            GameMode.Enable()
        end
    end,
}

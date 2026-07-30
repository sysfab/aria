Program = {
    __index = {
        ForCommand = function(self, func)
            for name, command in pairs(self.commands) do
                func(name, command)
            end
        end,

        ForTaggedCommand = function(self, tag, func)
            self:ForCommand(function(name, command)
                if type(command.tags) == "table" then
                    for _, ctag in ipairs(command.tags) do
                        if ctag == tag then
                            func(name, command)
                        end
                    end
                end
            end)
        end,

        Set = function(self, commands)
            for name, command in pairs(commands) do
                self[name] = command
                self[ToPascalCase(name)] = function() exec_cmd(command[1]) end
            end
        end
    }
}

Programs = setmetatable({
    Registered = {},
    Get = function(self, id) return self.Registered[id] end,
    ForEach = function(self, func)
        for _, program in pairs(self.Registered) do
            func(program)
        end
    end,

    Register = function(self, ...)
        for _, program in ipairs({ ... }) do
            program = setmetatable(program, Program)

            program:ForCommand(function(name, command)
                program:Set({[name] = command})
            end)

            self.Registered[program.id] = program
        end
    end
}, {
    __call = function(self, id)
        return self:Get(id)
    end
})

-- Default programs
Programs:Register(
    {
        id = "dbus-env",
        commands = {
            _ = {
                "dbus-update-activation-environment --systemd --all",
                tags = { "autostart" },
            }
        },
    },

    {
        id = "aria",
        commands = {
            load_plugins = {
                "aria-hyprland-load-plugins",
                tags = { "autostart", "on_gamemode_exit" },
            },
            unload_plugins = {
                "aria-hyprland-unload-plugins",
                tags = { "on_gamemode_enter" }
            },
            picker = { "aria-picker" },
        },
    },
    {
        id = "aria-wallpapers",
        commands = {
            daemon = {
                "awww-daemon & sleep 0.001; aria-update-wallpaper --instant",
                tags = { "autostart", "on_gamemode_exit" },
            },
            kill = {
                "pkill awww-daemon",
                tags = { "on_gamemode_enter" }
            }
        },
    },

    {
        id = "anyrun",
        commands = {
            daemon = {
                "anyrun daemon",
                tags = { "autostart" },
            },
            start = {
                "anyrun"
            },
        },
    },

    {
        id = "foot",
        commands = {
            start = {
                "foot"
            }
        },
    },

    {
        id = "swaync",
        commands = {
            daemon = {
                "pkill swaync; swaync",
                tags = { "autostart", "on_gamemode_exit" },
            },
            kill = {
                "pkill swaync",
                tags = { "on_gamemode_enter" }
            }
        },
    },
    {
        id = "waybar",
        commands = {
            start = {
                "waybar",
                tags = { "autostart", "on_gamemode_exit" },
            },
            kill = {
                "pkill waybar",
                tags = { "on_gamemode_enter" }
            }
        },
    },

    {
        id = "hyprshot",
        commands = {
            region = { "hyprshot -m region --freeze" },
            window = { "hyprshot -m window --freeze" },
            screen = { "hyprshot -m output --freeze" }
        }
    },

    {
        id = "nautilus",
        commands = {
            start = { "nautilus" },
            kill = { "pkill nautilus" }
        }
    }
)

--
-- Autostart API
--
AUTOSTART = {}
Autostart = function(...)
    for i, command in ipairs({...}) do
        table.insert(AUTOSTART, command)
    end
end

hl.on("hyprland.start", function()
    for i, command in ipairs(AUTOSTART) do
        hl.exec_cmd(command)
    end

    Programs:ForEach(function(program)
        program:ForTaggedCommand("autostart", function(_, command)
            hl.exec_cmd(command[1])
        end)
    end)
end)

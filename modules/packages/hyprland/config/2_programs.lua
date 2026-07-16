--
-- Programs API
--
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
            program.ForCommand = function(_, func)
                for name, command in pairs(_.commands) do
                    func(name, command)
                end
            end

            program.ForTaggedCommand = function(_, tag, func)
                _:ForCommand(function(name, command)
                    if type(command.tags) == "table" then
                        for _, ctag in ipairs(command.tags) do
                            if ctag == tag then
                                func(name, command)
                            end
                        end
                    end
                end)
            end

            program:ForCommand(function(name, command)
                program[ToPascalCase(name)] = function() exec_cmd(command[1]) end
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
        id = "aria-plugins",
        commands = {
            _ = {
                "aria-hyprland-load-plugins",
                tags = { "autostart" },
            }
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
        id = "elephant",
        commands = {
            daemon = {
                "elephant",
                tags = { "autostart", "on_gamemode_exit" },
            },
            kill = {
                "pkill elephant",
                tags = { "on_gamemode_enter" }
            }
        },
    },
    {
        id = "walker",
        commands = {
            daemon = {
                "walker --gapplication-service",
                tags = { "autostart", "on_gamemode_exit" },
            },
            start = {
                "walker"
            },
            kill = {
                "pkill walker",
                tags = { "on_gamemode_enter" }
            }
        },
    },

    {
        id = "foot",
        commands = {
            daemon = {
                "foot -s",
                tags = { "autostart", "on_gamemode_exit" },
            },
            client = {
                "footclient"
            },
            standalone = {
                "foot"
            },
            kill = {
                "pkill foot",
                tags = { "on_gamemode_enter" }
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

lib = {
    map = function(t, f)
        for k,v in pairs(t) do f(k,v) end
    end,
    mapi = function(t, f)
        for i,v in ipairs(t) do f(i,v) end
    end,

    join = function(strings, sep)
        sep = sep or " "
        local result = {}

        for i, el in ipairs(strings) do
            result[i] = tostring(el)
        end

        return table.concat(result, sep)
    end,

    toPascalCase = function(str)
        return (str:gsub("(%a)([%w_]*)", function(first, rest)
            return first:upper() .. rest:lower()
        end):gsub("%-", ""))
    end
}

Config = hl.config
Get = hl.get_config

Config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },

    ecosystem = {
        no_donation_nag = true,
    },
})

dsp = hl.dsp
Window = dsp.window
Layout = dsp.layout
Focus = dsp.focus

Plugin = function(id, cfg)
    Config({ plugin = { [id] = cfg } })
end

Env = function(env)
    lib.map(env, hl.env)
end


Bind = function(keybind, action_or_cmd, settings)
    local action = action_or_cmd
    if type(action_or_cmd) == "string" then
        action = dsp.exec_cmd(action_or_cmd)
    end

    hl.bind(lib.join(keybind, " + "), action, settings)
end

Binds = function(...)
    for _,bind in ipairs({...}) do
        Bind(table.unpack(bind))
    end
end

Program = {
    __index = {
        ForCommand = function(self, f)
            lib.map(self.commands, f)
            return self
        end,

        ForTaggedCommand = function(self, tag, f)
            self:ForCommand(function(name, command)
                if type(command.tags) == "table" then
                    for _,ctag in ipairs(command.tags) do
                        if ctag == tag then
                            f(name, command)
                        end
                    end
                end
            end)
            return self
        end,

        Set = function(self, commands)
            for name, command in pairs(commands) do
                self[name] = command
                self[lib.toPascalCase(name)] = command[1] or ""
            end
            return self
        end
    }
}

Programs = setmetatable({
    Registered = {},
    Register = function(self, ...)
        for _,program in ipairs({ ... }) do
            self.Registered[program.id] = setmetatable(program, Program):ForCommand(function(name, command)
                program:Set({[name] = command})
            end)
        end
    end,

    Get = function(self, id) return self.Registered[id] end,

    ForEach = function(self, f)
        lib.map(self.Registered, function(_,p) f(p) end)
    end
}, {
    __call = function(self, id)
        return self:Get(id)
    end
})

AUTOSTART = {
    "dbus-update-activation-environment --systemd --all"
}
Autostart = function(...)
    for _,command in ipairs({...}) do
        table.insert(AUTOSTART, command)
    end
end

hl.on("hyprland.start", function()
    for _,command in ipairs(AUTOSTART) do
        hl.exec_cmd(command)
    end

    Programs:ForEach(function(program)
        program:ForTaggedCommand("autostart", function(_, command)
            hl.exec_cmd(command[1])
        end)
    end)
end)


function Input(input)
    Config({
        input = {
            kb_layout = lib.join(input.layouts or { "us" }, ", "),
            sensitivity = input.sensivity or 1,

            kb_variant = "",
            kb_model = "",
            kb_options = "caps:none,grp:alt_shift_toggle",
            kb_rules = "",

            follow_mouse = 1,
        }
    })
end
Input({})


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
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})


Curves = function(curves)
    for name, curve in pairs(curves) do
        hl.curve(name, curve)
    end
end

Animations = function(...)
    for _,anim in ipairs({...}) do
        hl.animation(anim)
    end
end

WINDOW_RULES = {}
WindowRules = function(...)
    for _,rule in ipairs({...}) do
        table.insert(WINDOW_RULES, hl.window_rule(rule))
    end
end

WorkspaceRules = function(...)
    for _,rule in ipairs({...}) do
        hl.workspace_rule(rule)
    end
end

LAYER_RULES = {}
LayerRules = function(...)
    for _, rule in ipairs({ ... }) do
        table.insert(LAYER_RULES, hl.layer_rule(rule))
    end
end

TranslucentLayers = function(...)
    for i, namespace in ipairs({...}) do
        LayerRules({
            match = { namespace = namespace },
            blur = true,
            ignore_alpha = 0.1
        })
    end
end

Translucent = function(...)
    for _,class in ipairs({ ... }) do
        WindowRules({
            match = { class = class },
            opacity = 0.865,
        })
    end
end

-- Constants
for i = string.byte("A"), string.byte("Z") do
    local key = string.char(i)
    _G[key] = key
end

for _, key in ipairs({
    "SUPER", "CTRL", "ALT", "SHIFT",
    "MOD1", "MOD2", "MOD3", "MOD4", "MOD5",
}) do
    _G[key] = key
end

for _, key in ipairs({
    "SUPER",
    "CTRL",
    "ALT",
    "SHIFT",
    "META",
    "HYPER",
}) do
    for _, side in ipairs({ "L", "R" }) do
        local sym = key .. "_" .. side
        _G[key .. "_" .. side] = sym
        _G[key] = key
    end
end

for key in ([[
    up down left right
    Home End Begin
    Page_Up Page_Down Prior Next
    Insert Delete BackSpace
    Return Tab ISO_Left_Tab
    Escape Print Pause
    Break Sys_Req
    Scroll_Lock Caps_Lock Num_Lock Shift_Lock
    Menu Help Select Execute Find
    Undo Redo Cancel Clear Linefeed
    Multi_key Mode_switch
    ISO_Level3_Shift ISO_Level5_Shift
    grave asciitilde
    exclam at numbersign dollar percent
    asciicircum ampersand asterisk
    parenleft parenright
    minus underscore equal plus
    bracketleft bracketright
    braceleft braceright
    backslash bar
    semicolon colon
    apostrophe quotedbl
    comma less period greater
    slash question
    space
    KP_Space KP_Tab KP_Enter
    KP_F1 KP_F2 KP_F3 KP_F4
    KP_Home KP_Left KP_Up KP_Right KP_Down
    KP_Prior KP_Next KP_Page_Up KP_Page_Down
    KP_End KP_Begin KP_Insert KP_Delete
    KP_Equal KP_Multiply KP_Add
    KP_Separator KP_Subtract
    KP_Decimal KP_Divide
    XF86AudioMute
    XF86AudioMicMute
    XF86AudioRaiseVolume
    XF86AudioLowerVolume
    XF86AudioPlay
    XF86AudioPause
    XF86AudioStop
    XF86AudioPrev
    XF86AudioNext
    XF86AudioRecord
    XF86AudioRewind
    XF86AudioForward
    XF86AudioRepeat
    XF86AudioRandomPlay
    XF86AudioCycleTrack
    XF86AudioMedia
    XF86MonBrightnessUp
    XF86MonBrightnessDown
    XF86MonBrightnessCycle
    XF86MonBrightnessAuto
    XF86KbdBrightnessUp
    XF86KbdBrightnessDown
    XF86KbdLightOnOff
    XF86PowerOff
    XF86PowerDown
    XF86Sleep
    XF86Suspend
    XF86Hibernate
    XF86WakeUp
    XF86Standby
    XF86Eject
    XF86Battery
    XF86Display
    XF86DisplayOff
    XF86WLAN
    XF86WWAN
    XF86Bluetooth
    XF86RFKill
    XF86TouchpadToggle
    XF86TouchpadOn
    XF86TouchpadOff
    XF86RotationLockToggle
    XF86FullScreen
    XF86HomePage
    XF86Mail
    XF86Search
    XF86Back
    XF86Forward
    XF86Stop
    XF86Refresh
    XF86Favorites
    XF86WWW
    XF86Calculator
    XF86Calendar
    XF86Explorer
    XF86Terminal
    XF86Tools
    XF86ScreenSaver
    XF86Launch0
    XF86Launch1
    XF86Launch2
    XF86Launch3
    XF86Launch4
    XF86Launch5
    XF86Launch6
    XF86Launch7
    XF86Launch8
    XF86Launch9
]]):gmatch("%S+") do
    _G[key:upper()] = key
end

local aliases = {
    ESC          = "Escape",
    ENTER        = "Return",
    SPACE        = "space",
    BACKSPACE    = "BackSpace",
    DEL          = "Delete",
    INS          = "Insert",
    PGUP         = "Page_Up",
    PGDOWN       = "Page_Down",
    PAGEUP       = "Page_Up",
    PAGEDOWN     = "Page_Down",
    PRINTSCREEN  = "Print",
    CAPSLOCK     = "Caps_Lock",
    NUMLOCK      = "Num_Lock",
    SCROLLLOCK   = "Scroll_Lock",
    ALTGR        = "ISO_Level3_Shift",
    BACKTICK     = "grave",
    TILDE        = "asciitilde",
    DASH         = "minus",
    HYPHEN       = "minus",
    EQUALS       = "equal",
    QUOTE        = "apostrophe",
    DOUBLE_QUOTE = "quotedbl",
    LBRACKET     = "bracketleft",
    RBRACKET     = "bracketright",
    LBRACE       = "braceleft",
    RBRACE       = "braceright",
    PIPE         = "bar",
    DOT          = "period",
}

for alias, name in pairs(aliases) do
    _G[alias] = name
end

for i = 0, 9 do
    local name = "KP_" .. i

    _G[name] = name
    _G["KP" .. i] = name
    _G["NUMPAD" .. i] = name
end

for i = 1, 35 do
    _G["F"..i] = "F"..i
end

for i = 1, 8 do
    _G["MOUSE" .. i] = "mouse:" .. (271 + i)
end
LMB = MOUSE1
RMB = MOUSE2
MMB = MOUSE3
MOUSE_UP    = "mouse_up"
MOUSE_DOWN  = "mouse_down"
MOUSE_LEFT  = "mouse_left"
MOUSE_RIGHT = "mouse_right"

CATCHALL = "catchall"

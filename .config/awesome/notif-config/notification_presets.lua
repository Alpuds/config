-- Theme handling library
local beautiful = require('beautiful')
-- Notification library
local naughty = require('naughty')
naughty.config.presets = {
    low = {
        bg = '#2b2b2b',
        fg = '#ffffff',
        icon = '/home/alpuds/.config/awesome/notif-config/normal-notif.png',
        icon_size = 32,
    },

    normal = {
        bg = '#2b2b2b',
        fg = '#ffffff',
        icon = '/home/alpuds/.config/awesome/notif-config/normal-notif.png',
        icon_size = 32,
    },

    critical = {
        bg = "#900000",
        fg = "#ffffff",
        border_color = '#ff0000',
        icon = '/home/alpuds/.config/awesome/notif-config/critical-notif.png',
        icon_size = 32,
        timeout = 8,
    },
}

--[[
From dunstrc

[urgency_low]
    # IMPORTANT: colors have to be defined in quotation marks.
    # Otherwise the "#" and following would be interpreted as a comment.
    background = "#2b2b2b"
    foreground = "#ffffff"
    timeout = 5
    # Icon for notifications with low urgency, uncomment to enable
    icon = ~/.config/dunst/normal-notif.png

[urgency_normal]
    background = "#2b2b2b"
    foreground = "#ffffff"
    timeout = 5
    # Icon for notifications with normal urgency, uncomment to enable
    icon = ~/.config/dunst/normal-notif.png

[urgency_critical]
    background = "#900000"
    foreground = "#ffffff"
    frame_color = "#ff0000"
    timeout = 5
    # Icon for notifications with critical urgency, uncomment to enable
    icon = ~/.config/dunst/critical-notif.png
--]]

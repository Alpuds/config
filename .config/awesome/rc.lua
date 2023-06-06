-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- Work with awesome-client
require("awful.remote")
focus_method = 'by_id'

-- Notification presets
require("notif-config.notification_presets")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Use correct status icon size
awesome.set_preferred_icon_size(32)
-- Disable icons in tasklist widget
-- beautiful.tasklist_disable_icon = true

-- Enable gaps
beautiful.useless_gap = 3
beautiful.gap_single_client = true

-- Fix window snapping
awful.mouse.snap.edge_enabled = false

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL")
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
home = os.getenv('HOME')

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.spiral,
    awful.layout.suit.floating,
}
-- }}}

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        buttons = tasklist_buttons
    }

    -- Create a textclock widget
    mytextclock = wibox.widget.textclock(' %F (%a) 󰥔 %r', 1)
    -- Create calendar widget
    local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
    local cw = calendar_widget({
        theme = 'dark',
        placement = 'top_right',
        start_sunday = true,
        radius = 8,
    -- customized next/previous
        previous_month_button = 4, -- scroll wheel up
        next_month_button = 5,     -- scroll wheel down
    })
    mytextclock:connect_signal("button::press",
        function(_, _, _, button)
            if button == 1 then cw.toggle() end
        end)

    -- mpd widget
    local mpdarc_widget = require("awesome-wm-widgets.mpdarc-widget.mpdarc")
    -- volume widget with pactl
    local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
    -- net speed widget
    local net_speed_widget = require("awesome-wm-widgets.net-speed-widget.net-speed")
    -- battary widget
    sb_battery = awful.widget.watch('sb-battery', 17)
    sb_internet = awful.widget.watch('sb-internet', 3)
    sb_forecast = awful.widget.watch('sb-forecast', 86400) -- 24 hours in seconds

    sb_internet:connect_signal("button::press",
        function(_, _, _, button)
            if button == 1 then awful.spawn(terminal .. ' -e nmtui') end
        end)

    sb_forecast:connect_signal("button::press",
        function(_, _, _, button)
            if button == 1 then
                awful.spawn.easy_async_with_shell('sb-forecast', function(out)
                    sb_forecast.text = out
                end)
                awful.spawn(terminal .. ' -e less -Sf ' .. home .. '/.cache/weatherreport')
            end
        end)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 30 })

    -- Create systray
    s.systray = wibox.widget.systray()

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 5,
            mpdarc_widget,
            s.systray,
            sb_battery,
            sb_forecast,
            net_speed_widget(),
            volume_widget{
                        mixer_cmd = terminal .. ' -e pulsemixer',
                    },
            mytextclock,
            sb_internet,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    -- Focus on tags
    awful.key({ modkey         }, "semicolon",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey, "Shift"   }, "semicolon",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Tab", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Toggle statusbar
    awful.key({ modkey, "Shift" }, "b", function ()
        mouse.screen.mywibox.visible = not mouse.screen.mywibox.visible
    end),

    -- Master and column manipulation
    awful.key({ modkey    }, "o",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "o",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey,  }, "s",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Shift" }, "s",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    -- Swap layout
    awful.key({ modkey, "Control" }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function ()
                for _, c in ipairs(client.get()) do
                    c.floating = false
                end
            end,
              {description = "Make all windows be tiled", group = "layout"}),

    -- Focus screen
    awful.key({ modkey, "Control" }, "Tab", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Shift" }, "Tab", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    -- Standard program
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "Escape", awesome.quit,
              {description = "quit awesome", group = "awesome"})
    --[[
    awful.key({ modkey, "Alt" }, "p",
              function ()
                  pass()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
    --]]
)

clientkeys = gears.table.join(
    -- Handling window states
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,    }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift" }, "f",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),

    -- Layout control
    awful.key({ modkey,    }, "space", function (c)
        if (client.focus == awful.client.getmaster()) then
            awful.client.swap.byidx(1)
            client.focus = awful.client.getmaster()
        else
            c:swap(awful.client.getmaster())
        end
    end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey, "Control" }, "s",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),

    -- Resize windows (tile layout, for by id)
    awful.key({ modkey, "Control" }, "e", function (c)
      if c.floating then
        c:relative_move( 0, 0, 0, -10)
      else
        awful.client.incwfact(0.025)
      end
    end,
    {description = "Floating Resize Vertical -", group = "client"}),
    awful.key({ modkey, "Control" }, "n", function (c)
      if c.floating then
        c:relative_move( 0, 0, 0,  10)
      else
        awful.client.incwfact(-0.025)
      end
    end,
    {description = "Floating Resize Vertical +", group = "client"}),
    awful.key({ modkey, }, "h", function (c)
      if c.floating then
        c:relative_move( 0, 0, -10, 0)
      else
        awful.tag.incmwfact(-0.025)
      end
    end,
    {description = "Floating Resize Horizontal -", group = "client"}),
    awful.key({ modkey, }, "l", function (c)
      if c.floating then
        c:relative_move( 0, 0,  10, 0)
      else
        awful.tag.incmwfact(0.025)
      end
    end,
    {description = "Floating Resize Horizontal +", group = "client"}),

    -- Moving floating windows
    awful.key({ modkey, "Shift"   }, "Down", function (c)
      c:relative_move(  0,  10,   0,   0) end,
    {description = "Floating Move Down", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Up", function (c)
      c:relative_move(  0, -10,   0,   0) end,
    {description = "Floating Move Up", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Left", function (c)
      c:relative_move(-10,   0,   0,   0) end,
    {description = "Floating Move Left", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right", function (c)
      c:relative_move( 10,   0,   0,   0) end,
    {description = "Floating Move Right", group = "client"}),

    -- Maximize unmaximize
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "Up",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Control" }, "Down",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Control" }, "Right",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),
    awful.key({ modkey, "Control" }, "Left",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),

    -- Moving window focus works between desktops
    -- Focus by id
    awful.key({ modkey,           }, "n",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "e",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "v",  function(c)
        client.focus = awful.client.getmaster()
        c:lower()
    end,
    {description = "focus master window", group = "client"}),
    awful.key({ modkey, "Shift"   }, "n", function () awful.client.swap.byidx(  1)    end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "e", function () awful.client.swap.byidx( -1)    end,
        {description = "swap with previous client by index", group = "client"})

    -- Focus by direction
--[[
    awful.key({ modkey,           }, "n", function (c)
      awful.client.focus.global_bydirection("down")
      c:lower()
    end,
    {description = "focus next window up", group = "client"}),
    awful.key({ modkey,           }, "e", function (c)
      awful.client.focus.global_bydirection("up")
      c:lower()
    end,
    {description = "focus next window down", group = "client"}),
    awful.key({ modkey,           }, "l", function (c)
      awful.client.focus.global_bydirection("right")
      c:lower()
    end,
    {description = "focus next window right", group = "client"}),
    awful.key({ modkey,           }, "h", function (c)
      awful.client.focus.global_bydirection("left")
      c:lower()
    end,
    {description = "focus next window left", group = "client"}),
    awful.key({ modkey,           }, "v",  function(c)
        client.focus = awful.client.getmaster()
        c:lower()
    end,
    {description = "focus master window", group = "client"}),
    -- Resize windows (for bydirection)
    awful.key({ modkey, "Control" }, "h", function (c)
      if c.floating then
        c:relative_move( 0, 0, -10, 0)
      else
        awful.tag.incmwfact(-0.025)
      end
    end,
    awful.key({ modkey, "Control" }, "l", function (c)
      if c.floating then
        c:relative_move( 0, 0,  10, 0)
      else
        awful.tag.incmwfact(0.025)
      end
    end,
    -- Moving windows between positions works between desktops
    awful.key({ modkey, "Shift"   }, "h", function (c)
      awful.client.swap.global_bydirection("left")
      c:raise()
    end,
    {description = "Floating Resize Horizontal -", group = "client"}),
    {description = "swap with left client", group = "client"}),
    awful.key({ modkey, "Shift"   }, "l", function (c)
      awful.client.swap.global_bydirection("right")
      c:raise()
    end,
    {description = "swap with right client", group = "client"}),
    awful.key({ modkey, "Shift"   }, "n", function (c)
      awful.client.swap.global_bydirection("down")
      c:raise()
    end,
    {description = "swap with down client", group = "client"}),
    awful.key({ modkey, "Shift"   }, "e", function (c)
      awful.client.swap.global_bydirection("up")
      c:raise()
    end,
    {description = "swap with up client", group = "client"})
--]]
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Control floating windows with mouse
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.centered + awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    { rule_any = {
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Remove titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }

    },

    -- { rule = { class = "discord" },
    --   properties = { screen = 1, tag = "9" }
    -- },

    -- { rule = { class = "mpv" },
    --   properties = { screen = 1, fullscreen = true }
    -- },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Functions

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

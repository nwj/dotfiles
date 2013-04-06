---------------------------
-- arrow awesome theme --
---------------------------
theme = {}

-- FONT
theme.font          = "PT Sans 10.5"

-- THEME DIRECTORY SHORTCUT
theme_dir           = os.getenv("HOME") .. "/.config/awesome/themes/nwj/"

-- WALLPAPER
theme.wallpaper = theme_dir .. "/background.jpg"


-- COLORS
lgrey               = "#efefef"
dgrey               = "#252525"
purple              = "#cfbfaf"
red                 = "#d0785d"
yellow              = "#efef8f"
brown               = "#c3bf9f"
gold                = "#f0dfaf"
green               = "#92b0a0"
blue                = "#8cd0d3"

theme.bg_normal     = dgrey
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = theme.bg_normal
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = lgrey
theme.fg_focus      = lgrey
theme.fg_urgent     = lgrey
theme.fg_minimize   = theme.fg_normal
theme.fg_systray    = theme.fg_normal

theme.border_width  = 1
theme.border_normal = dgrey
theme.border_focus  = gold
theme.border_marked = gold

theme.titlebar_bg_focus = dgrey
theme.titlebar_bg_normal = dgrey
theme.titlebar_border_width = 0

theme.taglist_fg_focus = blue

theme.tasklist_bg_focus = dgrey
theme.tasklist_fg_focus = gold


--ICONS
theme.taglist_squares_sel   = theme_dir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = theme_dir .. "/taglist/squarew.png"

theme.menu_submenu_icon = theme_dir .. "/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

theme.titlebar_close_button_normal = theme_dir .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_dir .. "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_dir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_dir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_dir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_dir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme_dir .. "/titlebar/maximized_focus_active.png"

theme.layout_fairh = theme_dir .. "/layouts/fairhw.png"
theme.layout_fairv = theme_dir .. "/layouts/fairvw.png"
theme.layout_floating  = theme_dir .. "/layouts/floatingw.png"
theme.layout_magnifier = theme_dir .. "/layouts/magnifierw.png"
theme.layout_max = theme_dir .. "/layouts/maxw.png"
theme.layout_fullscreen = theme_dir .. "/layouts/fullscreenw.png"
theme.layout_tilebottom = theme_dir .. "/layouts/tilebottomw.png"
theme.layout_tileleft   = theme_dir .. "/layouts/tileleftw.png"
theme.layout_tile = theme_dir .. "/layouts/tilew.png"
theme.layout_tiletop = theme_dir .. "/layouts/tiletopw.png"
theme.layout_spiral  = theme_dir .. "/layouts/spiralw.png"
theme.layout_dwindle = theme_dir .. "/layouts/dwindlew.png"

theme.battery_icon = theme_dir .. "/widget/battery.png"
theme.volume_icon = theme_dir .. "/widget/volume.png"

theme.awesome_icon = theme_dir .. "/clear.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

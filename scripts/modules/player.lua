require "mod-gui"

local player_data = {}
local module_libs =
{
    richtext = require "scripts/modules/richtext",
    types = require "scripts/modules/types",
    colors = require "scripts/modules/colors",
    fonts = require "scripts/modules/fonts",
    gps = require "scripts/modules/gps",
    trains = require "scripts/modules/trains",
    trainstops = require "scripts/modules/trainstops",
    settings = require "scripts/modules/settings",
    multiplayer = require "scripts/modules/multiplayer"
}

player_data.metatable = { __index = player_data }

function player_data.new( player, players )
    local module =
    {
        player = player,
        players = players,
        index = tostring( player.index ),
        location = { x = 5, y = 85 * player.display_scale },
        button = mod_gui.get_button_flow( player ).add{ type = "sprite-button", name = "RICH_CLICK_20_player01", sprite = "utility/rename_icon_normal", style = mod_gui.button_style }
    }

    module.button.visible = not settings.get_player_settings( player )["Rich-Hide-Button"].value
    module.richtext = module_libs.richtext.new( module )
    module.types = module_libs.types.new( module )
    module.colors = module_libs.colors.new( module )
    module.fonts = module_libs.fonts.new( module )
    module.gps = module_libs.gps.new( module )
    module.trains = module_libs.trains.new( module )
    module.trainstops = module_libs.trainstops.new( module )
    module.settings = module_libs.settings.new( module )
    module.multiplayer = module_libs.multiplayer.new( module )

    setmetatable( module, player_data.metatable )

    return module
end

function player_data:gui()
    local frame = self.player.gui.screen.add{ type = "frame", name = "RICH_LOCATION_23_player01", direction = "vertical", style = "richmainframe" }
    local titleflow = frame.add{ type = "flow", direction = "horizontal", style = "richtitlebarflow" }
    titleflow.add{ type = "label", caption = { "Rich.Title" }, style = "frame_title" }
    titleflow.add{ type = "empty-widget", style = "richdragwidget" }.drag_target = frame
    titleflow.add{ type = "sprite-button", name = "RICH_CLICK_20_player02", sprite = "utility/close_white", style = "frame_action_button" }
    local pane = frame.add{ type = "frame", style = "inside_deep_frame_for_tabs" }.add{ type = "tabbed-pane", style = "richpane400" }
    local tabs =
    {
        pane.add{ type = "tab", caption = { "Rich.Tab01" } },
        pane.add{ type = "tab", caption = { "Rich.Tab02" } },
        pane.add{ type = "tab", caption = { "Rich.Tab03" } },
        pane.add{ type = "tab", caption = { "Rich.Tab04" } },
        pane.add{ type = "tab", caption = { "Rich.Tab05" } },
        pane.add{ type = "tab", caption = { "Rich.Tab06" } },
        pane.add{ type = "tab", caption = { "Rich.Tab07" } },
        pane.add{ type = "tab", caption = { "Rich.Tab08" } }
    }
    tabs[8].enabled = game.is_multiplayer()
    
    if not tabs[8].enabled then
        tabs[8].tooltip = { "Rich.NotMP" }
    end

    self.multiplayer_tab = tabs[8]
    local scrollpanes =
    {
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane" },
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane" },
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane" },
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane" },
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane" },
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane" },
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane" },
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane" }
    }

    pane.add_tab( tabs[1], scrollpanes[1] )
    pane.add_tab( tabs[2], scrollpanes[2] )
    pane.add_tab( tabs[3], scrollpanes[3] )
    pane.add_tab( tabs[4], scrollpanes[4] )
    pane.add_tab( tabs[5], scrollpanes[5] )
    pane.add_tab( tabs[6], scrollpanes[6] )
    pane.add_tab( tabs[7], scrollpanes[7] )
    pane.add_tab( tabs[8], scrollpanes[8] )

    frame.location = self.location
    
    local player = self.player
    
    frame.style.maximal_height = ( player.display_resolution.height * 0.9 ) / player.display_scale
    frame.style.maximal_width = ( player.display_resolution.width * 0.9 ) / player.display_scale

    self.frame = frame

    self.richtext:gui( frame )
    self.types:gui( scrollpanes[1] )
    self.colors:gui( scrollpanes[2] )
    self.fonts:gui( scrollpanes[3] )
    self.gps:gui( scrollpanes[4] )
    self.trains:gui( scrollpanes[5] )
    self.trainstops:gui( scrollpanes[6] )
    self.settings:gui( scrollpanes[7] )
    self.multiplayer:gui( scrollpanes[8] )
end

function player_data:clear()
    self.frame.destroy()
    self.richtext:clear()
    self.types:clear()
    self.colors:clear()
    self.fonts:clear()
    self.gps:clear()
    self.trains:clear()
    self.settings:clear()
    self.multiplayer:clear()
    self.frame = nil
    self.savedentity = nil
end

function player_data:on_gui_click( event )
    local name = event.element.name
    local module_name = name:sub( 15, name:sub( 12, 13 ) )

    if module_name == "player" then
        local number = name:sub( 21, 22 )

        if number == "01" then
            if self.frame then
                self:clear()
            else
                self:gui()
            end
        elseif number == "02" then
            self:clear()
        end
    else
        local trigger = self[module_name]

        if trigger then
            trigger:on_gui_click( event )
        end
    end
end

function player_data:on_gui_confirmed( event )
    local name = event.element.name
    local trigger = self[name:sub( 19, name:sub( 16, 17 ) )]

    if trigger then
        trigger:on_gui_confirmed( event )
    end
end

function player_data:on_gui_location_changed( event )
    local element = event.element
    
    if element.index == self.frame.index then
        self.location = element.location
    end
end

function player_data:on_gui_selection_state_changed( event )
    local name = event.element.name
    local trigger = self[name:sub( 14, name:sub( 11, 12 ) )]

    if trigger then
        trigger:on_gui_selection_state_changed( event )
    end
end

function player_data:on_gui_text_changed( event )
    local name = event.element.name
    local trigger = self[name:sub( 17, name:sub( 14, 15 ) )]

    if trigger then
        trigger:on_gui_text_changed( event )
    end
end

function player_data:on_gui_value_changed( event )
    local name = event.element.name
    local trigger = self[name:sub( 16, name:sub( 13, 14 ) )]

    if trigger then
        trigger:on_gui_value_changed( event )
    end
end

function player_data:load()
    for name, lib in pairs( module_libs ) do
        setmetatable( self[name], lib.metatable )
    end
end

return player_data
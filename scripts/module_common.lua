local player_lib = require "scripts/modules/player"
local definesevents = defines.events

local script_data =
{
    players = {}
}

local PlayerStart = function( player_index )
    if not script_data.players[tostring( player_index )] then
        local player = player_lib.new( game.players[player_index], script_data.players )

        script_data.players[player.index] = player
    end
end

local PlayerLoad = function()
    for _, player in pairs( game.players ) do
        PlayerStart( player.index )
    end
end

local on_gui_click = function( event )
    if event.element.name:sub( 1, 10 ) == "RICH_CLICK" then
        script_data.players[tostring( event.player_index )]:on_gui_click( event )
    end
end

local on_gui_confirmed = function( event )
    if event.element.name:sub( 1, 14 ) == "RICH_CONFIRMED" then
        script_data.players[tostring( event.player_index )]:on_gui_confirmed( event )
    end
end

local on_gui_location_changed = function( event )
    if event.element.name:sub( 1, 13 ) == "RICH_LOCATION" then
        script_data.players[tostring( event.player_index )]:on_gui_location_changed( event )
    end
end

local on_gui_selection_state_changed = function( event )
    if event.element.name:sub( 1, 9 ) == "RICH_DROP" then
        script_data.players[tostring( event.player_index )]:on_gui_selection_state_changed( event )
    end
end
local on_gui_text_changed = function( event )
    if event.element.name:sub( 1, 12 ) == "RICH_CHANGED" then
        script_data.players[tostring( event.player_index )]:on_gui_text_changed( event )
    end
end

local on_gui_value_changed = function( event )
    if event.element.name:sub( 1, 11 ) == "RICH_SLIDER" then
        script_data.players[tostring( event.player_index )]:on_gui_value_changed( event )
    end
end

local on_player_created = function( event )
    PlayerStart( event.player_index )
end

local on_player_removed = function( event )
    script_data.players[tostring( event.player_index )] = nil
end

local on_runtime_mod_setting_changed = function( event )
    if event.setting == "Rich-Hide-Button" then
        script_data.players[tostring( event.player_index )].button.visible = not settings.get_player_settings( game.players[event.player_index] )["Rich-Hide-Button"].value
    end

end

local lib = {}

lib.events =
{
    [definesevents.on_gui_click] = on_gui_click,
    [definesevents.on_gui_confirmed] = on_gui_confirmed,
    [definesevents.on_gui_location_changed] = on_gui_location_changed,
    [definesevents.on_gui_selection_state_changed] = on_gui_selection_state_changed,
    [definesevents.on_gui_text_changed] = on_gui_text_changed,
    [definesevents.on_gui_value_changed] = on_gui_value_changed,
    [definesevents.on_player_created] = on_player_created,
    [definesevents.on_player_removed] = on_player_removed,
    [definesevents.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed,
    ["RichGUI"] = function( event )
        local player = script_data.players[tostring( event.player_index )]

        if player.frame then
            player:clear()
        else
            player:gui()

            local entity = player.player.selected

            if type( entity ) == "table" then
                if entity.supports_backer_name() then
                    player.savedentity = entity

                    player.rich:update_text( entity.backer_name )
                else
                    player.player.print( { "Rich.NoBackerName" } )
                end
            end
        end
    end,
    ["RichBacker"] = function( event )
        local player = script_data.players[tostring( event.player_index )]

        if player.frame then
            local char = player.player
            local text = player.richtext.richfield.text

            if #text > 0 then
                local entity = char.selected

                if type( entity ) == "table" then
                    if entity.supports_backer_name() then
                        entity.backer_name = text
                    else
                        char.print( { "Rich.NoBackerName"} )
                    end
                else
                    char.print( { "Rich.NoEntitySelected" } )
                end
            else
                char.print( { "Rich.NoRichText" } )
            end
        end
    end
}

lib.on_init = function()
    global.richtext = global.richtext or script_data

    PlayerLoad()
end

lib.on_load = function()
    script_data = global.richtext or script_data

    for _, player in pairs( script_data.players ) do
        setmetatable( player, player_lib.metatable )
        
        player:load()
    end
end

lib.on_configuration_changed = function( event )
    global.richtext = global.richtext or script_data

    PlayerLoad()

    local changes = event.mod_changes and event.mod_changes["Rich_Text_Helper"] or {}

    if next( changes ) then
        local oldchanges = changes.old_version
        if oldchanges and changes.new_version then
            if oldchanges == "0.3.6" then
                local script = global.script_data

                if next( script ) then
                    for _, player in pairs( game.players ) do
                        local id = player.index

                        if player.gui.top.mod_gui_button_flow.RichButton then player.gui.top.mod_gui_button_flow.RichButton.destroy() end

                        if next( script.GUIS[id] ) then
                            script.GUIS[id].A["01"].destroy()
                        end

                        local playermeta = script_data.players[tostring( id )]
                    
                        playermeta.location = script.Position[id]
                        playermeta.richtext.currentrichtext = script.CurrentRichText[id]
                        playermeta.colors.currenthex = script.CurrentHEX[id]
                        playermeta.gps.currentposition = script.CurrentPosition[id]

                        local savedrichtexts = script.SavedRichTexts[id]
                        local savedcolors = script.SavedColors[id]
                        local savedgps = script.SavedGPS[id]

                        for index, text in pairs( savedrichtexts.RichTexts ) do
                            playermeta.richtext:addpreset( savedrichtexts.RichTextNames[index], text )
                        end

                        for index, color in pairs( savedcolors.Colors ) do
                            playermeta.colors:addpreset( savedcolors.ColorNames[index], color )
                        end

                        for index, position in pairs( savedgps.Positions ) do
                            playermeta.gps:addpreset( savedgps.PositionNames[index], position )
                        end
                    end
                end
            elseif oldchanges == "0.4.0" or oldchanges == "0.4.1" then
                for _, player in pairs( game.players ) do
                    if player.gui.top.mod_gui_button_flow.RichButton then player.gui.top.mod_gui_button_flow.RichButton.destroy() end
                end
            end
        end

        global.script_data = nil
    end
end

return lib
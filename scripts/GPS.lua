local UpdateText = require "scripts/Shared Functions".UpdateText
local AddPreset = require "scripts/Shared Functions".GPSAddPreset
local de = defines.events
local Format = string.format
local script_data = {}

local richtextreturn = function( player_id, button )
    local player = game.players[player_id]
    local position = player.position

    if button == defines.mouse_button_type.left then
        if script_data.GUIS[player_id].F["01"]["03"].visible then
            position = script_data.CurrentPosition[player_id]
        else
            player.print( { "Rich.CantAdd" } )

            return ""
        end
    end

    return "[gps=" .. position.x .. "," .. position.y .. "]"
end

local Update = function( player_id, coords )
    local gui = script_data.GUIS[player_id].F["02"]

    if next( coords ) then
        gui["06"].caption = "X: " .. coords.x
        gui["07"].caption = "Y: " .. coords.y
    else
        gui["06"].caption = ""
        gui["07"].caption = ""
    end

    script_data.CurrentPosition[player_id] = coords
end

local Toggle = function( player_id )
    local gui = script_data.GUIS[player_id].F["01"]

    gui["03"].visible = not gui["03"].visible
    gui["04"].visible = not gui["04"].visible
end

local Click =
{
    ["RichButtonFGUI01"] = function( event )
        game.print( "test" )
        AddPreset( event.player_index )
    end,
    ["RichButtonFGUI02"] = function( event )
        local player_id = event.player_index
        local richtext = richtextreturn( player_id, event.button )

        if richtext:len() > 0 then
            UpdateText( player_id, richtext .. script_data.GUIS[player_id].B["03"]["10"].text )
        end
    end,
    ["RichButtonFGUI03"] = function( event )
        local player_id = event.player_index
        local richtext = richtextreturn( player_id, event.button )

        if richtext:len() > 0 then
            UpdateText( player_id, script_data.GUIS[player_id].B["03"]["10"].text .. richtext )
        end
    end,
    ["RichSpriteButtonFGUI01"] = function( event )
        local player_id = event.player_index
        local gui = script_data.GUIS[player_id].F["02"]["03"]
        local selected_index = gui.selected_index

        if selected_index > 0 then
            local index_number = Format( "%02d", selected_index )
            local SavedGPS = script_data.SavedGPS[player_id]

            SavedGPS.Positions[index_number] = nil
            SavedGPS.PositionNames[index_number] = nil

            script_data.SavedGPS[player_id] =
            {
                Number = 0,
                Positions = {},
                PositionNames = {}
            }

            local Coordinates = SavedGPS.Positions

            if next( Coordinates ) then
                for entry, coords in pairs( Coordinates ) do
                    AddPreset( player_id, "addcurrent", SavedGPS.PositionNames[entry], coords )
                end

                if  gui.selected_index == 0 then
                    Update( player_id, {} )
                    Toggle( player_id )
                else
                    Update( player_id, script_data.SavedGPS[player_id].Positions[index_number] )
                end
            else
                gui.items = {}

                Update( player_id, {} )
                Toggle( player_id )
            end
        else
            game.players[player_id].print( { "Rich.NothingSelected" } )
        end
    end

}

local Events =
{
    ["RichDropDownFGUI01"] = function( event )
        local player_id = event.player_index

        if not script_data.GUIS[player_id].F["01"]["03"].visible then
            Toggle( player_id )
        end

        Update( player_id, script_data.SavedGPS[player_id].Positions[Format( "%02d", event.element.selected_index )] )
    end
}

--Events
local on_gui_click = function( event )
    local click = Click[event.element.name]

    if click then
        click( event )
    end
end

local on_gui_event = function( event )
    local events = Events[event.element.name]

    if events then
        events( event )
    end
end


local lib = {}

lib.events =
{
    [de.on_gui_click] = on_gui_click,
    [de.on_gui_selection_state_changed] = on_gui_event
}

lib.on_init = function()
    script_data = global.script_data
end

lib.on_load = function()
    script_data = global.script_data
end

lib.on_configuration_changed = function( event )
    local changes = event.mod_changes or {}

    if next( changes ) then
        script_data = global.script_data
    end
end

return lib
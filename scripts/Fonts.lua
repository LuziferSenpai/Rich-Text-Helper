local Defines = require "defines"
local UpdateText = require "scripts/Shared Functions".UpdateText
local de = defines.events
local Format = string.format
local script_data = {}

local richtextreturn = function( player_id )
    local selected_index = script_data.GUIS[player_id].E["02"]["03"].selected_index

    if selected_index > 0 then
        return "[font=" .. Defines.FontDropDownNames[Format( "%02d", selected_index )] .. "]"
    else
        game.players[player_id].print( { "Rich.CantAdd" } )

        return ""
    end
end

local Click =
{
    ["RichButtonEGUI01"] = function( event )
        local player_id = event.player_index
        local richtext = richtextreturn( player_id )

        if richtext:len() > 0 then
            UpdateText( player_id, richtext .. "[/font]" .. script_data.GUIS[player_id].B["03"]["10"].text )
        end
    end,
    ["RichButtonEGUI02"] = function( event )
        local player_id = event.player_index
        local richtext = richtextreturn( player_id )

        if richtext:len() > 0 then
            UpdateText( player_id, script_data.GUIS[player_id].B["03"]["10"].text .. richtext .. "[/font]" )
        end
    end,
    ["RichButtonEGUI03"] = function( event )
        local player_id = event.player_index
        local richtext = richtextreturn( player_id )

        if richtext:len() > 0 then
            UpdateText( player_id, richtext .. script_data.GUIS[player_id].B["03"]["10"].text .. "[/font]" )
        end
    end
}


--Events
local on_gui_click = function( event )
    local click = Click[event.element.name]

    if click then
        click( event )
    end
end

local lib = {}

lib.events =
{
    [de.on_gui_click] = on_gui_click
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
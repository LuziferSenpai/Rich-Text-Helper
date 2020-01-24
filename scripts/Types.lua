local GUI = require( "GUI" ).AddChooseElemButton
local Defines = require "defines"
local de = defines.events
local Format = string.format
local script_data = {}

local richtextreturn = function( player_id )
    local gui = script_data.GUIS[player_id].C
    local richtext = ""
    local elem_value = gui["03"].elem_value
    if type( elem_value) ~= "nil" then
        local selected_index = gui["02"]["03"].selected_index

        if type( elem_value ) == "table" then
            local elemtype = elem_value.type

            if elemtype == "virtual" then
                selected_index = 8
            elseif elemtype == "fluid" then
                selected_index = 6
            elseif elemtype == "item" then
                selected_index = 1
            end

            elem_value = elem_value.name
        end

        local richtype = Defines.ChooseElemTypesRich[Format( "%02d", selected_index )]

        if gui["02"]["04"].state then
            richtext = "[img=" .. richtype .. "/" .. elem_value .. "]"
        else
            richtext = "[" .. richtype .. "=" .. elem_value .. "]"
        end
    end

    return richtext
end

local Click =
{
    ["RichButtonCGUI01"] = function( event )
        local player_id = event.player_index
        local richtext = richtextreturn( player_id )

        if richtext ~= "" then
            script_data.UpdateText( player_id, richtext .. script_data.GUIS[player_id].B["03"]["10"].text )
        else
            game.players[player_id].print( { "Rich.NoChooseElem" } )
        end
    end,
    ["RichButtonCGUI02"] = function( event )
        local player_id = event.player_index
        local richtext = richtextreturn( player_id )

        if richtext ~= "" then
            script_data.UpdateText( player_id, script_data.GUIS[player_id].B["03"]["10"].text .. richtext )
        else
            game.players[player_id].print( { "Rich.NoChooseElem" } )
        end
    end
}

local Events =
{
    ["RichDropDownCGUI01"] = function( event )
        local player_id = event.player_index
        local gui = script_data.GUIS[player_id].C

        for i = 2, 5 do
            local Number = Format( "%02d", i )
            gui["01"][Number].visible = true
        end

        if gui["03"] then gui["03"].destroy() end

        gui["03"] = GUI( gui["01"]["03"], "RichChooseElemCGUI01", Defines.ChooseElemTypes[Format( "%02d", event.element.selected_index )] )
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
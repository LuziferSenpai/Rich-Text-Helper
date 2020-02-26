local UpdateText = require "scripts/Shared Functions".UpdateText
local AddPreset = require "scripts/Shared Functions".ColorAddPreset
local ColorUpdate = require "scripts/Shared Functions".ColorUpdate
local de = defines.events
local definesmouse = defines.mouse_button_type
local script_data = {}

local SliderEvent = function( event )
    ColorUpdate( event.player_index, "slider" )
end

local TexfieldEvent = function( event )
    local element = event.element

    if tonumber( element.text ) > 255 then element.text = "255" end

    ColorUpdate( event.player_index, "rgb" )
end

local PresetEvent = function( event )
    local player_id = event.player_index
    local index_number = event.element.name:gsub( "RichPresetLabelDGUI", "" )
    local button = event.button

    if button == definesmouse.left then
        ColorUpdate( player_id, "preset", index_number )
    elseif button == definesmouse.right then
        script_data.GUIS[player_id].D["02"]["19"].clear()

        local SavedColors = script_data.SavedColors[player_id]

        SavedColors.Colors[index_number] = nil
        SavedColors.ColorNames[index_number] = nil

        script_data.SavedColors[player_id] =
        {
            Number = 0,
            Colors = {},
            ColorNames = {}
        }

        local Colors = SavedColors.Colors

        if next( Colors ) then
            for entry, color in pairs( Colors ) do
                AddPreset( player_id, "addcurent", SavedColors.ColorNames[entry], color )
            end
        end
    else
        game.players[player_id].print( { "Rich.WrongButton" } )
    end
end

local Click =
{
    ["RichButtonDGUI01"] = function( event )
        AddPreset( event.player_index )
    end,
    ["RichButtonDGUI02"] = function( event )
        local player_id = event.player_index

        UpdateText( player_id, "[color=" .. script_data.CurrentHEX[player_id] .. "][/color]" .. script_data.GUIS[player_id].B["03"]["10"].text )
    end,
    ["RichButtonDGUI03"] = function( event )
        local player_id = event.player_index

        UpdateText( player_id, script_data.GUIS[player_id].B["03"]["10"].text .. "[color=" .. script_data.CurrentHEX[player_id] .. "][/color]" )
    end,
    ["RichButtonDGUI04"] = function( event )
        local player_id = event.player_index

        UpdateText( player_id, "[color=" .. script_data.CurrentHEX[player_id] .. "]" .. script_data.GUIS[player_id].B["03"]["10"].text .. "[/color]" )
    end
}

local Events =
{
    ["RichTextFieldDGUI01"] = TexfieldEvent,
    ["RichTextFieldDGUI02"] = TexfieldEvent,
    ["RichTextFieldDGUI03"] = TexfieldEvent,
    ["RichTextFieldDGUI04"] = function( event )
        local text = event.element.text
        local player_id = event.player_index

        if text:sub( 1, 1 ) == "#" and text:len() == 7 then
            for i = 2, 7 do
                if not text:sub( i, i ):find( "%x" ) then
                    ColorUpdate( player_id, "" )
                    return
                end
            end

            ColorUpdate( player_id, "hex" )
        else
            ColorUpdate( player_id, "" )
        end
    end,
    ["RichDropDownDGUI01"] = function( event )
        ColorUpdate( event.player_index, "drop-down" )
    end,
    ["RichSliderDGUI01"] = SliderEvent,
    ["RichSliderDGUI02"] = SliderEvent,
    ["RichSliderDGUI03"] = SliderEvent
}

--Events
local on_gui_click = function( event )
    if event.element.valid then
        local name = event.element.name
        local click = Click[name]

        if click then
            click( event )
        elseif name:find( "RichPresetLabelDGUI" ) then
            PresetEvent( event )
        end
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
    [de.on_gui_confirmed] = on_gui_event,
    [de.on_gui_selection_state_changed] = on_gui_event,
    [de.on_gui_value_changed] = on_gui_event
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
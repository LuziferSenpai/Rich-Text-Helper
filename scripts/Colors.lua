local GUI = require( "GUI" ).AddButton
local Defines = require "defines"
local de = defines.events
local definesmouse = defines.mouse_button_type
local Format = string.format
local script_data = {}

local ColortoHEX = function( color )
    return string.format( "#%.2X%.2X%.2X", color.r, color.g, color.b )
end

local HEXtoColor = function( HEX )
    HEX = HEX:gsub( "#", "" )
    return { r = tonumber( "0x" .. HEX:sub( 1, 2 ) ), g = tonumber( "0x" .. HEX:sub( 3, 4 ) ), b = tonumber( "0x" .. HEX:sub( 5, 6 ) ) }
end

local AddPreset = function( player_id, adding_type, tooltip01, color01 )
    local gui = script_data.GUIS[player_id].D
    local SavedColors = script_data.SavedColors[player_id]

    SavedColors.Number = SavedColors.Number + 1

    if SavedColors.Number < 100 then
        local index_number = Format( "%02d", SavedColors.Number )
        local color = HEXtoColor( script_data.CurrentHEX[player_id] )
        local tooltip = gui["02"]["17"]

        gui["02"]["17"].text = ""
        gui["03"][index_number] = GUI( gui["02"]["19"], "RichPresetButtonDGUI" .. index_number, "B", "richpresetbutton" )

        if adding_type == "addcurrent" then
            color = color01
            tooltip = tooltip01
        end

        gui["03"][index_number].style.font_color = color
        gui["03"][index_number].style.hovered_font_color = color
        gui["03"][index_number].style.clicked_font_color = color
        gui["03"][index_number].style.disabled_font_color = color

        if tooltip:len() > 0 then
            gui["03"][index_number].tooltip = tooltip
        end

        SavedColors.Colors[index_number] = color
        SavedColors.ColorNames[index_number] = tooltip
    else
        game.players[player_id].print( { "Rich.PresetsError100" } )
    end
end

local ColorUpdate = function( player_id, element_type, index_number )
    local gui = script_data.GUIS[player_id].D["02"]

    local color = HEXtoColor( script_data.CurrentHEX[player_id] )

    if element_type == "drop-down" then
        color = Defines.ColorDropDownRGB[Format( "%02d", gui["03"].selected_index )]
    elseif element_type == "" then
    else
        gui["03"].selected_index = 0

        if element_type == "rgb" then
            color = { r = tonumber( gui["06"].text ), g = tonumber( gui["09"].text ), b = tonumber( gui["12"].text ) }
        elseif element_type == "hex" then
            color = HEXtoColor( gui["13"].text )
        elseif element_type == "slider" then
            color = { r = gui["05"].slider_value, g = gui["08"].slider_value, b = gui["11"].slider_value }
        elseif element_type == "preset" then
            color = script_data.SavedColors[player_id].Colors[index_number]
        end
    end

    local HEX = ColortoHEX( color )

    gui["05"].slider_value = color.r
    gui["06"].text = color.r
    gui["08"].slider_value = color.g
    gui["09"].text = color.g
    gui["11"].slider_value = color.b
    gui["12"].text = color.b
    gui["13"].text = HEX
    gui["15"].style.font_color = color

    script_data.CurrentHEX[player_id] = HEX
end

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
    local index_number = event.element.name:gsub( "RichPresetButtonDGUI", "" )
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
        local color = HEXtoColor( script_data.CurrentHEX[player_id] )

        script_data.UpdateText( player_id, "[color=" .. color.r .. "," .. color.g .. "," .. color.b .. "][/color]" .. script_data.GUIS[player_id].B["03"]["10"].text )
    end,
    ["RichButtonDGUI03"] = function( event )
        local player_id = event.player_index
        local color = HEXtoColor( script_data.CurrentHEX[player_id] )

        script_data.UpdateText( player_id, script_data.GUIS[player_id].B["03"]["10"].text .. "[color=" .. color.r .. "," .. color.g .. "," .. color.b .. "][/color]" )
    end,
    ["RichButtonDGUI04"] = function( event )
        local player_id = event.player_index
        local color = HEXtoColor( script_data.CurrentHEX[player_id] )

        script_data.UpdateText( player_id, "[color=" .. color.r .. "," .. color.g .. "," .. color.b .. "]" .. script_data.GUIS[player_id].B["03"]["10"].text .. "[/color]" )
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
    local name = event.element.name
    local click = Click[name]

    if click then
        click( event )
    elseif name:find( "RichPresetButtonDGUI" ) then
        PresetEvent( event )
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

    script_data.ColorUpdate = ColorUpdate
    script_data.ColorAddPreset = AddPreset
end

lib.on_load = function()
    script_data = global.script_data
end

lib.on_configuration_changed = function( event )
    local changes = event.mod_changes or {}

    if next( changes ) then
        script_data = global.script_data

        script_data.ColorUpdate = ColorUpdate
        script_data.ColorAddPreset = AddPreset
    end
end

return lib
local RichTextAddPreset = require "scripts/Shared Functions".RichTextAddPreset
local ColorAddPreset = require "scripts/Shared Functions".ColorAddPreset
local GPSAddPreset = require "scripts/Shared Functions".GPSAddPreset
local de = defines.events
local Format = string.format
local script_data = {}

local Check = function( Number, Table01, Table01type, Table01check, Table02 )
    local index_number = ""
    local table01 = {}
    local table02 = {}

    if ( type( Number ) ~= "number" or Number < 1 or type( Table01 ) ~= "table" or type( Table02 ) ~= "table" ) then
        return false
    end

    for i = 1, Number do
        index_number = Format( "%02d", i )

        table01 = Table01[index_number]
        table02 = Table02[index_number]

        if not ( table01 or table02 ) then
            return false
        end

        if type( table01 ) == Table01type then
            if type( table01 ) == "table" then
                if table_size( table01 ) == table_size( Table01check ) then
                    for index, _ in pairs( Table01check ) do
                        if not table01[index] then
                            return false
                        elseif type( table01[index] ) ~= "number" then
                            return false
                        end
                    end
                end
            end
        else
            return false
        end

        if type( table02 ) ~= "string" then
            return false
        end
    end

    return true
end

local Click =
{
    ["RichButtonIGUI01"] = function( event )
        local player_id = event.player_index
        local gui = script_data.GUIS[player_id].I["01"]
        local exporttable = {}

        if gui["03"].state and script_data.SavedRichTexts[player_id].Number > 0 then
            exporttable["richtext"] = script_data.SavedRichTexts[player_id]
        end

        if gui["04"].state and script_data.SavedColors[player_id].Number > 0 then
            exporttable["color"] = script_data.SavedColors[player_id]
        end

        if gui["05"].state and script_data.SavedGPS[player_id].Number > 0 then
            exporttable["gps"] = script_data.SavedGPS[player_id]
        end

        if next( exporttable ) then
            gui["07"].text = game.encode_string( game.table_to_json( exporttable ) )
        end
    end,
    ["RichButtonIGUI02"] = function( event )
        local element = script_data.GUIS[event.player_index].I["01"]["07"]

        element.select_all()
        element.focus()
    end,
    ["RichButtonIGUI03"] = function( event )
        local player_id = event.player_index
        local gui = script_data.GUIS[player_id].I["02"]["04"]
        local importtable = game.json_to_table( game.decode_string( gui.text ) )

        gui.text = ""

        if type( importtable ) == "table" and next( importtable ) then
            if type( importtable["richtext"] ) == "table" then
                local richtext = importtable["richtext"]

                if Check( richtext.Number, richtext.RichTexts, "string", nil, richtext.RichTextNames ) then
                    for index, text in pairs( richtext.RichTexts ) do
                        RichTextAddPreset( player_id, "addcurrent", richtext.RichTextNames[index], text )
                    end
                end
            end

            if type( importtable["color"] ) == "table" then
                local color = importtable["color"]

                if Check( color.Number, color.Colors, "table", { r = 0, g = 0, b = 0 }, color.ColorNames ) then
                    for index, Color in pairs( color.Colors ) do
                        ColorAddPreset( player_id, "addcurrent", color.ColorNames[index], Color )
                    end
                end
            end

            if type( importtable["gps"] ) == "table" then
                local gps = importtable["gps"]

                if Check( gps.Number, gps.Positions, "table", { y = 0, x = 0 }, gps.PositionNames ) then
                    game.print( "test" )
                    for index, position in pairs( gps.Positions ) do
                        GPSAddPreset( player_id, "addcurrent", gps.PositionNames[index], position )
                    end
                end
            end
        end
    end
}

--Events
local on_gui_click = function( event )
    if event.element.valid then
        local click = Click[event.element.name]

        if click then
            click( event )
        end
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
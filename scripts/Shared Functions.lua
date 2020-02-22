local Defines = require "defines"
local GUI = require "scripts/GUI".AddButton
local Format = string.format
local script_data = {}

local ColortoHEX = function( color )
    return string.format( "#%.2X%.2X%.2X", color.r, color.g, color.b )
end

local HEXtoColor = function( HEX )
    HEX = HEX:gsub( "#", "" )
    return { r = tonumber( "0x" .. HEX:sub( 1, 2 ) ), g = tonumber( "0x" .. HEX:sub( 3, 4 ) ), b = tonumber( "0x" .. HEX:sub( 5, 6 ) ) }
end

local UpdateText = function( player_id, text )
	local gui = script_data.GUIS[player_id].B["03"]

	gui["10"].text = text
	gui["13"].caption = text

	if not next( script_data.SavedEntity[player_id] ) then
		script_data.CurrentRichText[player_id] = text
	end
end

local RichTextAddPreset = function( player_id, adding_type, name01, text01 )
    local gui = script_data.GUIS[player_id].B["03"]
    local SavedRichTexts = script_data.SavedRichTexts[player_id]

    SavedRichTexts.Number = SavedRichTexts.Number + 1

    local Number = SavedRichTexts.Number

    if Number < 100 then
        local index_number = Format( "%02d", Number )
        local text = gui["10"].text
        local name = gui["17"].text

        gui["17"].text = ""

        if adding_type == "addcurrent" then
            text = text01
            name = name01
        end

        if name:len() == 0 then
            name = index_number
        end

        SavedRichTexts.RichTexts[index_number] = text
        SavedRichTexts.RichTextNames[index_number] = name

        gui["03"].items = SavedRichTexts.RichTextNames
    else
        game.players[player_id].print( { "Rich.PresetError100" } )
    end
end

local ColorAddPreset = function( player_id, adding_type, tooltip01, color01 )
    local gui = script_data.GUIS[player_id].D
    local SavedColors = script_data.SavedColors[player_id]

    SavedColors.Number = SavedColors.Number + 1

    if SavedColors.Number < 100 then
        local index_number = Format( "%02d", SavedColors.Number )
        local color = HEXtoColor( script_data.CurrentHEX[player_id] )
        local tooltip = gui["02"]["17"].text

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

local GPSAddPreset = function( player_id, adding_type, name01, coordinates01 )
    local gui = script_data.GUIS[player_id].F["02"]
    local SavedGPS = script_data.SavedGPS[player_id]
    local player = game.players[player_id]

    SavedGPS.Number = SavedGPS.Number + 1

    if SavedGPS.Number < 100 then
        game.print( "test01" )
        local index_number = Format( "%02d", SavedGPS.Number )
        local coordinates = player.position
        local name = gui["09"].text

        gui["09"].text = ""

        if adding_type == "addcurrent" then
            coordinates = coordinates01
            name = name01
        end

        if name:len() == 0 then
            name = index_number
        end

        SavedGPS.Positions[index_number] = coordinates
        SavedGPS.PositionNames[index_number] = name

        gui["03"].items = SavedGPS.PositionNames
    else
        player.print( { "Rich.PresetsError100" } )
    end
end

local TrainUpdate = function( player_id )
    local player = game.players[player_id]
	local force = player.force
	local datatable = {}
	local sorttable = {}
	local SavedTrains =
	{
		Number = 0,
		UnitNumbers = {},
		BackerNames = {}
	}
	local index_number = 0

	for _, surface in pairs( game.surfaces ) do
		local trains = surface.get_trains( force )

		if next( trains ) then
			for _, train in pairs( trains ) do
				local locomotives = train.locomotives

				if next( locomotives.back_movers ) then
					for _, locomotive in pairs( locomotives.back_movers ) do
						datatable[locomotive.backer_name] = locomotive.unit_number

						table.insert( sorttable, locomotive.backer_name )
					end
				end

				if next( locomotives.front_movers ) then
					for _, locomotive in pairs( locomotives.front_movers ) do
						datatable[locomotive.backer_name] = locomotive.unit_number

						table.insert( sorttable, locomotive.backer_name )
					end
				end
			end
		end
	end

	if next( sorttable ) then
		table.sort( sorttable )

		for _, name in pairs( sorttable ) do
			SavedTrains.Number = SavedTrains.Number + 1

			if SavedTrains.Number < 1000 then
				index_number = Format( "%03d", SavedTrains.Number )

				SavedTrains.UnitNumbers[index_number] = datatable[name]
				SavedTrains.BackerNames[index_number] = name
			else
				player.print( { "Rich.PresetsError1000" } )

				return
			end
		end
	end

	script_data.GUIS[player_id].G["02"]["03"].items = SavedTrains.BackerNames
    script_data.SavedTrains[player_id] = SavedTrains
end

local TrainStopUpdate = function( player_id )
    local player = game.players[player_id]
	local force = player.force
	local datatable = {}
	local sorttable = {}
	local SavedTrainStops =
	{
		Number = 0,
		UnitNumbers = {},
		BackerNames = {}
	}
	local index_number = 0

	for _, surface in pairs( game.surfaces ) do
		local trainstops = surface.get_train_stops{ force }

		if next( trainstops ) then
			for _, trainstop in pairs( trainstops ) do
				datatable[trainstop.backer_name] = trainstop.unit_number

				table.insert( sorttable, trainstop.backer_name )
			end
		end
	end

	if next( sorttable ) then
		table.sort( sorttable )

		for _, name in pairs( sorttable ) do
			SavedTrainStops.Number = SavedTrainStops.Number + 1

			if SavedTrainStops.Number < 1000 then
				index_number = Format( "%03d", SavedTrainStops.Number )

				SavedTrainStops.UnitNumbers[index_number] = datatable[name]
				SavedTrainStops.BackerNames[index_number] = name
			else
				player.print( { "Rich.PresetsError1000" } )

				return
			end
		end
	end

	script_data.GUIS[player_id].H["02"]["03"].items = SavedTrainStops.BackerNames
    script_data.SavedTrainStops[player_id] = SavedTrainStops
end

local lib = {}

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

return
{
    lib = lib,
    UpdateText = UpdateText,
    RichTextAddPreset = RichTextAddPreset,
    ColorAddPreset = ColorAddPreset,
    ColorUpdate = ColorUpdate,
    GPSAddPreset = GPSAddPreset,
    TrainUpdate = TrainUpdate,
    TrainStopUpdate = TrainStopUpdate
}
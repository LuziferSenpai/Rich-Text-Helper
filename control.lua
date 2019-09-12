require "mod-gui"
require "util"

local Functions = require "functions"
local de = defines.events

script.on_init( function()
	Functions.Globals()
	Functions.Players()
end )

script.on_configuration_changed( function()
	Functions.Globals()
	Functions.Players()
end )

script.on_event( de.on_gui_click, function( event )
	local element = event.element
	local name = element.name

	if name == nil then return end

	local player_id = event.player_index

	if name == "RichButton" then
		Functions.MainGUIToggle( player_id )
	end

	if next( global.GUIS[player_id] ) then
		local GUI = global.GUIS[player_id]

		if not GUI.A["01"].visible then return end

		local player = game.players[player_id]
		local TEXT = GUI.A["04"]["19"].text
		local TEXTLEN = TEXT:len()

		--A
		if name == "RichButton01" then
			GUI = GUI.A["04"]
			GUI["19"].text = ""
			GUI["22"].caption = ""
		elseif name == "RichButton02" then
			if TEXTLEN > 0 then
				Functions.MainGUIAddPreset( player_id )
			else
				player.print( { "Rich.NoRichText" } )
			end
		elseif name == "RichButton03" then
			GUI = GUI.A["04"]

			if TEXTLEN > 0 then
				local elem_value = GUI["26"].elem_value
				local tag =
				{
					position = player.position,
					text = TEXT,
					last_user = player_id
				}

				if type( elem_value ) == "table" then
					tag.icon = elem_value
					GUI["26"].elem_value = nil
				end

				player.force.add_chart_tag( player.surface, tag )
			else
				player.print( { "Rich.NoRichText" } )
			end
		elseif name == "RichButton04" then
			if TEXTLEN > 0 then
				local chat_color = player.chat_color

				game.print( "[color=" .. chat_color.r .. "," .. chat_color.g .. "," .. chat_color.b .. "]" .. player.name .. ": " .. TEXT .. "[/color]" )
			else
				player.print( { "Rich.NoRichText" } )
			end
		elseif name == "RichButton05" then
			if TEXTLEN > 0 then
				if player.opened_gui_type == defines.gui_type.entity then
					local entity = player.opened
					if entity.supports_backer_name() then
						entity.backer_name = TEXT
					else
						player.print( { "Rich.NoBackerName" } )
					end
				else
					player.print( { "Rich.NoEntityOpen" } )
				end
			else
				player.print( { "Rich.NoRichText" } )
			end

		--B
		elseif name == "RichButton06" then
			local elem_value = GUI.B["03"].elem_value

			if type( elem_value ) ~= "nil" then
				if type( elem_value ) == "table" then elem_value = elem_value.name end

				Functions.MainGUIUpdateText( player_id, "[" .. Functions.defines.Menus.Tab01.ChooseElemTypesRich[Functions.Format2Digit( GUI.B["02"]["03"].selected_index )] .. "=" .. elem_value .. "]" .. TEXT )
			else
				player.print( { "Rich.NoChooseElem" } )
			end
		elseif name == "RichButton07" then
			local elem_value = GUI.B["03"].elem_value

			if type( elem_value ) ~= "nil" then
				if type( elem_value ) == "table" then elem_value = elem_value.name end

				Functions.MainGUIUpdateText( player_id, TEXT .. "[" .. Functions.defines.Menus.Tab01.ChooseElemTypesRich[Functions.Format2Digit( GUI.B["02"]["03"].selected_index )] .. "=" .. elem_value .. "]" )
			else
				player.print( { "Rich.NoChooseElem" } )
			end

		--C
		elseif name == "RichButton08" then
			Functions.Tab02AddPreset( player_id )
		elseif name == "RichButton09" then
			local color = Functions.HEXtoColor( GUI.C["02"]["04"].caption )

			Functions.MainGUIUpdateText( player_id, "[color=" .. color.r .. "," .. color.g .. "," .. color.b .. "][/color]" .. TEXT )
		elseif name == "RichButton10" then
			local color = Functions.HEXtoColor( GUI.C["02"]["04"].caption )

			Functions.MainGUIUpdateText( player_id, TEXT .. "[color=" .. color.r .. "," .. color.g .. "," .. color.b .. "][/color]" )
		elseif name == "RichButton11" then
			local color = Functions.HEXtoColor( GUI.C["02"]["04"].caption )

			Functions.MainGUIUpdateText( player_id, "[color=" .. color.r .. "," .. color.g .. "," .. color.b .. "]".. TEXT .. "[/color]" )

		--D
		elseif name == "RichButton12" then
			local selected_index = GUI.D["02"]["03"].selected_index

			if selected_index > 0 then
				Functions.MainGUIUpdateText( player_id, "[font=" .. Functions.defines.Menus.Tab03.FontDropDownNames[Functions.Format2Digit( selected_index )] .. "][/font]" .. TEXT )
			else
				player.print( { "Rich.CantAdd" } )
			end
		elseif name == "RichButton13" then
			local selected_index = GUI.D["02"]["03"].selected_index

			if selected_index > 0 then
				Functions.MainGUIUpdateText( player_id, TEXT .. "[font=" .. Functions.defines.Menus.Tab03.FontDropDownNames[Functions.Format2Digit( selected_index )] .. "][/font]" )
			else
				player.print( { "Rich.CantAdd" } )
			end
		elseif name == "RichButton14" then
			local selected_index = GUI.D["02"]["03"].selected_index

			if selected_index > 0 then
				Functions.MainGUIUpdateText( player_id, "[font=" .. Functions.defines.Menus.Tab03.FontDropDownNames[Functions.Format2Digit( selected_index )] .. "]" .. TEXT .."[/font]" )
			else
				player.print( { "Rich.CantAdd" } )
			end

		--E
		elseif name == "RichButton15" then
			Functions.Tab04AddPreset( player_id )
		elseif name == "RichButton16" then
			local selected_index = GUI.E["02"]["03"].selected_index

			if selected_index > 0 then
				local gps = global.SavedGPS[player_id].Positions[Functions.Format2Digit( selected_index )]

				Functions.MainGUIUpdateText( player_id, "[gps=" .. gps.x .. "," .. gps.y .. "]" .. TEXT )
			else
				player.print( { "Rich.CantAdd" } )
			end
		elseif name == "RichButton17" then
			local selected_index = GUI.E["02"]["03"].selected_index

			if selected_index > 0 then
				local gps = global.SavedGPS[player_id].Positions[Functions.Format2Digit( selected_index )]

				Functions.MainGUIUpdateText( player_id, TEXT .. "[gps=" .. gps.x .. "," .. gps.y .. "]" )
			else
				player.print( { "Rich.CantAdd" } )
			end

		--F
		elseif name == "RichButton18" then
			local selected_index = GUI.F["02"]["03"].selected_index

			if selected_index > 0 then
				Functions.MainGUIUpdateText( player_id, "[train=" .. global.SavedTrains[player_id].UnitNumbers[Functions.Format2Digit( selected_index )] .. "]" .. TEXT )
			else
				player.print( { "Rich.CantAdd" } )
			end
		elseif name == "RichButton19" then
			local selected_index = GUI.F["02"]["03"].selected_index

			if selected_index > 0 then
				Functions.MainGUIUpdateText( player_id, TEXT .. "[train=" .. global.SavedTrains[player_id].UnitNumbers[Functions.Format2Digit( selected_index )] .. "]" )
			else
				player.print( { "Rich.CantAdd" } )
			end
		
		--G
		elseif name == "RichButton20" then
			local selected_index = GUI.G["02"]["03"].selected_index

			if selected_index > 0 then
				Functions.MainGUIUpdateText( player_id, "[train-stop=" .. global.SavedTrainStops[player_id].UnitNumbers[Functions.Format3Digit( selected_index )] .. "]" .. TEXT )
			else
				player.print( { "Rich.CantAdd" } )
			end
		elseif name == "RichButton21" then
			local selected_index = GUI.G["02"]["03"].selected_index

			if selected_index > 0 then
				Functions.MainGUIUpdateText( player_id, TEXT .. "[train-stop=" .. global.SavedTrainStops[player_id].UnitNumbers[Functions.Format3Digit( selected_index )] .. "]" )
			else
				player.print( { "Rich.CantAdd" } )
			end
		
		--C	
		elseif name:find( "RichPresetButton" ) then
			local index_number = name:gsub( "RichPresetButton", "" )
			local button = event.button
			local definesmouse = defines.mouse_button_type

			if button == definesmouse.left then
				Functions.Tab02ColorUpdate( player_id, "preset", index_number )
			elseif button == definesmouse.right then
				global.GUIS[player_id].C["02"]["20"].clear()

				local SavedColors = global.SavedColors[player_id]
				SavedColors.Colors[index_number] = nil
				SavedColors.ColorNames[index_number] = nil

				global.SavedColors[player_id] =
				{
					Number = 0,
					Colors = {},
					ColorNames = {}
				}

				local Colors = SavedColors.Colors

				if next( Colors ) then
					for entry, color in pairs( Colors ) do
						Functions.Tab02AddPreset( player_id, "addcurrent", SavedColors.ColorNames[entry], color )
					end
				end
			else
				player.print( { "Rich.WrongButton" } )
			end

		--A
		elseif name == "RichSpriteButton01" then
			GUI.A["01"].visible = false
		elseif name == "RichSpriteButton02" then
			GUI = GUI.A["04"]["17"]

			local selected_index = GUI.selected_index

			if selected_index > 0 then
				local index_number = Functions.Format2Digit( selected_index )

				local SavedRichTexts = global.SavedRichTexts[player_id]
				SavedRichTexts.RichTexts[index_number] = nil
				SavedRichTexts.RichTextNames[index_number] = nil

				global.SavedRichTexts[player_id] =
				{
					Number = 0,
					RichTexts = {},
					RichTextNames = {}
				}

				local Texts = SavedRichTexts.RichTexts

				if next( Texts ) then
					for entry, text in pairs( Texts ) do
						Functions.MainGUIAddPreset( player_id, "addcurrent", SavedRichTexts.RichTextNames[entry], text )
					end
				else
					GUI.items = {}
				end
			else
				player.print( { "Rich.NothingSelected" } )
			end

		--E
		elseif name == "RichSpriteButton03" then
			GUI = GUI.E["02"]["03"]

			local selected_index = GUI.selected_index

			if selected_index > 0 then
				local index_number = Functions.Format2Digit( selected_index )
				local SavedGPS = global.SavedGPS[player_id]
				SavedGPS.Positions[index_number] = nil
				SavedGPS.PositionNames[index_number] = nil
				global.SavedGPS[player_id] =
				{
					Number = 0,
					Positions = {},
					PositionNames = {}
				}

				local Coordinates = SavedGPS.Positions

				if next( Coordinates ) then
					for entry, coords in pairs( Coordinates ) do
						Functions.Tab04AddPreset( player_id, "addcurrent", SavedGPS.PositionNames[entry], coords )
					end
				else
					GUI.items = {}
				end
			else
				player.print( { "Rich.NothingSelected" } )
			end

		--F
		elseif name == "RichSpriteButton04" then
			Functions.Tab05Update( player_id )

		--G
		elseif name == "RichSpriteButton05" then
			Functions.Tab06Update( player_id )
		end
	end
end )

script.on_event( { de.on_gui_confirmed, de.on_gui_selection_state_changed, de.on_gui_value_changed }, function( event )
	local player_id = event.player_index

	if next( global.GUIS[player_id] ) then
		local GUI = global.GUIS[player_id]

		if not GUI.A["01"].visible then return end

		local element = event.element
		local name = element.name

		if name == nil then return end

		--C
		if Functions.defines.Menus.Tab02.TextfieldsRGB[name] then
			local text = element.text

			if tonumber( text ) > 255 then element.text = "255" end

			Functions.Tab02ColorUpdate( player_id, "rgb" )
		elseif name == "RichTextField06" then
			local text = element.text

			if text:sub( 1, 1 ) == "#" and text:len() == 7 then
				for i = 2, 7 do
					if not text:sub( i, i ):find( "%x" ) then
						Functions.Tab02ColorUpdate( player_id, "" )
						return
					end
				end

				Functions.Tab02ColorUpdate( player_id, "hex" )
			else
				Functions.Tab02ColorUpdate( player_id, "" )
			end

		--A
		elseif name == "RichDropDown01" then
			Functions.MainGUIUpdateText( player_id, global.SavedRichTexts[player_id].RichTexts[Functions.Format2Digit( element.selected_index )] )

		--B
		elseif name == "RichDropDown02" then
			Functions.Tab01ChooseElemChange( player_id, element.selected_index )
		
		--C
		elseif name == "RichDropDown03" then
			Functions.Tab02ColorUpdate( player_id, "drop-down" )
		elseif Functions.defines.Menus.Tab02.SlidersRGB[name] then
			Functions.Tab02ColorUpdate( player_id, "slider" )
		end
	end
end )

script.on_event( de.on_gui_text_changed, function( event )
	local player_id = event.player_index

	if next( global.GUIS[player_id] ) then
		local GUI = global.GUIS[player_id].A

		if not GUI["01"].visible then return end

		local element = event.element
		local name = element.name

		if name == nil then return end

		if name == "RichTextField01" then
			GUI = GUI["04"]
			GUI["22"].caption = GUI["19"].text
		end
	end
end )

script.on_event( de.on_gui_location_changed, function( event )
	local player_id = event.player_index

	if next( global.GUIS[player_id] ) then
		local element = event.element
		local name = element.name

		if name == "RichFrame01" then
			global.Position[player_id] = element.location
		end
	end
end )

script.on_event( de.on_player_created, function( event )
	Functions.PlayerStart( event.player_index )
end )

script.on_event( { "RichGUI", "RichBacker" }, function( event )
	local player_id = event.player_index
	local name = event.input_name

	if name == "RichGUI" then
		Functions.MainGUIToggle( player_id )
	elseif name == "RichBacker" then
		local text = global.GUIS[player_id].A["04"]["19"].text
		local player = game.players[player_id]
		if text:len() > 0 then
			local selected = player.selected
			if type( selected ) == "table" then
				if selected.supports_backer_name() then
					selected.backer_name = text
				else
					player.print( { "Rich.NoBackerName" } )
				end
			else
				player.print( { "Rich.NoEntitySelected" } )
			end
		else
			player.print( { "Rich.NoRichText" } )
		end
	end
end )
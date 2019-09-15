require "mod-gui"
require "util"

local Functions = require "functions"
local de = defines.events
local definesmouse = defines.mouse_button_type

script.on_init( function()
	Functions.Globals()
	Functions.Players()
end )

script.on_configuration_changed( function()
	local changes = ee.mod_changes or {}

	if next( d ) then
		Functions.Globals()
		Functions.Players()

		local richchanges = d["Rich_Text_Helper"] or {}

		if next( richchanges ) then
			local oldversion = richchanges.old_version

			if oldversion and richchanges.new_version then
				if oldversion <= "0.0.2" then

					for _, p in pairs( game.players ) do
						if next( global.GUIS[player_id] ) then
							local player_id = p.index
							local GUI = global.GUIS[player_id]
	
							global.CurrentRichText[player_id] = GUI.A["04"]["24"]
	
							GUI.A["01"].destroy()
	
							Functions.MainGUIToggle( player_id )
	
							local SavedColors = global.SavedColors[player_id]
	
							global.SavedColors[player_id] =
							{
								Number = 0,
								Colors = {},
								ColorNames = {}
							}
	
							local Colors = SavedColors
	
							if next( Colors ) then
								for entry, color in pairs( Colors ) do
									Functions.Tab02AddPreset( player_id, "addcurrent", SavedColors.ColorNames[entry], color )
								end
							end
						end
					end
				end
			end
		end
	end
end )

script.on_event( de.on_gui_click, function( event )
	local element = event.element
	local name = element.name
	local guitype = element.type

	if name == nil then return end

	if not ( guitype == "button" or guitype == "sprite-button" ) then return end

	if not name:find( "Rich" ) then return end 

	local player_id = event.player_index

	if name == "RichButton" then
		Functions.MainGUIToggle( player_id )
	elseif next( global.GUIS[player_id] ) then
		local GUI = global.GUIS[player_id]

		if not GUI.A["01"].visible then return end

		local player = game.players[player_id]
		local TEXT = GUI.A["04"]["24"].text
		local button = event.button

		--A
		if name:find( "AGUI" ) then
			local TEXTLEN = TEXT:len()
			GUI = GUI.A

			if name == "RichButtonAGUI01" then
				if GUI["03"]["07"].visible then
					Functions.MainGUIUpdateText( player_id, GUI["04"]["20"].caption  .. TEXT )
				else
					player.print( { "Rich.CantAdd" } )
				end
			elseif name == "RichButtonAGUI02" then
				if GUI["03"]["07"].visible then
					Functions.MainGUIUpdateText( player_id, TEXT .. GUI["04"]["20"].caption )
				else
					player.print( { "Rich.CantAdd" } )
				end
			elseif name == "RichButtonAGUI03" then
				if GUI["03"]["07"].visible then
					Functions.MainGUIUpdateText( player_id, GUI["04"]["20"].caption )
				else
					player.print( { "Rich.CantAdd" } )
				end
			elseif name == "RichButtonAGUI04" then
				Functions.MainGUIUpdateText( player_id, "" )
			elseif name == "RichButtonAGUI05" then
				if TEXTLEN > 0 then
					Functions.MainGUIAddPreset( player_id )
				else
					player.print( { "Rich.NoRichText" } )
				end
			elseif name == "RichButtonAGUI06" then
				if TEXTLEN > 0 then
					GUI = GUI["04"]

					local elem_value = GUI["31"].elem_value
					local tag =
					{
						position = player.position,
						text = TEXT,
						last_user = player
					}

					if type( elem_value ) == "table" then
						tag.icon = elem_value
					end

					local currentposi = global.CurrentPosition[player_id]

					if next( currentposi ) and button == defines.mouse_button_type.right then
						tag.position = currentposi
					end

					player.force.add_chart_tag( player.surface, tag )
				else
					player.print( { "Rich.NoRichText" } )
				end
			elseif name == "RichButtonAGUI07" then
				if TEXTLEN > 0 then
					local chat_color = player.chat_color

					game.print( "[color=" .. chat_color.r .. "," .. chat_color.g .. "," .. chat_color.b .. "]" .. player.name .. ": " .. TEXT .. "[/color]" )
				else
					player.print( { "Rich.NoRichText" } )
				end
			elseif name == "RichButtonAGUI08" then
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
			elseif name == "RichSpriteButtonAGUI01" then
				GUI["01"].visible = false
			elseif name == "RichSpriteButtonAGUI02" then
				GUI = GUI["04"]

				local selected_index = GUI["17"].selected_index

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

						GUI = global.GUIS[player_id].A["04"]
						selected_index = GUI["17"].selected_index
						
						if selected_index == 0 then
							GUI["20"].caption = ""

							Functions.MainGUIDropDownToggle( player_id )
						else
							GUI["20"].caption = global.SavedRichTexts[player_id].RichTexts[Functions.Format2Digit( selected_index )]
						end
					else
						GUI["17"].items = {}
						GUI["20"].caption = ""

						Functions.MainGUIDropDownToggle( player_id )
					end
				else
					player.print( { "Rich.NothingSelected" } )
				end
			end
		elseif name:find( "BGUI" ) then
			local elem_value = GUI.B["03"].elem_value
			if type( elem_value ) ~= "nil" then
				if type( elem_value ) == "table" then elem_value = elem_value.name end

				local richtext = "[" .. Functions.defines.Menus.Tab01.ChooseElemTypesRich[Functions.Format2Digit( GUI.B["02"]["03"].selected_index )] .. "=" .. elem_value .. "]"

				if name == "RichButtonBGUI01" then
					Functions.MainGUIUpdateText( player_id, richtext .. TEXT )
				elseif name == "RichButtonBGUI02" then
					Functions.MainGUIUpdateText( player_id, TEXT .. richtext )
				end
			else
				player.print( { "Rich.NoChooseElem" } )
			end
		elseif name:find( "CGUI" ) then
			local color = Functions.HEXtoColor( GUI.C["02"]["04"].caption )
			local color_string = "[color=" .. color.r .. "," .. color.g .. "," .. color.b .."]"

			if name == "RichButtonCGUI01" then
				Functions.Tab02AddPreset( player_id )
			elseif name == "RichButtonCGUI02" then
				Functions.MainGUIUpdateText( player_id, color_string .. "[/color]" .. TEXT )
			elseif name == "RichButtonCGUI03" then
				Functions.MainGUIUpdateText( player_id,TEXT ..  color_string .. "[/color]" )
			elseif name == "RichButtonCGUI04" then
				Functions.MainGUIUpdateText( player_id, color_string .. TEXT .. "[/color]" )
			elseif name:find( "RichPresetButtonCGUI" ) then
				local index_number = name:gsub( "RichPresetButtonCGUI", "" )

				if button == definesmouse.left then
					Functions.Tab02ColorUpdate( player_id, "preset", index_number )
				elseif button == definesmouse.right then
					GUI.C["02"]["20"].clear()

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
			end
		elseif name:find( "DGUI" ) then
			local selected_index = GUI.D["02"]["03"].selected_index

			if selected_index > 0 then
				local richtext = "[font=" .. Functions.defines.Menus.Tab03.FontDropDownNames[Functions.Format2Digit( selected_index )] .. "]"

				if name == "RichButtonDGUI01" then
					Functions.MainGUIUpdateText( player_id, richtext .. "[/font]" .. TEXT )
				elseif name == "RichButtonDGUI02" then
					Functions.MainGUIUpdateText( player_id, TEXT .. richtext .. "[/font]" )
				elseif name == "RichButtonDGUI03" then
					Functions.MainGUIUpdateText( player_id, richtext .. TEXT .. "[/font]" )
				end
			else
				player.print( { "Rich.CantAdd" } )
			end
		elseif name:find( "EGUI" ) then
			local position = player.position

			if button == definesmouse.left then
				GUI = GUI.E
				if GUI["01"]["03"].visible then
					position = global.CurrentPosition[player_id]
				else
					player.print( { "Rich.CantAdd" } )
				end
			end

			local richtext = "[gps=" .. position.x .. "," .. position.y .. "]"

			if name == "RichButtonEGUI01" then
				Functions.Tab04AddPreset( player_id )
			elseif name == "RichButtonEGUI02" then
				Functions.MainGUIUpdateText( player_id, richtext .. TEXT )
			elseif name == "RichButtonEGUI03" then
				Functions.MainGUIUpdateText( player_id, TEXT .. richtext )
			elseif name == "RichSpriteButtonEGUI01" then
				GUI = GUI["02"]["03"]

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

						if global.GUIS[player_id].E["02"]["03"].selected_index == 0 then
							Functions.Tab04Update( player_id, {} )
							Functions.Tab04Toggle( player_id )
						else
							Functions.Tab04Update( player_id, global.SavedGPS[player_id].Positions[Functions.Format2Digit( selected_index )] )
						end
					else
						GUI.items = {}

						Functions.Tab04Update( player_id, {} )
						Functions.Tab04Toggle( player_id )
					end
				else
					player.print( { "Rich.NothingSelected" } )
				end
			end
		elseif name:find( "FGUI" ) then
			local selected_index = GUI.F["02"]["03"].selected_index

			if name == "RichButtonFGUI01" then
				if selected_index > 0 then
					Functions.MainGUIUpdateText( player_id, "[train=" .. global.SavedTrains[player_id].UnitNumbers[Functions.Format3Digit( selected_index )] .. "]" .. TEXT )
				else
					player.print( { "Rich.CantAdd" } )
				end
			elseif name == "RichButtonFGUI02" then
				if selected_index > 0 then
					Functions.MainGUIUpdateText( player_id, TEXT .. "[train=" .. global.SavedTrains[player_id].UnitNumbers[Functions.Format3Digit( selected_index )] .. "]" )
				else
					player.print( { "Rich.CantAdd" } )
				end
			elseif name == "RichSpriteButtonFGUI01" then
				Functions.Tab05Update( player_id )
			end
		elseif name:find( "GGUI" ) then
			local selected_index = GUI.G["02"]["03"].selected_index

			if name == "RichButtonGGUI01" then
				if selected_index > 0 then
					Functions.MainGUIUpdateText( player_id, "[train-stop=" .. global.SavedTrainStops[player_id].UnitNumbers[Functions.Format3Digit( selected_index )] .. "]" .. TEXT )
				else
					player.print( { "Rich.CantAdd" } )
				end
			elseif name == "RichButtonGGUI02" then
				if selected_index > 0 then
					Functions.MainGUIUpdateText( player_id, TEXT .. "[train-stop=" .. global.SavedTrainStops[player_id].UnitNumbers[Functions.Format3Digit( selected_index )] .. "]" )
				else
					player.print( { "Rich.CantAdd" } )
				end
			elseif name == "RichSpriteButtonGGUI01" then
				Functions.Tab06Update( player_id )
			end
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

		if not name:find( "Rich" ) then return end


		--C
		if Functions.defines.Menus.Tab02.TextfieldsRGB[name] then
			local text = element.text

			if tonumber( text ) > 255 then element.text = "255" end

			Functions.Tab02ColorUpdate( player_id, "rgb" )
		elseif name == "RichTextFieldCGUI04" then
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
		elseif name == "RichDropDownAGUI01" then
			GUI = GUI.A
			GUI["04"]["20"].caption = global.SavedRichTexts[player_id].RichTexts[Functions.Format2Digit( element.selected_index )]

			if not GUI["03"]["07"].visible then
				Functions.MainGUIDropDownToggle( player_id )
			end		
		--B
		elseif name == "RichDropDownBGUI01" then
			Functions.Tab01ChooseElemChange( player_id, element.selected_index )
		
		--C
		elseif name == "RichDropDownCGUI01" then
			Functions.Tab02ColorUpdate( player_id, "drop-down" )

		--E
		elseif name == "RichDropDownEGUI01" then
			GUI = GUI.E

			if not GUI["01"]["03"].visible then
				Functions.Tab04Toggle( player_id )
			end

			Functions.Tab04Update( player_id, global.SavedGPS[player_id].Positions[Functions.Format2Digit( element.selected_index )] )



		--C
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

		if name == "RichTextFieldAGUI01" then
			GUI["04"]["27"].caption = element.text
		end
	end
end )

script.on_event( de.on_gui_location_changed, function( event )
	local player_id = event.player_index

	if next( global.GUIS[player_id] ) then
		local element = event.element
		local name = element.name

		if name == "RichFrameAGUI01" then
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
		local text = global.GUIS[player_id].A["04"]["24"].text
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
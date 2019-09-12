local Functions = {}

Functions.defines = require "defines"

--Global Tables
Functions.Globals = function()
	global.Position = global.Position or {}
	global.GUIS = global.GUIS or {}
	global.SavedRichTexts = global.SavedRichTexts or {}
	global.SavedColors = global.SavedColors or {}
	global.SavedGPS = global.SavedGPS or {}
	global.SavedTrains = global.SavedTrains or {}
	global.SavedTrainStops = global.SavedTrainStops or {}
end

--Player Data
Functions.Players = function()
	for _, p in pairs( game.players ) do
		Functions.PlayerStart( p.index )
	end
end

--MainGUI Frame
Functions.MainGUI = function( parent, player_id )
	local A = {}

	A["01"] = Functions.AddFrame( parent, "RichFrame01", "dialog_frame" )
	A["02"] =
	{
		["01"] = Functions.AddFlow( A["01"], "RichFlow01", "horizontal", "richtitlebarflow" ),
		["02"] = Functions.AddFrame( A["01"], "RichFrame02", "inside_deep_frame_for_tabs" ),
		["03"] = Functions.AddFrame( A["01"], "RichHiddenFrame01", "outer_frame_without_shadow" )
	}
	A["03"] =
	{
		["01"] = Functions.AddLabel( A["02"]["01"], "RichLabel01", { "Rich.Title" }, "frame_title" ),
		["02"] = Functions.AddWidget( A["02"]["01"], "RichWidget01", "richdragwidget" ),
		["03"] = Functions.AddSpriteButton( A["02"]["01"], "RichSpriteButton01", "utility/close_white", "close_button" ),
		["04"] = Functions.AddPane( A["02"]["02"], "RichPane" ),
		["05"] = Functions.AddFlow( A["02"]["03"], "RichFlow02", "horizontal", "richtabtitleflow" ),
		["06"] = Functions.AddLine( A["02"]["03"], "RichLine01", "horizontal" ),
		["07"] = Functions.AddFlow( A["02"]["03"], "RichFlow03", "horizontal", "richcolorflow" ),
		["08"] = Functions.AddFlow( A["02"]["03"], "RichFlow04", "horizontal", "richcolorflow" ),
		["09"] = Functions.AddFlow( A["02"]["03"], "RichFlow05", "horizontal", "richcolorflow" ),
		["10"] = Functions.AddLine( A["02"]["03"], "RichLine02", "horizontal" ),
		["11"] = Functions.AddFlow( A["02"]["03"], "RichFlow06", "horizontal", "richbuttonflow" )
	}
	A["04"] =
	{
		["01"] = Functions.AddTab( A["03"]["04"], "RichTab01", { "Rich.Tab01" } ), 
		["02"] = Functions.AddTab( A["03"]["04"], "RichTab02", { "Rich.Tab02" } ),
		["03"] = Functions.AddTab( A["03"]["04"], "RichTab03", { "Rich.Tab03" } ),
		["04"] = Functions.AddTab( A["03"]["04"], "RichTab04", { "Rich.Tab04" } ),
		["05"] = Functions.AddTab( A["03"]["04"], "RichTab05", { "Rich.Tab05" } ),
		["06"] = Functions.AddTab( A["03"]["04"], "RichTab06", { "Rich.Tab06" } ),
		["07"] = Functions.AddTab( A["03"]["04"], "RichTab07", { "Rich.Tab07" } ),
		["08"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPane01", "vertical", "richtabscrollpane" ),
		["09"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPane02", "vertical", "richtabscrollpane" ),
		["10"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPane03", "vertical", "richtabscrollpane" ),
		["11"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPane04", "vertical", "richtabscrollpane" ),
		["12"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPane05", "vertical", "richtabscrollpane" ),
		["13"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPane06", "vertical", "richtabscrollpane" ),
		["14"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPane07", "vertical", "richtabscrollpane" ),
		["15"] = Functions.AddLabel( A["03"]["05"], "RichLabel02", { "Rich.TextTitle" }, "caption_label" ),
		["16"] = Functions.AddWidget( A["03"]["05"], "RichWidget02" ),
		["17"] = Functions.AddDropDown( A["03"]["05"], "RichDropDown01", global.SavedRichTexts[player_id].RichTextNames ),
		["18"] = Functions.AddSpriteButton( A["03"]["05"], "RichSpriteButton02", "utility/remove", "close_button" ),
		["19"] = Functions.AddTextField( A["03"]["07"], "RichTextField01", "", "richtextbox" ),
		["20"] = Functions.AddButton( A["03"]["07"], "RichButton01", { "Rich.ClearField" } ),
		["21"] = Functions.AddLabel( A["03"]["08"], "RichLabel03", { "Rich.Output" }, "description_label" ),
		["22"] = Functions.AddLabel( A["03"]["08"], "RichLabel04", "" ),
		["23"] = Functions.AddLabel( A["03"]["09"], "RichLabel05", { "Rich.Name" } ),
		["24"] = Functions.AddTextField( A["03"]["09"], "RichTextField02", "" ),
		["25"] = Functions.AddButton( A["03"]["09"], "RichButton02", { "Rich.AddPreset" } ),
		["26"] = Functions.AddChooseElemButton( A["03"]["11"], "RichChooseElem01", "signal" ),
		["27"] = Functions.AddButton( A["03"]["11"], "RichButton03", { "Rich.CreateTag" } ),
		["28"] = Functions.AddButton( A["03"]["11"], "RichButton04", { "Rich.SendMessage" } ),
		["29"] = Functions.AddButton( A["03"]["11"], "RichButton05", { "Rich.BackerName" } )
	}

	A["01"].location = global.Position[player_id]
	A["02"]["01"].style.vertical_align = "center"
	A["02"]["02"].style.horizontal_align = "center"
	A["03"]["02"].drag_target = A["01"]
	A["03"]["04"].style.height = 350
	A["03"]["04"].add_tab( A["04"]["01"], A["04"]["08"] )
	A["03"]["04"].add_tab( A["04"]["02"], A["04"]["09"] )
	A["03"]["04"].add_tab( A["04"]["03"], A["04"]["10"] )
	A["03"]["04"].add_tab( A["04"]["04"], A["04"]["11"] )
	A["03"]["04"].add_tab( A["04"]["05"], A["04"]["12"] )
	A["03"]["04"].add_tab( A["04"]["06"], A["04"]["13"] )
	--A["03"]["04"].add_tab( A["04"]["07"], A["04"]["14"] )
	A["03"]["05"].style.top_margin = 8
	A["03"]["06"].style.top_margin = 4
	A["03"]["06"].style.bottom_margin = 8
	A["03"]["08"].style.top_margin = 8
	A["03"]["08"].style.bottom_margin = 8
	A["03"]["10"].style.top_margin = 8
	A["03"]["10"].style.bottom_margin = 8
	A["03"]["11"].style.vertical_align = "center"
	A["04"]["08"].horizontal_scroll_policy = "never"
	A["04"]["09"].horizontal_scroll_policy = "never"
	A["04"]["10"].horizontal_scroll_policy = "never"
	A["04"]["11"].horizontal_scroll_policy = "never"
	A["04"]["12"].horizontal_scroll_policy = "never"
	A["04"]["13"].horizontal_scroll_policy = "never"
	A["04"]["14"].horizontal_scroll_policy = "never"
	A["04"]["16"].style.horizontally_stretchable = true
	A["04"]["18"].style.width = 28
	A["04"]["18"].style.height = 28
	A["04"]["22"].style.width = 520
	A["04"]["22"].style.single_line = false
	A["04"]["24"].style.width = 110
	A["04"]["27"].style.horizontally_stretchable = true
	A["04"]["28"].style.horizontally_stretchable = true
	A["04"]["29"].style.horizontally_stretchable = true

	global.GUIS[player_id].A = A

	Functions.Tab01( A["04"]["08"], player_id ) --Types
	Functions.Tab02( A["04"]["09"], player_id ) --Color
	Functions.Tab03( A["04"]["10"], player_id ) --Font
	Functions.Tab04( A["04"]["11"], player_id ) --GPS
	Functions.Tab05( A["04"]["12"], player_id ) --Trains
	Functions.Tab06( A["04"]["13"], player_id ) --Train Stops
end

--MainGUI | Toggle visibility of the GUI
Functions.MainGUIToggle = function( player_id )
	local player = game.players[player_id]
	local screen = player.gui.screen

	if screen.RichFrame01 then
		local GUI = global.GUIS[player_id].A["01"]
		GUI.visible = not GUI.visible
	else
		Functions.MainGUI( screen, player_id )
	end
end

--MainGUI | Add a Preset to the Dropdown
Functions.MainGUIAddPreset = function( player_id, adding_type, name01, text01 )
	local GUI = global.GUIS[player_id].A["04"]
	local SavedRichTexts = global.SavedRichTexts[player_id]
	SavedRichTexts.Number = SavedRichTexts.Number + 1

	if SavedRichTexts.Number < 100 then
		local index_number = Functions.Format2Digit( SavedRichTexts.Number )
		local text = GUI["19"].text
		local name = GUI["24"].text
		GUI["24"].text = ""

		if adding_type == "addcurrent" then
			text = text01
			name = name01
		end

		if name:len() == 0 then
			name = index_number
		end

		SavedRichTexts.RichTexts[index_number] = text
		SavedRichTexts.RichTextNames[index_number] = name

		global.SavedRichTexts[player_id] = SavedRichTexts

		GUI["17"].items = SavedRichTexts.RichTextNames
	else
		game.players[player_id].print( { "Rich.PresetsError100" } )
	end
end

--MainGUI | Update Rich Text and Textfield
Functions.MainGUIUpdateText = function( player_id, text )
	local GUI = global.GUIS[player_id].A["04"]
	GUI["19"].text = text
	GUI["22"].caption = text
end

--Tab01 | Types
Functions.Tab01 = function( parent, player_id )
	local B = {}

	B["01"] =
	{
		["01"] = Functions.AddFlow( parent, "RichFlow07", "horizontal", "richtabtitleflow" ),
		["02"] = Functions.AddLine( parent, "RichLine03", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlow08", "horizontal", "richbuttonflow" ),
		["04"] = Functions.AddFlow( parent, "RichFlow09", "horizontal", "richbuttonflow" )
	}
	B["02"] =
	{
		["01"] = Functions.AddLabel( B["01"]["01"], "RichLabel06", { "Rich.Tab01Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( B["01"]["01"], "RichWidget03" ),
		["03"] = Functions.AddDropDown( B["01"]["01"], "RichDropDown02", Functions.defines.Menus.Tab01.ChooseElemDropDown ),
		["04"] = Functions.AddButton( B["01"]["04"], "RichButton06", { "Rich.AddBefore" } ),
		["05"] = Functions.AddButton( B["01"]["04"], "RichButton07", { "Rich.AddAfter" } )
	}

	B["01"]["02"].style.top_margin = 4
	B["01"]["02"].style.bottom_margin = 8
	B["01"]["02"].visible = false
	B["01"]["03"].style.bottom_margin = 8
	B["01"]["03"].visible = false
	B["01"]["04"].visible = false
	B["02"]["02"].style.horizontally_stretchable = true
	B["02"]["04"].style.horizontally_stretchable = true
	B["02"]["05"].style.horizontally_stretchable = true

	global.GUIS[player_id].B = B
end

--Tab01 | Changing the Type of the ChooseElement based on the Dropdown
Functions.Tab01ChooseElemChange = function( player_id, index )
	local B = global.GUIS[player_id].B

	for i = 2, 4 do
		local number = Functions.Format2Digit( i )
		B["01"][number].visible = true
	end

	if B["03"] then B["03"].destroy() end

	B["03"] = Functions.AddChooseElemButton( B["01"]["03"], "RichChooseElem02", Functions.defines.Menus.Tab01.ChooseElemTypes[Functions.Format2Digit( index )] )

	global.GUIS[player_id].B = B
end

--Tab02 | Color Selection
Functions.Tab02 = function( parent, player_id )
	local C = {}

	C["01"] =
	{
		["01"] = Functions.AddFlow( parent, "RichFlow10", "horizontal", "richtabtitleflow" ),
		["02"] = Functions.AddLine( parent, "RichLine04", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlow11", "horizontal", "richcolorflow" ),
		["04"] = Functions.AddFlow( parent, "RichFlow12", "horizontal", "richcolorflow" ),
		["05"] = Functions.AddFlow( parent, "RichFlow13", "horizontal", "richcolorflow" ),
		["06"] = Functions.AddFlow( parent, "RichFlow14", "horizontal", "richcolorflow" ),
		["07"] = Functions.AddFlow( parent, "RichFlow15", "horizontal", "richcolorflow" ),
		["08"] = Functions.AddFlow( parent, "RichFlow16", "horizontal", "richcolorflow" ),
		["09"] = Functions.AddLine( parent, "RichLine05", "horizontal" ),
		["10"] = Functions.AddFlow( parent, "RichFlow17", "horizontal", "richbuttonflow" )
	}
	C["02"] =
	{
		["01"] = Functions.AddLabel( C["01"]["01"], "RichLabel07", { "Rich.Tab02Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( C["01"]["01"], "RichWidget04" ),
		["03"] = Functions.AddDropDown( C["01"]["01"], "RichDropDown03", Functions.defines.Menus.Tab02.ColorDropDown ),
		["04"] = Functions.AddLabel( C["01"]["01"], "RichHiddenLabel01", "#000000" ),
		["05"] = Functions.AddLabel( C["01"]["03"], "RichLabel08", "R" ),
		["06"] = Functions.AddSlider( C["01"]["03"], "RichSlider01", 0, 255, 0, "red_slider" ),
		["07"] = Functions.AddTextField( C["01"]["03"], "RichTextField03", "0" ),
		["08"] = Functions.AddLabel( C["01"]["04"], "RichLabel09", "G" ),
		["09"] = Functions.AddSlider( C["01"]["04"], "RichSlider02", 0, 255, 0, "green_slider" ),
		["10"] = Functions.AddTextField( C["01"]["04"], "RichTextField04", "0" ),
		["11"] = Functions.AddLabel( C["01"]["05"], "RichLabel10", "B" ),
		["12"] = Functions.AddSlider( C["01"]["05"], "RichSlider03", 0, 255, 0, "blue_slider" ),
		["13"] = Functions.AddTextField( C["01"]["05"], "RichTextField05", "0" ),
		["14"] = Functions.AddTextField( C["01"]["06"], "RichTextField06", "#000000" ),
		["15"] = Functions.AddWidget( C["01"]["06"], "RichWidget05" ),
		["16"] = Functions.AddLabel( C["01"]["06"], "RichLabel11", "A" ),
		["17"] = Functions.AddLabel( C["01"]["07"], "RichLabel12", { "Rich.Name" } ),
		["18"] = Functions.AddTextField( C["01"]["07"], "RichTextField07", "" ),
		["19"] = Functions.AddButton( C["01"]["07"], "RichButton08", { "Rich.AddPreset" } ),
		["20"] = Functions.AddTable( C["01"]["08"], "RichTable", 11 ),
		["21"] = Functions.AddButton( C["01"]["10"], "RichButton09", { "Rich.AddBefore" } ),
		["22"] = Functions.AddButton( C["01"]["10"], "RichButton10", { "Rich.AddAfter" } ),
		["23"] = Functions.AddButton( C["01"]["10"], "RichButton11", { "Rich.Applyto" } )
	}
	C["03"] = {}

	C["01"]["02"].style.top_margin = 4
	C["01"]["02"].style.bottom_margin = 8
	C["01"]["09"].style.top_margin = 4
	C["01"]["09"].style.bottom_margin = 8
	C["02"]["02"].style.horizontally_stretchable = true
	C["02"]["04"].visible = false
	C["02"]["07"].style.width = 40
	C["02"]["07"].numeric = true
	C["02"]["10"].style.width = 40
	C["02"]["10"].numeric = true
	C["02"]["13"].style.width = 40
	C["02"]["13"].numeric = true
	C["02"]["14"].style.width = 70
	C["02"]["15"].style.width = 110
	C["02"]["16"].style.font = "RichResult"
	C["02"]["16"].style.font_color = { r = 0, g = 0, b = 0 }
	C["02"]["18"].style.width = 110
	C["02"]["21"].style.horizontally_stretchable = true
	C["02"]["22"].style.horizontally_stretchable = true
	C["02"]["23"].style.horizontally_stretchable = true

	global.GUIS[player_id].C = C
end

--Tab02 | Changing Color and HEX Value based on Dropdown, Sliders, HEX Value or RGB Color
Functions.Tab02ColorUpdate = function( player_id, element_type, index_number )
	local C = global.GUIS[player_id].C["02"]
	local color = Functions.HEXtoColor( C["04"].caption )

	if element_type == "drop-down" then
		color = Functions.defines.Menus.Tab02.ColorDropDownRGB[Functions.Format2Digit( C["03"].selected_index )]
	elseif element_type == "" then
	else
		C["03"].selected_index = 0

		if element_type == "rgb" then
			color = { r = C["07"].text, g = C["10"].text, b = C["13"].text }
		elseif element_type == "hex" then
			color = Functions.HEXtoColor( C["14"].text )
		elseif element_type == "slider" then
			color = { r = C["06"].slider_value, g = C["09"].slider_value, b = C["12"].slider_value }
		elseif element_type == "preset" then
			color = global.SavedColors[player_id].Colors[index_number]
		end
	end

	local HEX = Functions.ColortoHEX( color )

	C["04"].caption = HEX
	C["06"].slider_value = color.r
	C["07"].text = color.r
	C["09"].slider_value = color.g
	C["10"].text = color.g
	C["12"].slider_value = color.b
	C["13"].text = color.b
	C["14"].text = HEX
	C["16"].style.font_color = color
end

--Tab02 | Adding the current Color as a Preset for later use
Functions.Tab02AddPreset = function( player_id, adding_type, tooltip01, color01 )
	local C = global.GUIS[player_id].C
	local SavedColors = global.SavedColors[player_id]
	SavedColors.Number = SavedColors.Number + 1

	if SavedColors.Number < 100 then
		local index_number = Functions.Format2Digit( SavedColors.Number )
		local color = Functions.HEXtoColor( C["02"]["04"].caption )
		local tooltip = C["02"]["18"].text

		C["02"]["18"].text = ""
	
		C["03"][index_number] = Functions.AddButton( C["02"]["20"], "RichPresetButton" .. index_number, "B", "richpresetbutton" )
	
		if adding_type == "addcurrent" then
			color = color01
			tooltip = tooltip01
		end
	
		C["03"][index_number].style.font_color = color
		C["03"][index_number].style.hovered_font_color = color
		C["03"][index_number].style.clicked_font_color = color
		C["03"][index_number].style.disabled_font_color = color
	
		if tooltip:len() > 0 then
			C["03"][index_number].tooltip = tooltip
		end
	
		SavedColors.Colors[index_number] = color
		SavedColors.ColorNames[index_number] = tooltip
	
		global.SavedColors[player_id] = SavedColors
	else
		game.players[player_id].print( { "Rich.PresetsError100" } )
	end
end

--Tab03 | Font Selection
Functions.Tab03 = function( parent, player_id )
	local D = {}

	D["01"] =
	{
		["01"] = Functions.AddFlow( parent, "RichFlow18", "horizontal", "richtabtitleflow" ),
		["02"] = Functions.AddLine( parent, "RichLine06", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlow19", "horizontal", "richbuttonflow" )
	}
	D["02"] =
	{
		["01"] = Functions.AddLabel( D["01"]["01"], "RichLabel13", { "Rich.Tab03Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( D["01"]["01"], "RichWidget06" ),
		["03"] = Functions.AddDropDown( D["01"]["01"], "RichDropDown04", Functions.defines.Menus.Tab03.FontDropDown ),
		["04"] = Functions.AddButton( D["01"]["03"], "RichButton12", { "Rich.AddBefore" } ),
		["05"] = Functions.AddButton( D["01"]["03"], "RichButton13", { "Rich.AddAfter" } ),
		["06"] = Functions.AddButton( D["01"]["03"], "RichButton14", { "Rich.Applyto" } )
	}

	D["01"]["02"].style.top_margin = 4
	D["01"]["02"].style.bottom_margin = 8
	D["02"]["02"].style.horizontally_stretchable = true
	D["02"]["04"].style.horizontally_stretchable = true
	D["02"]["05"].style.horizontally_stretchable = true
	D["02"]["06"].style.horizontally_stretchable = true

	global.GUIS[player_id].D = D
end

--Tab04 | GPS
Functions.Tab04 = function( parent, player_id )
	local E = {}

	E["01"] =
	{
		["01"] = Functions.AddFlow( parent, "RichFlow20", "horizontal", "richtabtitleflow" ),
		["02"] = Functions.AddLine( parent, "RichLine07", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlow21", "horizontal", "richcolorflow" ),
		["04"] = Functions.AddLine( parent, "RichLine08", "horizontal" ),
		["05"] = Functions.AddFlow( parent, "RichFlow22", "horizontal", "richbuttonflow" )
	}
	E["02"] =
	{
		["01"] = Functions.AddLabel( E["01"]["01"], "RichLabel14", { "Rich.Tab04Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( E["01"]["01"], "RichWidget07" ),
		["03"] = Functions.AddDropDown( E["01"]["01"], "RichDropDown05", global.SavedGPS[player_id].PositionNames ),
		["04"] = Functions.AddSpriteButton( E["01"]["01"], "RichSpriteButton03", "utility/remove", "close_button" ),
		["05"] = Functions.AddLabel( E["01"]["03"], "RichLabel15", { "Rich.Name" } ),
		["06"] = Functions.AddTextField( E["01"]["03"], "RichTextField08", "" ),
		["07"] = Functions.AddButton( E["01"]["03"], "RichButton15", { "Rich.AddPreset" } ),
		["08"] = Functions.AddButton( E["01"]["05"], "RichButton16", { "Rich.AddBefore" } ),
		["09"] = Functions.AddButton( E["01"]["05"], "RichButton17", { "Rich.AddAfter" } ),
	}

	E["01"]["02"].style.top_margin = 4
	E["01"]["02"].style.bottom_margin = 8
	E["01"]["04"].style.top_margin = 8
	E["01"]["04"].style.bottom_margin = 8
	E["02"]["02"].style.horizontally_stretchable = true
	E["02"]["04"].style.width = 28
	E["02"]["04"].style.height = 28
	E["02"]["06"].style.width = 110
	E["02"]["07"].tooltip = { "Rich.CurrentCoords" }
	E["02"]["08"].style.horizontally_stretchable = true
	E["02"]["09"].style.horizontally_stretchable = true

	global.GUIS[player_id].E = E
end

--Tab04 | Add a Preset to the Dropdown
Functions.Tab04AddPreset = function( player_id, adding_type, name01, coordinates01 )
	local GUI = global.GUIS[player_id].E["02"]
	local SavedGPS = global.SavedGPS[player_id]
	SavedGPS.Number = SavedGPS.Number + 1

	if SavedGPS.Number < 100 then
		local index_number = Functions.Format2Digit( SavedGPS.Number )
		local coordinates = game.players[player_id].position
		local name = GUI["06"].text
		GUI["06"].text = ""

		if adding_type == "addcurrent" then
			coordinates = coordinates01
			name = name01
		end

		if name:len() == 0 then
			name = index_number
		end

		SavedGPS.Positions[index_number] = coordinates
		SavedGPS.PositionNames[index_number] = name

		global.SavedGPS[player_id] = SavedGPS

		GUI["03"].items = SavedGPS.PositionNames
	else
		game.players[player_id].print( { "Rich.PresetsError100" } )
	end
end

--Tab05 | Trains
Functions.Tab05 = function( parent, player_id )
	local F = {}

	F["01"] =
	{
		["01"] = Functions.AddFlow( parent, "RichFlow23", "horizontal", "richtitlebarflow" ),
		["02"] = Functions.AddLine( parent, "RichLine09", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlow24", "horizontal", "richbuttonflow" )
	}
	F["02"] =
	{
		["01"] = Functions.AddLabel( F["01"]["01"], "RichLabel16", { "Rich.Tab05Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( F["01"]["01"], "RichWidget08" ),
		["03"] = Functions.AddDropDown( F["01"]["01"], "RichDropDown06", {} ),
		["04"] = Functions.AddSpriteButton( F["01"]["01"], "RichSpriteButton04", "utility/refresh", "close_button" ),
		["05"] = Functions.AddButton( F["01"]["03"], "RichButton18", { "Rich.AddBefore" } ),
		["06"] = Functions.AddButton( F["01"]["03"], "RichButton19", { "Rich.AddAfter" } )
	}

	F["01"]["02"].style.top_margin = 4
	F["01"]["02"].style.bottom_margin = 8
	F["02"]["02"].style.horizontally_stretchable = true
	F["02"]["04"].style.width = 28
	F["02"]["04"].style.height = 28
	F["02"]["05"].style.horizontally_stretchable = true
	F["02"]["06"].style.horizontally_stretchable = true

	global.GUIS[player_id].F = F

	Functions.Tab05Update( player_id )
end

--Tab05 | Update DropDown
Functions.Tab05Update = function( player_id )
	local player = game.players[player_id]
	local force = player.force
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
						SavedTrains.Number = SavedTrains.Number + 1
						if SavedTrains.Number < 1000 then
							index_number = Functions.Format3Digit( SavedTrains.Number )
							SavedTrains.UnitNumbers[index_number] = locomotive.unit_number
							SavedTrains.BackerNames[index_number] = locomotive.backer_name
						else
							player.print( { "Rich.PresetsError1000" } )
							return
						end
					end
				end

				if next( locomotives.front_movers ) then
					for _, locomotive in pairs( locomotives.front_movers ) do
						SavedTrains.Number = SavedTrains.Number + 1
						if SavedTrains.Number < 1000 then
							index_number = Functions.Format3Digit( SavedTrains.Number )
							SavedTrains.UnitNumbers[index_number] = locomotive.unit_number
							SavedTrains.BackerNames[index_number] = locomotive.backer_name
						else
							player.print( { "Rich.PresetsError1000" } )
							return
						end
					end
				end
			end
		end
	end

	global.GUIS[player_id].F["02"]["03"].items = SavedTrains.BackerNames
	global.SavedTrains[player_id] = SavedTrains
end

--Tab06 | Train Stops
Functions.Tab06 = function( parent, player_id )
	local G = {}

	G["01"] =
	{
		["01"] = Functions.AddFlow( parent, "RichFlow25", "horizontal", "richtitlebarflow" ),
		["02"] = Functions.AddLine( parent, "RichLine10", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlow26", "horizontal", "richbuttonflow" )
	}
	G["02"] =
	{
		["01"] = Functions.AddLabel( G["01"]["01"], "RichLabel17", { "Rich.Tab06Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( G["01"]["01"], "RichWidget09" ),
		["03"] = Functions.AddDropDown( G["01"]["01"], "RichDropDown07", {} ),
		["04"] = Functions.AddSpriteButton( G["01"]["01"], "RichSpriteButton05", "utility/refresh", "close_button" ),
		["05"] = Functions.AddButton( G["01"]["03"], "RichButton20", { "Rich.AddBefore" } ),
		["06"] = Functions.AddButton( G["01"]["03"], "RichButton21", { "Rich.AddAfter" } )
	}

	G["01"]["02"].style.top_margin = 4
	G["01"]["02"].style.bottom_margin = 8
	G["02"]["02"].style.horizontally_stretchable = true
	G["02"]["04"].style.width = 28
	G["02"]["04"].style.height = 28
	G["02"]["05"].style.horizontally_stretchable = true
	G["02"]["06"].style.horizontally_stretchable = true

	global.GUIS[player_id].G = G

	Functions.Tab06Update( player_id )
end

--Tab06 | Update DropDown
Functions.Tab06Update = function( player_id )
	local player = game.players[player_id]
	local force = player.force
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
				SavedTrainStops.Number = SavedTrainStops.Number + 1
				if SavedTrainStops.Number < 1000 then
					index_number = Functions.Format3Digit( SavedTrainStops.Number )
					SavedTrainStops.UnitNumbers[index_number] = trainstop.unit_number
					SavedTrainStops.BackerNames[index_number] = trainstop.backer_name
				else
					player.print( { "Rich.PresetsError1000" } )
					return
				end
			end
		end
	end

	global.GUIS[player_id].G["02"]["03"].items = SavedTrainStops.BackerNames
	global.SavedTrainStops[player_id] = SavedTrainStops
end

--Player Data creation
Functions.PlayerStart = function( player_id )
	local player = game.players[player_id]
	local button_flow = mod_gui.get_button_flow( player )
	if not button_flow.RichButton then
		local b = Functions.AddSpriteButton( button_flow, "RichButton", "utility/rename_icon_normal" )
	end
	global.Position[player_id] = global.Position[player_id] or { x = 5, y = 85 * player.display_scale }
	global.GUIS[player_id] = global.GUIS[player_id] or {}
	global.SavedRichTexts[player_id] = global.SavedRichTexts[player_id] or
	{
		Number = 0,
		RichTexts = {},
		RichTextNames = {}
	}
	global.SavedColors[player_id] = global.SavedColors[player_id] or
	{
		Number = 0,
		Colors = {},
		ColorNames = {}
	}
	global.SavedGPS[player_id] = global.SavedGPS[player_id] or
	{
		Number = 0,
		Positions = {},
		PositionNames = {}
	}
	global.SavedTrains[player_id] = global.SavedTrains[player_id] or
	{
		Number = 0,
		UnitNumbers = {},
		BackerNames = {}
	}
	global.SavedTrainStops[player_id] = global.SavedTrainStops[player_id] or
	{
		Number = 0,
		UnitNumbers = {},
		BackerNames = {}
	}
end

--Formation every Number to a 2long Number
Functions.Format2Digit = function( number )
	return string.format( "%02d", number )
end

--Formation every Number to a 3long Number
Functions.Format3Digit = function( number )
	return string.format( "%03d", number )
end

--Converting Colors to a 6long HEX Code with a # in front
Functions.ColortoHEX = function( color )
	return string.format( "#%.2X%.2X%.2X", color.r, color.g, color.b )
end

--Converting a HEX Code to a RGB Color Table
Functions.HEXtoColor = function( HEX )
	HEX = HEX:gsub( "#", "" )
	return { r = tonumber( "0x" .. HEX:sub( 1, 2 ) ), g = tonumber( "0x" .. HEX:sub( 3, 4 ) ), b = tonumber( "0x" .. HEX:sub( 5, 6 ) ) }
end

--GUI Element Functions
Functions.AddButton = function( parent, name, caption, style )
	return parent.add{ type = "button", name = name, caption = caption, style = style }
end

Functions.AddChooseElemButton = function( parent, name, elem_type )
	return parent.add{ type = "choose-elem-button", name = name, elem_type = elem_type }
end

Functions.AddDropDown = function( parent, name, items )
	return parent.add{ type = "drop-down", name = name, items = items }
end

Functions.AddFlow = function( parent, name, direction, style )
	return parent.add{ type = "flow", name = name, direction = direction, style = style }
end

Functions.AddFrame = function( parent, name, style )
	return parent.add{ type = "frame", name = name, direction = "vertical", style = style }
end

Functions.AddLabel = function( parent, name, caption, style )
	return parent.add{ type = "label", name = name, caption = caption, style = style }
end

Functions.AddLine = function( parent, name, direction )
	return parent.add{ type = "line", name = name, direction = direction }
end

Functions.AddPane = function( parent, name )
	return parent.add{ type = "tabbed-pane", name = name }
end

Functions.AddScrollPane = function( parent, name, direction, style )
	return parent.add{ type = "scroll-pane", name = name, direction = direction, style = style }
end

Functions.AddSlider = function( parent, name, minimum_value, maximum_value, value, style )
	return parent.add{ type = "slider", name = name, minimum_value = minimum_value, maximum_value = maximum_value, value = value, style = style }
end

Functions.AddSpriteButton = function( parent, name, sprite, style )
	return parent.add{ type = "sprite-button", name = name, sprite = sprite, style = style }
end

Functions.AddTab = function( parent, name, caption )
	return parent.add{ type = "tab", name = name, caption = caption }
end

Functions.AddTable = function( parent, name, column_count )
	return parent.add{ type = "table", name = name, column_count = column_count }
end

Functions.AddTextField = function( parent, name, text, style )
	return parent.add{ type = "textfield", name = name, text = text, style = style }
end

Functions.AddWidget = function( parent, name, style )
	return parent.add{ type = "empty-widget", name = name, style = style }
end

return Functions
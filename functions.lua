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
	global.CurrentRichText = global.CurrentRichText or {}
	global.CurrentHEX = global.CurrentHEX or {}
	global.CurrentPosition = global.CurrentPosition or {}
	global.Reset = global.Reset or {}
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

	A["01"] = Functions.AddFrame( parent, "RichFrameAGUI01", "dialog_frame" )
	A["02"] =
	{
		["01"] = Functions.AddFlow( A["01"], "RichFlowAGUI01", "horizontal", "richtitlebarflow" ),
		["02"] = Functions.AddFrame( A["01"], "RichFrameAGUI02", "inside_deep_frame_for_tabs" ),
		["03"] = Functions.AddFrame( A["01"], "RichHiddenFrameAGUI01", "outer_frame_without_shadow" )
	}
	A["03"] =
	{
		["01"] = Functions.AddLabel( A["02"]["01"], "RichLabelAGUI01", { "Rich.Title" }, "frame_title" ),
		["02"] = Functions.AddWidget( A["02"]["01"], "RichWidgetAGUI01", "richdragwidget" ),
		["03"] = Functions.AddSpriteButton( A["02"]["01"], "RichSpriteButtonAGUI01", "utility/close_white", "close_button" ),
		["04"] = Functions.AddPane( A["02"]["02"], "RichPaneAGUI01" ),

		["05"] = Functions.AddFlow( A["02"]["03"], "RichFlowAGUI02", "horizontal", "richtabtitleflow" ),
		["06"] = Functions.AddLine( A["02"]["03"], "RichLineAGUI01", "horizontal" ),

		["07"] = Functions.AddFlow( A["02"]["03"], "RichFlowAGUI03", "horizontal", "richcolorflow" ),
		["08"] = Functions.AddLine( A["02"]["03"], "RichLineAGUI02", "horizontal" ),

		["09"] = Functions.AddFlow( A["02"]["03"], "RichFlowAGUI04", "horizontal", "richbuttonflow" ),
		["10"] = Functions.AddLine( A["02"]["03"], "RichLineAGUI03", "horizontal" ),

		["11"] = Functions.AddFlow( A["02"]["03"], "RichFlowAGUI05", "horizontal", "richcolorflow" ),
		["12"] = Functions.AddFlow( A["02"]["03"], "RichFlowAGUI06", "horizontal", "richcolorflow" ),
		["13"] = Functions.AddFlow( A["02"]["03"], "RichFlowAGUI07", "horizontal", "richcolorflow" ),
		["14"] = Functions.AddLine( A["02"]["03"], "RichLineAGUI04", "horizontal" ),

		["15"] = Functions.AddFlow( A["02"]["03"], "RichFlowAGUI08", "horizontal", "richbuttonflow" )
	}
	A["04"] =
	{
		["01"] = Functions.AddTab( A["03"]["04"], "RichTabAGUI02", { "Rich.Tab01" } ), 
		["02"] = Functions.AddTab( A["03"]["04"], "RichTabAGUI03", { "Rich.Tab02" } ),
		["03"] = Functions.AddTab( A["03"]["04"], "RichTabAGUI04", { "Rich.Tab03" } ),
		["04"] = Functions.AddTab( A["03"]["04"], "RichTabAGUI05", { "Rich.Tab04" } ),
		["05"] = Functions.AddTab( A["03"]["04"], "RichTabAGUI06", { "Rich.Tab05" } ),
		["06"] = Functions.AddTab( A["03"]["04"], "RichTabAGUI07", { "Rich.Tab06" } ),
		["07"] = Functions.AddTab( A["03"]["04"], "RichTabAGUI08", { "Rich.Tab07" } ),
		["08"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI01", "vertical", "richtabscrollpane" ),
		["09"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI02", "vertical", "richtabscrollpane" ),
		["10"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI03", "vertical", "richtabscrollpane" ),
		["11"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI04", "vertical", "richtabscrollpane" ),
		["12"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI05", "vertical", "richtabscrollpane" ),
		["13"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI06", "vertical", "richtabscrollpane" ),
		["14"] = Functions.AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI07", "vertical", "richtabscrollpane" ),

		["15"] = Functions.AddLabel( A["03"]["05"], "RichLabelAGUI02", { "Rich.TextTitle" }, "caption_label" ),
		["16"] = Functions.AddWidget( A["03"]["05"], "RichWidgetAGUI02" ),
		["17"] = Functions.AddDropDown( A["03"]["05"], "RichDropDownAGUI01", global.SavedRichTexts[player_id].RichTextNames ),
		["18"] = Functions.AddSpriteButton( A["03"]["05"], "RichSpriteButtonAGUI02", "utility/remove", "close_button" ),

		["19"] = Functions.AddLabel( A["03"]["07"], "RichLabelAGUI03", { "Rich.DropdownSelection" }, "description_label" ),
		["20"] = Functions.AddLabel( A["03"]["07"], "RichLabelAGUI04", "" ),

		["21"] = Functions.AddButton( A["03"]["09"], "RichButtonAGUI01", { "Rich.AddBefore" } ),
		["22"] = Functions.AddButton( A["03"]["09"], "RichButtonAGUI02", { "Rich.AddAfter" } ),
		["23"] = Functions.AddButton( A["03"]["09"], "RichButtonAGUI03", { "Rich.SetCurrent" } ),

		["24"] = Functions.AddTextField( A["03"]["11"], "RichTextFieldAGUI01", global.CurrentRichText[player_id], "richtextbox" ),
		["25"] = Functions.AddButton( A["03"]["11"], "RichButtonAGUI04", { "Rich.ClearField" } ),

		["26"] = Functions.AddLabel( A["03"]["12"], "RichLabelAGUI05", { "Rich.Output" }, "description_label" ),
		["27"] = Functions.AddLabel( A["03"]["12"], "RichLabelAGUI06", global.CurrentRichText[player_id] ),

		["28"] = Functions.AddLabel( A["03"]["13"], "RichLabelAGUI07", { "Rich.Name" } ),
		["29"] = Functions.AddTextField( A["03"]["13"], "RichTextFieldAGUI02", "" ),
		["30"] = Functions.AddButton( A["03"]["13"], "RichButtonAGUI05", { "Rich.AddPreset" } ),

		["31"] = Functions.AddChooseElemButton( A["03"]["15"], "RichChooseElemAGUI01", "signal" ),
		["32"] = Functions.AddButton( A["03"]["15"], "RichButtonAGUI06", { "Rich.CreateTag" } ),
		["33"] = Functions.AddButton( A["03"]["15"], "RichButtonAGUI07", { "Rich.SendMessage" } ),
		["34"] = Functions.AddButton( A["03"]["15"], "RichButtonAGUI08", { "Rich.BackerName" } )
	}

	A["01"].location = global.Position[player_id]
	A["01"].style.vertical_align = "center"

	A["02"]["01"].style.vertical_align = "center"
	A["02"]["02"].style.horizontal_align = "center"

	A["03"]["02"].drag_target = A["01"]
	A["03"]["04"].style.height = 400
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
	A["03"]["12"].style.top_margin = 8
	A["03"]["12"].style.bottom_margin = 8
	A["03"]["14"].style.top_margin = 8
	A["03"]["14"].style.bottom_margin = 8
	A["03"]["15"].style.vertical_align = "center"
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
	A["04"]["20"].style.width = 400
	A["04"]["20"].style.single_line = false
	A["04"]["21"].style.horizontally_stretchable = true
	A["04"]["22"].style.horizontally_stretchable = true
	A["04"]["23"].style.horizontally_stretchable = true
	A["04"]["27"].style.width = 420
	A["04"]["27"].style.single_line = false
	A["04"]["29"].style.width = 110
	A["04"]["32"].style.horizontally_stretchable = true
	A["04"]["33"].style.horizontally_stretchable = true
	A["04"]["34"].style.horizontally_stretchable = true

	global.GUIS[player_id].A = A

	Functions.MainGUIDropDownToggle( player_id )

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

	if screen.RichFrameAGUI01 then
		local GUI = global.GUIS[player_id].A["01"]
		GUI.visible = not GUI.visible
	else
		Functions.MainGUI( screen, player_id )

		if global.Reset[player_id] then
			global.Reset[player_id] = false
			local SavedColors = global.SavedColors[player_id]

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
		end
	end
end

--MainGUI | Toggle visibilty of the Buttons and Label for the Dropdown
Functions.MainGUIDropDownToggle = function( player_id )
	local GUI = global.GUIS[player_id].A["03"]
	GUI["07"].visible = not GUI["07"].visible
	GUI["08"].visible = not GUI["08"].visible
	GUI["09"].visible = not GUI["09"].visible
	GUI["10"].visible = not GUI["10"].visible
end

--MainGUI | Add a Preset to the Dropdown
Functions.MainGUIAddPreset = function( player_id, adding_type, name01, text01 )
	local GUI = global.GUIS[player_id].A["04"]
	local SavedRichTexts = global.SavedRichTexts[player_id]
	SavedRichTexts.Number = SavedRichTexts.Number + 1

	if SavedRichTexts.Number < 100 then
		local index_number = Functions.Format2Digit( SavedRichTexts.Number )
		local text = GUI["24"].text
		local name = GUI["29"].text
		GUI["29"].text = ""

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
	GUI["24"].text = text
	GUI["27"].caption = text
	global.CurrentRichText[player_id] = text
end

--Tab01 | Types
Functions.Tab01 = function( parent, player_id )
	local B = {}

	B["01"] =
	{
		["01"] = Functions.AddFlow( parent, "RichFlowBGUI01", "horizontal", "richtabtitleflow" ),
		["02"] = Functions.AddLine( parent, "RichLineBGUI01", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlowBBGUI02", "horizontal", "richbuttonflow" ),
		["04"] = Functions.AddFlow( parent, "RichFlowBGUI03", "horizontal", "richbuttonflow" )
	}
	B["02"] =
	{
		["01"] = Functions.AddLabel( B["01"]["01"], "RichLabelBGUI01", { "Rich.Tab01Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( B["01"]["01"], "RichWidgetBGUI01" ),
		["03"] = Functions.AddDropDown( B["01"]["01"], "RichDropDownBGUI01", Functions.defines.Menus.Tab01.ChooseElemDropDown ),
		["04"] = Functions.AddButton( B["01"]["04"], "RichButtonBGUI01", { "Rich.AddBefore" } ),
		["05"] = Functions.AddButton( B["01"]["04"], "RichButtonBGUI02", { "Rich.AddAfter" } )
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

	B["03"] = Functions.AddChooseElemButton( B["01"]["03"], "RichChooseElemBGUI01", Functions.defines.Menus.Tab01.ChooseElemTypes[Functions.Format2Digit( index )] )

	global.GUIS[player_id].B = B
end

--Tab02 | Color Selection
Functions.Tab02 = function( parent, player_id )
	local C = {}

	C["01"] =
	{
		["01"] = Functions.AddFlow( parent, "RichFlowCGUI01", "horizontal", "richtabtitleflow" ),
		["02"] = Functions.AddLine( parent, "RichLineCGUI01", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlowCGUI02", "horizontal", "richcolorflow" ),
		["04"] = Functions.AddFlow( parent, "RichFlowCGUI03", "horizontal", "richcolorflow" ),
		["05"] = Functions.AddFlow( parent, "RichFlowCGUI04", "horizontal", "richcolorflow" ),
		["06"] = Functions.AddFlow( parent, "RichFlowCGUI05", "horizontal", "richcolorflow" ),
		["07"] = Functions.AddFlow( parent, "RichFlowCGUI06", "horizontal", "richcolorflow" ),
		["08"] = Functions.AddFlow( parent, "RichFlowCGUI07", "horizontal", "richcolorflow" ),
		["09"] = Functions.AddLine( parent, "RichLineCGUI02", "horizontal" ),
		["10"] = Functions.AddFlow( parent, "RichFlowCGUI08", "horizontal", "richbuttonflow" )
	}
	C["02"] =
	{
		["01"] = Functions.AddLabel( C["01"]["01"], "RichLabelCGUI01", { "Rich.Tab02Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( C["01"]["01"], "RichWidgetCGUI01" ),
		["03"] = Functions.AddDropDown( C["01"]["01"], "RichDropDownCGUI01", Functions.defines.Menus.Tab02.ColorDropDown ),
		["04"] = Functions.AddLabel( C["01"]["01"], "RichHiddenLabelCGUI01", global.CurrentHEX[player_id] ),
		["05"] = Functions.AddLabel( C["01"]["03"], "RichLabelCGUI02", "R" ),
		["06"] = Functions.AddSlider( C["01"]["03"], "RichSliderCGUI01", 0, 255, 0, "red_slider" ),
		["07"] = Functions.AddTextField( C["01"]["03"], "RichTextFieldCGUI01", "" ),
		["08"] = Functions.AddLabel( C["01"]["04"], "RichLabelCGUI03", "G" ),
		["09"] = Functions.AddSlider( C["01"]["04"], "RichSliderCGUI02", 0, 255, 0, "green_slider" ),
		["10"] = Functions.AddTextField( C["01"]["04"], "RichTextFieldCGUI02", "" ),
		["11"] = Functions.AddLabel( C["01"]["05"], "RichLabelCGUI04", "B" ),
		["12"] = Functions.AddSlider( C["01"]["05"], "RichSliderCGUI03", 0, 255, 0, "blue_slider" ),
		["13"] = Functions.AddTextField( C["01"]["05"], "RichTextFieldCGUI03", "" ),
		["14"] = Functions.AddTextField( C["01"]["06"], "RichTextFieldCGUI04", "" ),
		["15"] = Functions.AddWidget( C["01"]["06"], "RichWidgetCGUI02" ),
		["16"] = Functions.AddLabel( C["01"]["06"], "RichLabelCGUI05", "A" ),
		["17"] = Functions.AddLabel( C["01"]["07"], "RichLabelCGUI06", { "Rich.Name" } ),
		["18"] = Functions.AddTextField( C["01"]["07"], "RichTextFieldCGUI05", "" ),
		["19"] = Functions.AddButton( C["01"]["07"], "RichButtonCGUI01", { "Rich.AddPreset" } ),
		["20"] = Functions.AddTable( C["01"]["08"], "RichTableCGUI01", 11 ),
		["21"] = Functions.AddButton( C["01"]["10"], "RichButtonCGUI02", { "Rich.AddBefore" } ),
		["22"] = Functions.AddButton( C["01"]["10"], "RichButtonCGUI03", { "Rich.AddAfter" } ),
		["23"] = Functions.AddButton( C["01"]["10"], "RichButtonCGUI04", { "Rich.Applyto" } )
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
	C["02"]["18"].style.width = 110
	C["02"]["21"].style.horizontally_stretchable = true
	C["02"]["22"].style.horizontally_stretchable = true
	C["02"]["23"].style.horizontally_stretchable = true

	global.GUIS[player_id].C = C

	Functions.Tab02ColorUpdate( player_id, "" )
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

	global.CurrentHEX[player_id] = HEX
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
	
		C["03"][index_number] = Functions.AddButton( C["02"]["20"], "RichPresetButtonCGUI" .. index_number, "B", "richpresetbutton" )
	
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
		["01"] = Functions.AddFlow( parent, "RichFlowDGUI01", "horizontal", "richtabtitleflow" ),
		["02"] = Functions.AddLine( parent, "RichLineDGUI01", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlowDGUI02", "horizontal", "richbuttonflow" )
	}
	D["02"] =
	{
		["01"] = Functions.AddLabel( D["01"]["01"], "RichLabelDGUI01", { "Rich.Tab03Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( D["01"]["01"], "RichWidgetDGUI01" ),
		["03"] = Functions.AddDropDown( D["01"]["01"], "RichDropDownDGUI01", Functions.defines.Menus.Tab03.FontDropDown ),
		["04"] = Functions.AddButton( D["01"]["03"], "RichButtonDGUI01", { "Rich.AddBefore" } ),
		["05"] = Functions.AddButton( D["01"]["03"], "RichButtonDGUI02", { "Rich.AddAfter" } ),
		["06"] = Functions.AddButton( D["01"]["03"], "RichButtonDGUI03", { "Rich.Applyto" } )
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
		["01"] = Functions.AddFlow( parent, "RichFlowEGUI01", "horizontal", "richtabtitleflow" ),
		["02"] = Functions.AddLine( parent, "RichLineEGUI01", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlowEGUI02", "horizontal", "richcolorflow" ),
		["04"] = Functions.AddLine( parent, "RichLineEGUI02", "horizontal" ),
		["05"] = Functions.AddFlow( parent, "RichFlowEGUI03", "horizontal", "richcolorflow" ),
		["06"] = Functions.AddLine( parent, "RichLineEGUI03", "horizontal" ),
		["07"] = Functions.AddFlow( parent, "RichFlowEGUI04", "horizontal", "richbuttonflow" )
	}
	E["02"] =
	{
		["01"] = Functions.AddLabel( E["01"]["01"], "RichLabelEGUI01", { "Rich.Tab04Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( E["01"]["01"], "RichWidgetEGUI01" ),
		["03"] = Functions.AddDropDown( E["01"]["01"], "RichDropDownEGUI01", global.SavedGPS[player_id].PositionNames ),
		["04"] = Functions.AddSpriteButton( E["01"]["01"], "RichSpriteButtonEGUI01", "utility/remove", "close_button" ),
		["05"] = Functions.AddLabel( E["01"]["03"], "RichLabelEGUI02", { "Rich.DropdownSelection" }, "description_label" ),
		["06"] = Functions.AddLabel( E["01"]["03"], "RichLabelEGUI03", "" ),
		["07"] = Functions.AddLabel( E["01"]["03"], "RichLabelEGUI04", "" ),
		["08"] = Functions.AddLabel( E["01"]["05"], "RichLabelEGUI03", { "Rich.Name" } ),
		["09"] = Functions.AddTextField( E["01"]["05"], "RichTextFieldEGUI01", "" ),
		["10"] = Functions.AddButton( E["01"]["05"], "RichButtonEGUI01", { "Rich.AddPreset" } ),
		["11"] = Functions.AddButton( E["01"]["07"], "RichButtonEGUI02", { "Rich.AddBefore" } ),
		["12"] = Functions.AddButton( E["01"]["07"], "RichButtonEGUI03", { "Rich.AddAfter" } )
	}

	E["01"]["02"].style.top_margin = 4
	E["01"]["02"].style.bottom_margin = 8
	E["01"]["04"].style.top_margin = 8
	E["01"]["04"].style.bottom_margin = 8
	E["01"]["06"].style.top_margin = 8
	E["01"]["06"].style.bottom_margin = 8
	E["02"]["02"].style.horizontally_stretchable = true
	E["02"]["04"].style.width = 28
	E["02"]["04"].style.height = 28
	E["02"]["09"].style.width = 110
	E["02"]["10"].tooltip = { "Rich.CurrentCoords" }
	E["02"]["11"].style.horizontally_stretchable = true
	E["02"]["12"].style.horizontally_stretchable = true

	global.GUIS[player_id].E = E

	Functions.Tab04Toggle( player_id )
end

--Tab04 | Toggle visibilty of the Labels for the Dropdown
Functions.Tab04Toggle = function( player_id )
	local GUI = global.GUIS[player_id].E["01"]
	GUI["03"].visible = not GUI["03"].visible
	GUI["04"].visible = not GUI["04"].visible
end

Functions.Tab04Update = function( player_id, coords )
	local GUI = global.GUIS[player_id].E["02"]

	if next( coords ) then
		GUI["06"].caption = "X: " .. coords.x
		GUI["07"].caption = "Y: " .. coords.y
	else
		GUI["06"].caption = ""
		GUI["07"].caption = ""
	end

	global.CurrentPosition[player_id] = coords
end

--Tab04 | Add a Preset to the Dropdown
Functions.Tab04AddPreset = function( player_id, adding_type, name01, coordinates01 )
	local GUI = global.GUIS[player_id].E["02"]
	local SavedGPS = global.SavedGPS[player_id]
	SavedGPS.Number = SavedGPS.Number + 1

	if SavedGPS.Number < 100 then
		local index_number = Functions.Format2Digit( SavedGPS.Number )
		local coordinates = game.players[player_id].position
		local name = GUI["09"].text
		GUI["09"].text = ""

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
		["01"] = Functions.AddFlow( parent, "RichFlowFGUI01", "horizontal", "richtitlebarflow" ),
		["02"] = Functions.AddLine( parent, "RichLineFGUI01", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlowFGUI02", "horizontal", "richbuttonflow" )
	}
	F["02"] =
	{
		["01"] = Functions.AddLabel( F["01"]["01"], "RichLabelFGUI01", { "Rich.Tab05Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( F["01"]["01"], "RichWidgetFGUI01" ),
		["03"] = Functions.AddDropDown( F["01"]["01"], "RichDropDownFGUI01", {} ),
		["04"] = Functions.AddSpriteButton( F["01"]["01"], "RichSpriteButtonFGUI01", "utility/refresh", "close_button" ),
		["05"] = Functions.AddButton( F["01"]["03"], "RichButtonFGUI01", { "Rich.AddBefore" } ),
		["06"] = Functions.AddButton( F["01"]["03"], "RichButtonFGUI02", { "Rich.AddAfter" } )
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
		["01"] = Functions.AddFlow( parent, "RichFlowGGUI01", "horizontal", "richtitlebarflow" ),
		["02"] = Functions.AddLine( parent, "RichLineGGUI01", "horizontal" ),
		["03"] = Functions.AddFlow( parent, "RichFlowGGUI02", "horizontal", "richbuttonflow" )
	}
	G["02"] =
	{
		["01"] = Functions.AddLabel( G["01"]["01"], "RichLabelGGUI01", { "Rich.Tab06Title" }, "caption_label" ),
		["02"] = Functions.AddWidget( G["01"]["01"], "RichWidgetGGUI01" ),
		["03"] = Functions.AddDropDown( G["01"]["01"], "RichDropDownGGUI01", {} ),
		["04"] = Functions.AddSpriteButton( G["01"]["01"], "RichSpriteButtonGGUI01", "utility/refresh", "close_button" ),
		["05"] = Functions.AddButton( G["01"]["03"], "RichButtonGGUI01", { "Rich.AddBefore" } ),
		["06"] = Functions.AddButton( G["01"]["03"], "RichButtonGGUI02", { "Rich.AddAfter" } )
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
	global.CurrentRichText[player_id] = global.CurrentRichText[player_id] or ""
	global.CurrentHEX[player_id] = global.CurrentHEX[player_id] or "#000000"
	global.CurrentPosition[player_id] = global.CurrentPosition[player_id] or {}
	global.Reset[player_id] = global.Reset[player_id] or false
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
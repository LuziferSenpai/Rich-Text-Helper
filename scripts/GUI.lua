local Defines = require "defines"

local AddButton = function( parent, name, caption, style )
	return parent.add{ type = "button", name = name, caption = caption, style = style }
end

local AddCheckbox = function( parent, name, caption )
	return parent.add{ type = "checkbox", name = name, caption = caption, state = false }
end

local AddChooseElemButton = function( parent, name, elem_type )
	return parent.add{ type = "choose-elem-button", name = name, elem_type = elem_type }
end

local AddDropDown = function( parent, name, items )
	return parent.add{ type = "drop-down", name = name, items = items }
end

local AddFlow = function( parent, name, direction, style )
	return parent.add{ type = "flow", name = name, direction = direction, style = style }
end

local AddFrame = function( parent, name, style )
	return parent.add{ type = "frame", name = name, direction = "vertical", style = style }
end

local AddLabel = function( parent, name, caption, style )
	return parent.add{ type = "label", name = name, caption = caption, style = style }
end

local AddLine = function( parent, name, direction, style )
	return parent.add{ type = "line", name = name, direction = direction, style = style }
end

local AddPane = function( parent, name )
	return parent.add{ type = "tabbed-pane", name = name }
end

local AddScrollPane = function( parent, name, direction, style )
	return parent.add{ type = "scroll-pane", name = name, direction = direction, style = style }
end

local AddSlider = function( parent, name, minimum_value, maximum_value, value, style )
	return parent.add{ type = "slider", name = name, minimum_value = minimum_value, maximum_value = maximum_value, value = value, style = style }
end

local AddSpriteButton = function( parent, name, sprite, style )
	return parent.add{ type = "sprite-button", name = name, sprite = sprite, style = style }
end

local AddTab = function( parent, name, caption )
	return parent.add{ type = "tab", name = name, caption = caption }
end

local AddTable = function( parent, name, column_count )
	return parent.add{ type = "table", name = name, column_count = column_count }
end

local AddTextBox = function( parent, name, text, style )
	return parent.add{ type = "text-box", name = name, text = text, style = style }
end

local AddTextField = function( parent, name, text, style )
	return parent.add{ type = "textfield", name = name, text = text, style = style }
end

local AddWidget = function( parent, name, style )
	return parent.add{ type = "empty-widget", name = name, style = style }
end

local GUI = {}

GUI.Main = function( parent )
	local A = {}

	A["01"] = AddFrame( parent, "RichFrameAGUI01", "dialog_frame" )
	A["02"] =
	{
		["01"] = AddFlow( A["01"], "RichFlowAGUI01", "horizontal", "richtitlebarflow" ),
		["02"] = AddFrame( A["01"], "RichFrameAGUI02", "inside_deep_frame_for_tabs" )
	}
	A["03"] =
	{
		["01"] = AddLabel( A["02"]["01"], "RichLabelAGUI01", { "Rich.Title" }, "frame_title" ),
		["02"] = AddWidget( A["02"]["01"], "RichWidgetAGUI01", "richdragwidget" ),
		["03"] = AddSpriteButton( A["02"]["01"], "RichSpriteButtonAGUI01", "utility/close_white", "close_button" ),
		["04"] = AddPane( A["02"]["02"], "RichPaneAGUI01" )
	}
	A["04"] =
	{
		["01"] = AddTab( A["03"]["04"], "RichTabAGUI02", { "Rich.Tab01" } ),
		["02"] = AddTab( A["03"]["04"], "RichTabAGUI03", { "Rich.Tab02" } ),
		["03"] = AddTab( A["03"]["04"], "RichTabAGUI04", { "Rich.Tab03" } ),
		["04"] = AddTab( A["03"]["04"], "RichTabAGUI05", { "Rich.Tab04" } ),
		["05"] = AddTab( A["03"]["04"], "RichTabAGUI06", { "Rich.Tab05" } ),
		["06"] = AddTab( A["03"]["04"], "RichTabAGUI07", { "Rich.Tab06" } ),
		["07"] = AddTab( A["03"]["04"], "RichTabAGUI08", { "Rich.Tab07" } ),
		["08"] = AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI01", "vertical", "richtabscrollpane" ),
		["09"] = AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI02", "vertical", "richtabscrollpane" ),
		["10"] = AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI03", "vertical", "richtabscrollpane" ),
		["11"] = AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI04", "vertical", "richtabscrollpane" ),
		["12"] = AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI05", "vertical", "richtabscrollpane" ),
		["13"] = AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI06", "vertical", "richtabscrollpane" ),
		["14"] = AddScrollPane( A["03"]["04"], "RichScrollPaneAGUI07", "vertical", "richtabscrollpane" )
	}

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
	A["03"]["04"].add_tab( A["04"]["07"], A["04"]["14"] )

	A["04"]["08"].horizontal_scroll_policy = "never"
	A["04"]["09"].horizontal_scroll_policy = "never"
	A["04"]["10"].horizontal_scroll_policy = "never"
	A["04"]["11"].horizontal_scroll_policy = "never"
	A["04"]["12"].horizontal_scroll_policy = "never"
	A["04"]["13"].horizontal_scroll_policy = "never"
	A["04"]["14"].horizontal_scroll_policy = "never"

	return A
end

GUI.RichText = function( parent )
	local B = {}

	B["01"] = AddFrame( parent, "RichHiddenFrameBGUI01", "outer_frame_without_shadow" )

	B["02"] =
	{
		["01"] = AddFlow( B["01"], "RichFlowBGUI01", "horizontal", "richtabtitleflow" ),
		["02"] = AddLine( B["01"], "RichLineBGUI01", "horizontal", "richheadline" ),

		["03"] = AddFlow( B["01"], "RichFlowBGUI02", "horizontal", "richcolorflow" ),
		["04"] = AddLine( B["01"], "RichLineBGUI02", "horizontal", "richline" ),

		["05"] = AddFlow( B["01"], "RichFlowBGUI03", "horizontal", "richbuttonflow" ),
		["06"] = AddLine( B["01"], "RichLineBGUI03", "horizontal", "richline" ),

		["07"] = AddFlow( B["01"], "RichFlowBGUI04", "horizontal", "richcolorflow" ),
		["08"] = AddFlow( B["01"], "RichFlowBGUI05", "horizontal", "richcolorflow" ),
		["09"] = AddFlow( B["01"], "RichFlowBGUI06", "horizontal", "richcolorflow" ),
		["10"] = AddLine( B["01"], "RichLineBGUI04", "horizontal", "richline" ),

		["11"] = AddFlow( B["01"], "RichFlowBGUI07", "horizontal", "richbuttonflow" ),
		["12"] = AddFlow( B["01"], "RichFlowBGUI08", "horizontal", "richbuttonflow" )
	}

	B["03"] =
	{
		["01"] = AddLabel( B["02"]["01"], "RichLabelBGUI02", { "Rich.TextTitle" }, "caption_label" ),
		["02"] = AddWidget( B["02"]["01"], "RichWidgetBGUI02" ),
		["03"] = AddDropDown( B["02"]["01"], "RichDropDownBGUI01", {} ),
		["04"] = AddSpriteButton( B["02"]["01"], "RichSpriteButtonBGUI01", "utility/remove", "richtoolbutton" ),

		["05"] = AddLabel( B["02"]["03"], "RichLabelBGUI03", { "Rich.DropdownSelection" }, "description_label" ),
		["06"] = AddLabel( B["02"]["03"], "RichLabelBGUI04", "" ),

		["07"] = AddButton( B["02"]["05"], "RichButtonBGUI01", { "Rich.AddBefore" } ),
		["08"] = AddButton( B["02"]["05"], "RichButtonBGUI02", { "Rich.AddAfter" } ),
		["09"] = AddButton( B["02"]["05"], "RichButtonBGUI03", { "Rich.SetCurrent" } ),

		["10"] = AddTextField( B["02"]["07"], "RichTextFieldBGUI01", "", "richtextbox" ),
		["11"] = AddButton( B["02"]["07"], "RichButtonBGUI04", { "Rich.ClearField" } ),

		["12"] = AddLabel( B["02"]["08"], "RichLabelBGUI05", { "Rich.Output" }, "description_label" ),
		["13"] = AddLabel( B["02"]["08"], "RichLabelBGUI06", "" ),
		["14"] = AddWidget( B["02"]["08"], "RichWidgetBGUI03" ),
		["15"] = AddButton( B["02"]["08"], "RichButtonBGUI05", { "Rich.SelectAll" } ),

		["16"] = AddLabel( B["02"]["09"], "RichLabelBGUI07", { "Rich.Name" }, "description_label" ),
		["17"] = AddTextField( B["02"]["09"], "RichTextFieldBGUI02", "" ),
		["18"] = AddButton( B["02"]["09"], "RichButtonBGUI06", { "Rich.AddPreset" } ),

		["19"] = AddChooseElemButton( B["02"]["11"], "RichChooseElemBGUI01", "signal" ),
		["20"] = AddButton( B["02"]["11"], "RichButtonBGUI07", { "Rich.CreateTag" } ),
		["21"] = AddButton( B["02"]["11"], "RichButtonBGUI08", { "Rich.SendMessage" } ),
		["22"] = AddButton( B["02"]["11"], "RichButtonBGUI09", { "Rich.BackerName" } ),

		["23"] = AddButton( B["02"]["12"], "RichButtonBGUI10", { "Rich.SetLine" } ),
		["24"] = AddButton( B["02"]["12"], "RichButtonBGUI11", { "Rich.SetNetwork" } )
	}

	B["02"]["01"].style.top_margin = 8
	B["02"]["03"].visible = false
	B["02"]["04"].visible = false
	B["02"]["05"].visible = false
	B["02"]["06"].visible = false
	B["02"]["08"].style.top_margin = 8
	B["02"]["08"].style.bottom_margin = 8
	B["02"]["11"].style.vertical_align = "center"
	B["02"]["12"].style.vertical_align = "center"
	B["02"]["12"].style.top_margin = 8

	B["03"]["01"].style.font = "heading-2"
	B["03"]["02"].style.horizontally_stretchable = true
	B["03"]["06"].style.width = 400
	B["03"]["06"].style.single_line = false
	B["03"]["07"].style.horizontally_stretchable = true
	B["03"]["08"].style.horizontally_stretchable = true
	B["03"]["09"].style.horizontally_stretchable = true
	B["03"]["13"].style.width = 420
	B["03"]["13"].style.single_line = false
	B["03"]["14"].style.horizontally_stretchable = true
	B["03"]["17"].style.width = 110
	B["03"]["19"].style.width = 28
	B["03"]["19"].style.height = 28
	B["03"]["20"].style.horizontally_stretchable = true
	B["03"]["21"].style.horizontally_stretchable = true
	B["03"]["22"].style.horizontally_stretchable = true
	B["03"]["23"].style.horizontally_stretchable = true
	B["03"]["24"].style.horizontally_stretchable = true

	if not game.active_mods["Simple_Circuit_Trains"] then
		B["03"]["23"].visible = false
	end

	if not game.active_mods["Wireless_Circuit_Network"] then
		B["03"]["24"].visible = false
	end

	return B
end

GUI.Tab01 = function( parent )
	local C = {}

	C["01"] =
	{
		["01"] = AddFlow( parent, "RichFlowCGUI01", "horizontal", "richtabtitleflow" ),
		["02"] = AddLine( parent, "RichLineCGUI01", "horizontal", "richheadline" ),
		["03"] = AddFlow( parent, "RichFlowCBGUI02", "horizontal", "richbuttonflow" ),
		["04"] = AddFlow( parent, "RichFlowCGUI03", "horizontal", "richbuttonflow" ),
		["05"] = AddFlow( parent, "RichFlowCGUI04", "horizontal", "richbuttonflow" )
	}

	C["02"] =
	{
		["01"] = AddLabel( C["01"]["01"], "RichLabelCGUI01", { "Rich.Tab01Title" }, "caption_label" ),
		["02"] = AddWidget( C["01"]["01"], "RichWidgetCGUI01" ),
		["03"] = AddDropDown( C["01"]["01"], "RichDropDownCGUI01", Defines.ChooseElemDropDown ),

		["04"] = AddCheckbox( C["01"]["04"], "RichCheckBoxCGUI01", { "Rich.IconOnly" } ),

		["05"] = AddButton( C["01"]["05"], "RichButtonCGUI01", { "Rich.AddBefore" } ),
		["06"] = AddButton( C["01"]["05"], "RichButtonCGUI02", { "Rich.AddAfter" } )
	}

	C["01"]["02"].visible = false
	C["01"]["03"].style.bottom_margin = 8
	C["01"]["03"].visible = false
	C["01"]["04"].style.horizontal_align = "right"
	C["01"]["04"].visible = false
	C["01"]["05"].visible = false

	C["02"]["01"].style.font = "heading-2"
	C["02"]["02"].style.horizontally_stretchable = true
	C["02"]["05"].style.horizontally_stretchable = true
	C["02"]["06"].style.horizontally_stretchable = true

	return C
end

GUI.Tab02 = function( parent )
	local D = {}

	D["01"] =
	{
		["01"] = AddFlow( parent, "RichFlowDGUI01", "horizontal", "richtabtitleflow" ),
		["02"] = AddLine( parent, "RichLineDGUI01", "horizontal", "richheadline" ),
		["03"] = AddFlow( parent, "RichFlowDGUI02", "horizontal", "richcolorflow" ),
		["04"] = AddFlow( parent, "RichFlowDGUI03", "horizontal", "richcolorflow" ),
		["05"] = AddFlow( parent, "RichFlowDGUI04", "horizontal", "richcolorflow" ),
		["06"] = AddFlow( parent, "RichFlowDGUI05", "horizontal", "richcolorflow" ),
		["07"] = AddFlow( parent, "RichFlowDGUI06", "horizontal", "richcolorflow" ),
		["08"] = AddFlow( parent, "RichFlowDGUI07", "horizontal", "richcolorflow" ),
		["09"] = AddLine( parent, "RichLineDGUI02", "horizontal", "richheadline" ),
		["10"] = AddFlow( parent, "RichFlowDGUI08", "horizontal", "richbuttonflow" )
	}

	D["02"] =
	{
		["01"] = AddLabel( D["01"]["01"], "RichLabelDGUI01", { "Rich.Tab02Title" }, "caption_label" ),
		["02"] = AddWidget( D["01"]["01"], "RichWidgetDGUI01" ),
		["03"] = AddDropDown( D["01"]["01"], "RichDropDownDGUI01", Defines.ColorDropDown ),

		["04"] = AddLabel( D["01"]["03"], "RichLabelDGUI02", "R" ),
		["05"] = AddSlider( D["01"]["03"], "RichSliderDGUI01", 0, 255, 0, "red_slider" ),
		["06"] = AddTextField( D["01"]["03"], "RichTextFieldDGUI01", "" ),

		["07"] = AddLabel( D["01"]["04"], "RichLabelDGUI03", "G" ),
		["08"] = AddSlider( D["01"]["04"], "RichSliderDGUI02", 0, 255, 0, "green_slider" ),
		["09"] = AddTextField( D["01"]["04"], "RichTextFieldDGUI02", "" ),

		["10"] = AddLabel( D["01"]["05"], "RichLabelDGUI04", "B" ),
		["11"] = AddSlider( D["01"]["05"], "RichSliderDGUI03", 0, 255, 0, "blue_slider" ),
		["12"] = AddTextField( D["01"]["05"], "RichTextFieldDGUI03", "" ),

		["13"] = AddTextField( D["01"]["06"], "RichTextFieldDGUI04", "" ),
		["14"] = AddWidget( D["01"]["06"], "RichWidgetDGUI02" ),
		["15"] = AddLabel( D["01"]["06"], "RichLabelDGUI05", "A" ),

		["16"] = AddLabel( D["01"]["07"], "RichLabelDGUI06", { "Rich.Name" }, "description_label" ),
		["17"] = AddTextField( D["01"]["07"], "RichTextFieldDGUI05", "" ),
		["18"] = AddButton( D["01"]["07"], "RichButtonDGUI01", { "Rich.AddPreset" } ),

		["19"] = AddTable( D["01"]["08"], "RichTableDGUI01", 11 ),

		["20"] = AddButton( D["01"]["10"], "RichButtonDGUI02", { "Rich.AddBefore" } ),
		["21"] = AddButton( D["01"]["10"], "RichButtonDGUI03", { "Rich.AddAfter" } ),
		["22"] = AddButton( D["01"]["10"], "RichButtonDGUI04", { "Rich.Applyto" } )
	}

	D["03"] = {}

	D["02"]["01"].style.font = "heading-2"
	D["02"]["02"].style.horizontally_stretchable = true
	D["02"]["06"].style.width = 40
	D["02"]["06"].numeric = true
	D["02"]["09"].style.width = 40
	D["02"]["09"].numeric = true
	D["02"]["12"].style.width = 40
	D["02"]["12"].numeric = true
	D["02"]["13"].style.width = 70
	D["02"]["14"].style.width = 110
	D["02"]["15"].style.font = "RichResult"
	D["02"]["17"].style.width = 110
	D["02"]["20"].style.horizontally_stretchable = true
	D["02"]["21"].style.horizontally_stretchable = true
	D["02"]["22"].style.horizontally_stretchable = true

	return D
end

GUI.Tab03 = function( parent )
	local E = {}

	E["01"] =
	{
		["01"] = AddFlow( parent, "RichFlowEGUI01", "horizontal", "richtabtitleflow" ),
		["02"] = AddLine( parent, "RichLineEGUI01", "horizontal", "richheadline" ),
		["03"] = AddFlow( parent, "RichFlowEGUI02", "horizontal", "richbuttonflow" )
	}
	E["02"] =
	{
		["01"] = AddLabel( E["01"]["01"], "RichLabelEGUI01", { "Rich.Tab03Title" }, "caption_label" ),
		["02"] = AddWidget( E["01"]["01"], "RichWidgetEGUI01" ),
		["03"] = AddDropDown( E["01"]["01"], "RichDropDownEGUI01", Defines.FontDropDown ),

		["04"] = AddButton( E["01"]["03"], "RichButtonEGUI01", { "Rich.AddBefore" } ),
		["05"] = AddButton( E["01"]["03"], "RichButtonEGUI02", { "Rich.AddAfter" } ),
		["06"] = AddButton( E["01"]["03"], "RichButtonEGUI03", { "Rich.Applyto" } )
	}

	E["02"]["01"].style.font = "heading-2"
	E["02"]["02"].style.horizontally_stretchable = true
	E["02"]["04"].style.horizontally_stretchable = true
	E["02"]["05"].style.horizontally_stretchable = true
	E["02"]["06"].style.horizontally_stretchable = true

	return E
end

GUI.Tab04 = function( parent )
	local F = {}

	F["01"] =
	{
		["01"] = AddFlow( parent, "RichFlowFGUI01", "horizontal", "richtabtitleflow" ),
		["02"] = AddLine( parent, "RichLineFGUI01", "horizontal", "richheadline" ),
		["03"] = AddFlow( parent, "RichFlowFGUI02", "horizontal", "richcolorflow" ),
		["04"] = AddLine( parent, "RichLineFGUI02", "horizontal", "richline" ),
		["05"] = AddFlow( parent, "RichFlowFGUI03", "horizontal", "richcolorflow" ),
		["06"] = AddLine( parent, "RichLineFGUI03", "horizontal", "richline" ),
		["07"] = AddFlow( parent, "RichFlowFGUI04", "horizontal", "richbuttonflow" )
	}
	F["02"] =
	{
		["01"] = AddLabel( F["01"]["01"], "RichLabelFGUI01", { "Rich.Tab04Title" }, "caption_label" ),
		["02"] = AddWidget( F["01"]["01"], "RichWidgetFGUI01" ),
		["03"] = AddDropDown( F["01"]["01"], "RichDropDownFGUI01", {} ),
		["04"] = AddSpriteButton( F["01"]["01"], "RichSpriteButtonFGUI01", "utility/remove", "richtoolbutton" ),

		["05"] = AddLabel( F["01"]["03"], "RichLabelFGUI02", { "Rich.DropdownSelection" }, "description_label" ),
		["06"] = AddLabel( F["01"]["03"], "RichLabelFGUI03", "" ),
		["07"] = AddLabel( F["01"]["03"], "RichLabelFGUI04", "" ),

		["08"] = AddLabel( F["01"]["05"], "RichLabelFGUI03", { "Rich.Name" }, "description_label" ),
		["09"] = AddTextField( F["01"]["05"], "RichTextFieldFGUI01", "" ),
		["10"] = AddButton( F["01"]["05"], "RichButtonFGUI01", { "Rich.AddPreset" } ),

		["11"] = AddButton( F["01"]["07"], "RichButtonFGUI02", { "Rich.AddBefore" } ),
		["12"] = AddButton( F["01"]["07"], "RichButtonFGUI03", { "Rich.AddAfter" } )
	}

	F["01"]["03"].visible = false
	F["01"]["04"].visible = false

	F["02"]["01"].style.font = "heading-2"
	F["02"]["02"].style.horizontally_stretchable = true
	F["02"]["09"].style.width = 110
	F["02"]["10"].tooltip = { "Rich.CurrentCoords" }
	F["02"]["11"].style.horizontally_stretchable = true
	F["02"]["12"].style.horizontally_stretchable = true

	return F
end

GUI.Tab05 = function( parent )
	local G = {}

	G["01"] =
	{
		["01"] = AddFlow( parent, "RichFlowGGUI01", "horizontal", "richtitlebarflow" ),
		["02"] = AddLine( parent, "RichLineGGUI01", "horizontal", "richheadline" ),
		["03"] = AddFlow( parent, "RichFlowGGUI02", "horizontal", "richbuttonflow" )
	}
	G["02"] =
	{
		["01"] = AddLabel( G["01"]["01"], "RichLabelGGUI01", { "Rich.Tab05Title" }, "caption_label" ),
		["02"] = AddWidget( G["01"]["01"], "RichWidgetGGUI01" ),
		["03"] = AddDropDown( G["01"]["01"], "RichDropDownGGUI01", {} ),
		["04"] = AddSpriteButton( G["01"]["01"], "RichSpriteButtonGGUI01", "utility/refresh", "richtoolbutton" ),

		["05"] = AddButton( G["01"]["03"], "RichButtonGGUI01", { "Rich.AddBefore" } ),
		["06"] = AddButton( G["01"]["03"], "RichButtonGGUI02", { "Rich.AddAfter" } )
	}

	G["02"]["01"].style.font = "heading-2"
	G["02"]["02"].style.horizontally_stretchable = true
	G["02"]["05"].style.horizontally_stretchable = true
	G["02"]["06"].style.horizontally_stretchable = true

	return G
end

GUI.Tab06 = function( parent )
	local H = {}

	H["01"] =
	{
		["01"] = AddFlow( parent, "RichFlowHGUI01", "horizontal", "richtitlebarflow" ),
		["02"] = AddLine( parent, "RichLineHGUI01", "horizontal", "richheadline" ),
		["03"] = AddFlow( parent, "RichFlowHGUI02", "horizontal", "richbuttonflow" )
	}
	H["02"] =
	{
		["01"] = AddLabel( H["01"]["01"], "RichLabelHGUI01", { "Rich.Tab06Title" }, "caption_label" ),
		["02"] = AddWidget( H["01"]["01"], "RichWidgetHGUI01" ),
		["03"] = AddDropDown( H["01"]["01"], "RichDropDownHGUI01", {} ),
		["04"] = AddSpriteButton( H["01"]["01"], "RichSpriteButtonHGUI01", "utility/refresh", "richtoolbutton" ),

		["05"] = AddButton( H["01"]["03"], "RichButtonHGUI01", { "Rich.AddBefore" } ),
		["06"] = AddButton( H["01"]["03"], "RichButtonHGUI02", { "Rich.AddAfter" } )
	}

	H["02"]["01"].style.font = "heading-2"
	H["02"]["02"].style.horizontally_stretchable = true
	H["02"]["05"].style.horizontally_stretchable = true
	H["02"]["06"].style.horizontally_stretchable = true

	return H
end

GUI.Tab07 = function( parent )
	local I = {}

	I["01"] =
	{
		["01"] = AddFlow( parent, "RichFlowIGUI01", "horizontal", "richtitlebarflow" ),
		["02"] = AddLine( parent, "RichLineIGUI01", "horizontal", "richheadline" ),
		["03"] = AddCheckbox( parent, "RichCheckboxIGUI01", { "Rich.RichTemplates" } ),
		["04"] = AddCheckbox( parent, "RichCheckboxIGUI02", { "Rich.ColorTemplates" } ),
		["05"] = AddCheckbox( parent, "RichCheckboxIGUI03", { "Rich.GPSTemplates" } ),
		["06"] = AddFlow( parent, "RichFlowIGUI02", "horizontal", "richcolorflow" ),
		["07"] = AddTextBox( parent, "RichTextBoxIGUI01", "", "richtextbox" ),
		["08"] = AddFlow( parent, "RichFlowIGUI03", "horizontal", "richcolorflow" ),
		["09"] = AddLine( parent, "RichLineIGUI02", "horizontal", "richline" ),
		["10"] = AddFlow( parent, "RichFlowIGUI04", "horizontal", "richcolorflow" )
	}
	I["02"] =
	{
		["01"] = AddLabel( I["01"]["01"], "RichLabelIGUI01", { "Rich.Tab07Title" }, "caption_label" ),

		["02"] = AddButton( I["01"]["06"], "RichButtonIGUI01", { "Rich.Generate" } ),

		["03"] = AddButton( I["01"]["08"], "RichButtonIGUI02", { "Rich.SelectAll" } ),

		["04"] = AddTextField( I["01"]["10"], "RichTextFieldIGUI01", "", "richtextbox" ),
		["05"] = AddButton( I["01"]["10"], "RichButtonIGUI03", { "Rich.Import" } )
	}

	I["01"]["01"].style.horizontal_align = "center"
	I["01"]["06"].style.horizontal_align = "right"
	I["01"]["07"].read_only = true
	I["01"]["07"].word_wrap = true
	I["01"]["07"].style.height = 105
	I["01"]["07"].style.top_margin = 8
	I["01"]["07"].style.bottom_margin = 8
	I["01"]["08"].style.horizontal_align = "right"

	I["02"]["01"].style.font = "heading-2"
	I["02"]["02"].style.height = 28

	return I
end

GUI.AddButton = AddButton
GUI.AddChooseElemButton = AddChooseElemButton
GUI.AddSpriteButton = AddSpriteButton

return GUI
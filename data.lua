local s = data.raw["gui-style"].default

--Frames
s["richmainframe"] =
{
    type = "frame_style",
    parent = "dialog_frame",
    vertical_align = "center"
}

--Flows
s["richtitlebarflow"] =
{
    type = "horizontal_flow_style",
    horizontally_stretchable = "on",
    vertical_align = "center",
    bottom_margin = 4
}

s["richtitlebarflow8"] =
{
    type = "horizontal_flow_style",
    parent = "richtitlebarflow",
    top_margin = 8,
}

s["richtitlebarflowcenter"] =
{
    type = "horizontal_flow_style",
    parent = "richtitlebarflow",
    horizontal_align = "center"
}

s["richflowcenterleft8"] =
{
    type = "horizontal_flow_style",
    horizontally_stretchable = "on",
    horizontal_align = "left",
    vertical_align = "center",
    horizontal_spacing = 8
}

s["richflowcenterleft88"] =
{
    type = "horizontal_flow_style",
    parent = "richflowcenterleft8",
    top_margin = 8
}

s["richflowcenterright8"] =
{
    type = "horizontal_flow_style",
    parent = "richflowcenterleft8",
    horizontal_align = "right"
}

s["richbuttonflow"] =
{
    type = "horizontal_flow_style",
    horizontally_stretchable = "on",
    horizontal_align = "center",
    horizontal_spacing = 4
}

s["richbuttonflowcenter"] =
{
    type = "horizontal_flow_style",
    parent = "richbuttonflow",
    vertical_align = "center"
}

s["richbuttonflowcenter8"] =
{
    type = "horizontal_flow_style",
    parent = "richbuttonflowcenter",
    top_margin = 8
}

s["richflowvertical"] =
{
    type = "vertical_flow_style",
    horizontal_align = "center"
}

s["richflowvertical300"] =
{
    type = "vertical_flow_style",
    horizontal_align = "center",
    width = 250
}
s["richflowverticalleft"] =
{
    type = "vertical_flow_style",
    horizontal_align = "left",
    width = 250
}

--Labels
s["richpresetlabel"] =
{
    type = "label_style",
    parent = "label",
    width = 15,
    height = 15,
    scalable = false,
    font = "RichSavedPreset",
    top_padding = -4
}

s["richtitlelabel"] =
{
    type = "label_style",
    parent = "caption_label",
    font = "heading-2"
}

s["richsinglelabel"] =
{
    type = "label_style",
    single_line = false
}

s["richsinglelabelwidth"] =
{
    type = "label_style",
    parent = "richsinglelabel",
    width = 540
}

s["richresultlabel"] =
{
    type = "label_style",
    font = "RichResult"
}

--Widgets
s["richwidget"] =
{
    type = "empty_widget_style",
    horizontally_stretchable = "on",
    minimal_width = 0
}

s["richdragwidget"] =
{
    type = "empty_widget_style",
    parent = "draggable_space_header",
    horizontally_stretchable = "on",
    natural_height = 24,
    minimal_width = 24,
}

s["richwidget70"] =
{
    type = "empty_widget_style",
    width = 70
}

--Scrollpanes
s["richtabscrollpane"] =
{
    type = "scroll_pane_style",
    parent = "tab_scroll_pane",
    vertically_stretchable = "on",
    horizontal_scroll_policy = "off",
    padding = 5
}

s["richtabscrollpane300"] =
{
    type = "scroll_pane_style",
    parent = "richtabscrollpane",
    width = 287
}

s["richscrollpane"] =
{
    type = "scroll_pane_style",
    parent = "scroll_pane",
    height = 300,
    horizontal_scroll_policy = "off",
    vertically_stretchable = "on",
    vertically_squashable = "off",
    horizontally_squashable = "off"
}

--Textboxes
s["richtextbox"] =
{
    type = "textbox_style",
    rich_text_setting = "disabled",
    natural_height = 0,
    width = 0,
    horizontally_stretchable = "on"
}

s["richtextbox105height88"] =
{
    type = "textbox_style",
    parent = "richtextbox",
    height = 105,
    top_margin = 8,
    bottom_margin = 8
}

s["richfield40"] =
{
    type = "textbox_style",
    width = 40
}

s["richfield110"] =
{
    type = "textbox_style",
    width = 110
}

--Buttons
s["richtoolbutton"] =
{
    type = "button_style",
    parent = "tool_button",
    size = 28
}

s["richstretchbutton"] =
{
    type = "button_style",
    horizontally_stretchable = "on"
}

s["richchooseelem28"] =
{
    type = "button_style",
    parent = "slot_button",
    size = 28
}

s["richbutton28height"] =
{
    type = "button_style",
    height = 28
}

--Lines
s["richline"] =
{
    type = "line_style",
    top_margin = 8,
    bottom_margin = 8
}

s["richheadline"] =
{
    type = "line_style",
    parent = "richline",
    top_margin = 4,
    bottom_margin = 8
}

s["richlinevertical"] =
{
    type = "line_style",
    left_margin = 12,
    right_margin = 12
}

s["richlinevertical300"] =
{
    type = "line_style",
    parent = "richlinevertical",
    height = 300
}

--Tabbed pane
s["richpane400"] =
{
    type = "tabbed_pane_style",
    height = 400
}

s["richpane250"] =
{
    type = "tabbed_pane_style",
    height = 300,
    width = 300,
}

--Checkbox
s["richcheckboxright"] =
{
    type = "checkbox_style",
    parent = "checkbox",
    horizontal_align = "right"
}

--List Box
s["richlistbox"] =
{
    type = "list_box_style",
    parent = "list_box",
    scroll_pane_style =
    {
        type = "scroll_pane_style",
        height = 250
    },
    item_style =
    {
        type = "button_style",
        parent = "list_box_item",
        horizontal_align = "right"
    }
}

data:extend
{
    {
        type = "font",
        name = "RichResult",
        from = "Simple",
        size = 30
    },
    {
        type = "font",
        name = "RichSavedPreset",
        from = "Simple",
        size = 15
    },
    {
        type = "custom-input",
        name = "RichGUI",
        action = "lua",
        key_sequence = "CONTROL + SHIFT + R"
    },
    {
        type = "custom-input",
        name = "RichBacker",
        action = "lua",
        key_sequence = "CONTROL + SHIFT + B"
    },
    {
        type = "sprite",
        name = "Senpais-remove",
        filename = "__Rich_Text_Helper__/remove-icon.png",
        priority = "extra-high-no-scale",
        width = 64,
        height = 64,
        scale = 1
    }
}

log( serpent.block( data.raw["gui-style"].default["richdragwidget"] ) )
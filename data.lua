local s = data.raw["gui-style"].default

s["richtitlebarflow"] =
{
    type = "horizontal_flow_style",
    horizontally_stretchable = "on",
    vertical_align = "center"
}

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

s["richdragwidget"] =
{
    type = "empty_widget_style",
    parent = "draggable_space_header",
    horizontally_stretchable = "on",
    natural_height = 24,
    minimal_width = 24,
}

s["richtabscrollpane"] =
{
    type = "scroll_pane_style",
    parent = "tab_scroll_pane",
    vertically_stretchable = "on",
    padding = 5
}

s["richtabtitleflow"] =
{
    type = "horizontal_flow_style",
    vertical_align = "center",
    horizontally_stretchable = "on",
    bottom_margin = 4
}

s["richcolorflow"] =
{
    type = "horizontal_flow_style",
    horizontally_stretchable = "on",
    vertical_align = "center",
    horizontal_align = "left",
    horizontal_spacing = 8
}

s["richbuttonflow"] =
{
    type = "horizontal_flow_style",
    horizontally_stretchable = "on",
    horizontal_align = "center",
    horizontal_spacing = 4
}

s["richtextbox"] =
{
    type = "textbox_style",
    rich_text_setting = "disabled",
    natural_height = 0,
    width = 0,
    horizontally_stretchable = "on"
}

s["richtoolbutton"] =
{
    type = "button_style",
    parent = "tool_button",
    size = 28
}

s["richheadline"] =
{
    type = "line_style",
    top_margin = 4,
    bottom_margin = 8
}

s["richline"] =
{
    type = "line_style",
    top_margin = 8,
    bottom_margin = 8
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
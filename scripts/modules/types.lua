local types = {}

types.metatable = { __index = types }

local dropdownselection =
{
    {
        { "Rich.ChooseElem01" },
        { "Rich.ChooseElem02" },
        { "Rich.ChooseElem03" },
        { "Rich.ChooseElem04" },
        { "Rich.ChooseElem05" },
        { "Rich.ChooseElem06" },
        { "Rich.ChooseElem07" },
        { "Rich.ChooseElem08" },
        { "Rich.ChooseElem09" }
    },
    {
        "item",
        "entity",
        "technology",
        "recipe",
        "item-group",
        "fluid",
        "tile",
        "signal",
        "achievement"
    },
    {
        "item",
        "entity",
        "technology",
        "recipe",
        "item-group",
        "fluid",
        "tile",
        "virtual-signal",
        "achievement"
    }
}

function types.new( player )
    local module =
    {
        player = player,
        player_char = player.player
    }

    setmetatable( module, types.metatable )

    return module
end

function types:gui( parent )
    local titleflow = parent.add{ type = "flow", direction = "horizontal", style = "richtitlebarflow" }
    local visible =
    {
        parent.add{ type = "line", direction = "horizontal", style = "richheadline" },
        parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" },
        parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" },
        parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" }
    }
    visible[1].visible = false
    visible[2].visible = false
    visible[3].visible = false
    visible[4].visible = false
    self.visible = visible

    titleflow.add{ type = "label", caption = { "Rich.Tab01Title" }, style = "richtitlelabel" }
    titleflow.add{ type = "empty-widget", style = "richwidget" }
    self.dropdown = titleflow.add{ type = "drop-down", name = "RICH_DROP_18_types01", items = dropdownselection[1] }
    self.checkbox = visible[3].add{ type = "checkbox", caption = { "Rich.IconOnly" }, state = false, style = "richcheckboxright" }
    visible[4].add{ type = "button", name = "RICH_CLICK_19_types01", caption = { "Rich.AddBefore" }, style = "richstretchbutton" }
    visible[4].add{ type = "button", name = "RICH_CLICK_19_types02", caption = { "Rich.AddAfter" }, style = "richstretchbutton" }
end

function types:clear()
    self.visible = nil
    self.dropdown = nil
    self.checkbox = nil
    self.chooseelem = nil
end

function types:richtextreturn()
    local richtext = ""
    local elem_value = self.chooseelem.elem_value
    if type( elem_value ) ~= "nil" then
        local selected_index = self.dropdown.selected_index

        if type( elem_value ) == "table" then
            local elemtype = elem_value.type

            if elemtype == "virtual" then
                selected_index = 8
            elseif elemtype == "fluid" then
                selected_index = 5
            elseif elemtype == "item" then
                selected_index = 1
            end
            
            elem_value = elem_value.name
        end

        if self.checkbox.state then
            richtext = "[img=" .. dropdownselection[3][selected_index] .. "/" .. elem_value .. "]"
        else
            richtext = "[" .. dropdownselection[3][selected_index] .. "=" .. elem_value .. "]"
        end
    end

    return richtext
end

function types:on_gui_click( event )
    local text = self:richtextreturn()

    if #text > 0 then
        local number = event.element.name:sub( 20, 21 )
        local richtext = self.player.richtext

        if number == "01" then
            richtext:update_text( text .. richtext.richfield.text )
        elseif number == "02" then
            richtext:update_text( richtext.richfield.text .. text )
        end
    end
end

function types:on_gui_selection_state_changed( event )
    local element = event.element
    local number = element.name:sub( 19, 20 )
    if number == "01" then
        local visible = self.visible

        for i = 1, 4 do
            visible[i].visible = true
        end

        if self.chooseelem then self.chooseelem.destroy() end

        self.chooseelem = visible[2].add{ type = "choose-elem-button", elem_type = dropdownselection[2][element.selected_index] }
    end
end

return types
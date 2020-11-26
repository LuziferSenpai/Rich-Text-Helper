local colors = {}

colors.metatable = { __index = colors }

local dropdownselection =
{
    {
        { "Rich.default" },
        { "Rich.red" },
        { "Rich.green" },
        { "Rich.blue" },
        { "Rich.orange" },
        { "Rich.yellow" },
        { "Rich.pink" },
        { "Rich.purple" },
        { "Rich.white" },
        { "Rich.black" },
        { "Rich.gray" },
        { "Rich.brown" },
        { "Rich.cyan" },
        { "Rich.acid" }
    },
    {
        { r = 255, g = 160, b = 66 },
        { r = 255, g = 42, b = 35 },
        { r = 44, g = 210, b = 63 },
        { r = 87, g = 174, b = 255 },
        { r = 255, g = 160, b = 66 },
        { r = 255, g = 211, b = 58 },
        { r = 255, g = 132, b = 161 },
        { r = 209, g = 112, b = 254 },
        { r = 229, g = 229, b = 229 },
        { r = 127, g = 127, b = 127 },
        { r = 178, g = 178, b = 178 },
        { r = 193, g = 133, b = 94 },
        { r = 85, g = 234, b = 220 },
        { r = 180, g = 253, b = 34 }
    }
}

local ColortoHEX = function( color )
    return string.format( "#%.2X%.2X%.2X", color.r, color.g, color.b )
end

local HEXtoColor = function( HEX )
    HEX = HEX:gsub( "#", "" )
    return { r = tonumber( "0x" .. HEX:sub( 1, 2 ) ), g = tonumber( "0x" .. HEX:sub( 3, 4 ) ), b = tonumber( "0x" .. HEX:sub( 5, 6 ) ) }
end

function colors.new( player )
    local module =
    {
        player = player,
        player_char = player.player,
        currenthex = "#000000",
        savedcolors =
        {
            number = 0,
            colors = {},
            colornames = {}
        },
        labeltabel = {}
    }

    setmetatable( module, colors.metatable )

    return module
end

function colors:addpreset( oldname, oldcolor )
    local savedcolors = self.savedcolors

    savedcolors.number = savedcolors.number + 1

    local index = tostring( savedcolors.number )
    local color = oldcolor or HEXtoColor( self.currenthex )
    local name = oldname or self.namefield.text

    if self.namefield then
        self.namefield.text = ""
    end

    if #name == 0 then
        name = index
    end

    savedcolors.colors[index] = color
    savedcolors.colornames[index] = name

    if self.table then
        self:addpresetbutton( tonumber( index ), color, name )
    end
end

function colors:gui( parent )
    local titleflow = parent.add{ type = "flow", direction = "horizontal", style = "richtitlebarflow" }
    parent.add{ type = "line", direction = "horizontal", style = "richheadline" }
    local colorflows =
    {
        parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" },
        parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" },
        parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" },
        parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" },
        parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" },
        parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" },
    }
    parent.add{ type = "line", direction = "horizontal", style = "richheadline" }
    local buttonflow = parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" }

    titleflow.add{ type = "label", caption = { "Rich.Tab02Title" }, style = "richtitlelabel" }
    titleflow.add{ type = "empty-widget", style = "richwidget" }
    self.dropdown = titleflow.add{ type = "drop-down", name = "RICH_DROP_19_colors01", items = dropdownselection[1] }
    local color = { {}, {}, {} }
    colorflows[1].add{ type = "label", caption = "R" }
    color[1][1] = colorflows[1].add{ type = "slider", name = "RICH_SLIDER_21_colors01", minimum_value = 0, maximum_value = 255, style = "red_slider" }
    color[1][2] = colorflows[1].add{ type = "textfield", name = "RICH_CONFIRMED_24_colors01", style = "richfield40" }
    color[1][2].numeric = true
    colorflows[2].add{ type = "label", caption = "G" }
    color[2][1] = colorflows[2].add{ type = "slider", name = "RICH_SLIDER_21_colors02", minimum_value = 0, maximum_value = 255, style = "green_slider" }
    color[2][2] = colorflows[2].add{ type = "textfield", name = "RICH_CONFIRMED_24_colors02", style = "richfield40" }
    color[2][2].numeric = true
    colorflows[3].add{ type = "label", caption = "B" }
    color[3][1] = colorflows[3].add{ type = "slider", name = "RICH_SLIDER_21_colors03", minimum_value = 0, maximum_value = 255, style = "blue_slider" }
    color[3][2] = colorflows[3].add{ type = "textfield", name = "RICH_CONFIRMED_24_colors03", style = "richfield40" }
    color[3][2].numeric = true
    self.color = color
    self.hexfield = colorflows[4].add{ type = "textfield", name = "RICH_CONFIRMED_24_colors04", style = "richfield110" }
    colorflows[4].add{ type = "empty-widget", style = "richwidget70" }
    self.colorlabel = colorflows[4].add{ type = "label", caption = "A", style = "richresultlabel" }
    colorflows[5].add{ type = "label", caption = { "Rich.Name" }, style = "description_label" }
    self.namefield = colorflows[5].add{ type = "textfield", style = "richfield110" }
    colorflows[5].add{ type = "button", name = "RICH_CLICK_20_colors01", caption = { "Rich.AddPreset" } }
    self.table = colorflows[6].add{ type = "table", column_count = 11 }
    buttonflow.add{ type = "button", name = "RICH_CLICK_20_colors02", caption = { "Rich.AddBefore" }, style = "richstretchbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_20_colors03", caption = { "Rich.AddAfter" }, style = "richstretchbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_20_colors04", caption = { "Rich.Applyto" }, style = "richstretchbutton" }

    local savedcolors = self.savedcolors

    if savedcolors.number > 0 then
        for i = 1, savedcolors.number do
            local index = tostring( i )

            self:addpresetbutton( i, savedcolors.colors[index], savedcolors.colornames[index] )
        end
    end

    self:update( "" )
end

function colors:addpresetbutton( number, color, tooltip )
    local label = self.table.add{ type = "label", name = "RICH_CLICK_20_colors05" .. number, caption = "B", tooltip = tooltip, style = "richpresetlabel" }
    
    label.style.font_color = color

    self.labeltabel[number] = label
end

function colors:clear()
    self.dropdown = nil
    self.color = nil
    self.hexfield = nil
    self.colorlabel = nil
    self.namefield = nil
    self.table = nil
    self.labeltabel = {}
end

function colors:update( element_type, index )
    local color = HEXtoColor( self.currenthex )
    local colortable = self.color

    if element_type == "drop-down" then
        color = dropdownselection[2][self.dropdown.selected_index]
    elseif element_type == "" then
    else
        self.dropdown.selected_index = 0

        if element_type == "rgb" then
            color = { r = tonumber( colortable[1][2].text ), g = tonumber( colortable[2][2].text ), b = tonumber( colortable[3][2].text ) }
        elseif element_type == "hex" then
            color = HEXtoColor( self.hexfield.text )
        elseif element_type == "slider" then
            color = { r = colortable[1][1].slider_value, g = colortable[2][1].slider_value, b = colortable[3][1].slider_value }
        elseif element_type == "preset" then
            color = self.savedcolors.colors[index]
        end
    end

    local hex = ColortoHEX( color )

    colortable[1][1].slider_value = color.r
    colortable[1][2].text = tostring(color.r)
    colortable[2][1].slider_value = color.g
    colortable[2][2].text = tostring(color.g)
    colortable[3][1].slider_value = color.b
    colortable[3][2].text = tostring(color.b)
    self.hexfield.text = hex
    self.colorlabel.style.font_color = color
    self.currenthex = hex
end

function colors:on_gui_click( event )
    local name = event.element.name
    local number = name:sub( 21, 22 )

    if number == "01" then
        self:addpreset()
    elseif number == "02" then
        local richtext = self.player.richtext
        
        richtext:update_text( "[color=" .. self.currenthex .. "][/color]" .. richtext.richfield.text )
    elseif number == "03" then
        local richtext = self.player.richtext
        
        richtext:update_text( richtext.richfield.text .. "[color=" .. self.currenthex .. "][/color]" )
    elseif number == "04" then
        local richtext = self.player.richtext
        
        richtext:update_text( "[color=" .. self.currenthex .. "]" .. richtext.richfield.text .. "[/color]" )
    elseif number == "05" then
        local index = name:sub( 23 )
        local button = event.button

        if button == defines.mouse_button_type.left then
            self:update( "preset", index )
        elseif button == defines.mouse_button_type.right then
            self.table.clear()

            local savedcolors = self.savedcolors

            savedcolors.colors[index] = nil
            savedcolors.colornames[index] = nil

            self.savedcolors =
            {
                number = 0,
                colors = {},
                colornames = {}
            }

            local scolors = savedcolors.colors

            for entry, color in pairs( scolors ) do
                self:addpreset( savedcolors.colornames[entry], color )
            end
        else
            self.player_char.print( { "Rich.WrongButton" } )
        end
    end
end

function colors:on_gui_confirmed( event )
    local element = event.element
    local number = element.name:sub( 25, 26 )
    
    if number == "01" or number == "02" or number == "03" then
        if tonumber( element.text ) > 255 then element.text = "255" end

        self:update( "rgb" )
    elseif number == "04" then
        local text = element.text

        if text:sub( 1, 1 ) == "#" and #text == 7 then
            for i = 2, 7 do
                if not text:sub( i, i ):find( "%x" ) then
                    self:update( "" )

                    return
                end
            end

            self:update( "hex" )
        else
            self:update( "" )
        end
    end
end

function colors:on_gui_selection_state_changed( event )
    local element = event.element
    local number = element.name:sub( 20, 21 )

    if number == "01" then
        self:update( "drop-down" )
    end
end

function colors:on_gui_value_changed( event )
    local number = event.element.name:sub( 22, 23 )

    if number == "01" or number == "02" or number == "03" then
        self:update( "slider" )
    end
end

return colors
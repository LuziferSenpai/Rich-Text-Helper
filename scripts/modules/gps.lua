local gps = {}

gps.metatable = { __index = gps }

function gps.new( player )
    local module =
    {
        player = player,
        player_char = player.player,
        currentposition = {},
        savedgps =
        {
            number = 0,
            positions = {},
            positionnames = {}
        }
    }

    setmetatable( module, gps.metatable )

    return module
end

function gps:addpreset( oldname, oldcoords )
    local savedgps = self.savedgps

    savedgps.number = savedgps.number + 1

    local index = tostring( savedgps.number )
    local coords = oldcoords or self.player_char.position
    local name = oldname or self.namefield.text

    if self.namefield then
        self.namefield.text = ""
    end

    if #name == 0 then
        name = index
    end

    savedgps.positions[index] = coords
    savedgps.positionnames[index] = name

    if self.dropdown then
        self.dropdown.items = savedgps.positionnames
    end
end

function gps:gui( parent )
    local titleflow = parent.add{ type = "flow", direction = "horizontal", style = "richtitlebarflow" }
    parent.add{ type = "line", direction = "horizontal", style = "richheadline" }
    local visible =
    {
        parent.add{ type = "flow", direction = "horizontal", stlyle = "richflowcenterleft8" },
        parent.add{ type = "line", direction = "horizontal", style = "richline" }
    }
    visible[1].visible = false
    visible[2].visible = false
    self.visible = visible
    local presetflow = parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" }
    parent.add{ type = "line", direction = "horizontal", style = "richline" }
    local buttonflow = parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" }

    titleflow.add{ type = "label", caption = { "Rich.Tab04Title" }, style = "richtitlelabel" }
    titleflow.add{ type = "empty-widget", style = "richwidget" }
    self.dropdown = titleflow.add{ type = "drop-down", name = "RICH_DROP_16_gps01", items = self.savedgps.positionnames }
    titleflow.add{ type = "sprite-button", name = "RICH_CLICK_17_gps01", sprite = "Senpais-remove", style = "richtoolbutton" }
    visible[1].add{ type = "label", caption = { "Rich.DropdownSelection" }, style = "description_label" }
    self.dropdownlabels =
    {
        visible[1].add{ type = "label" },
        visible[1].add{ type = "label" }
    }
    presetflow.add{ type = "label", caption = { "Rich.Name" }, style = "description_label" }
    self.namefield = presetflow.add{ type = "textfield", style = "richfield110" }
    presetflow.add{ type = "button", name = "RICH_CLICK_17_gps02", caption = { "Rich.AddPreset" }, tooltip = { "Rich.CurrentCoords" } }
    buttonflow.add{ type = "button", name = "RICH_CLICK_17_gps03", caption = { "Rich.AddBefore" }, style = "richstretchbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_17_gps04", caption = { "Rich.AddAfter" }, style = "richstretchbutton" }
end

function gps:clear()
    self.visible = nil
    self.dropdown = nil
    self.dropdownlabels = nil
    self.namefield = nil
end

function gps:update( coords )
    local dropdownlabels = self.dropdownlabels
    if next( coords ) then
        dropdownlabels[1].caption = "X: " .. coords.x
        dropdownlabels[2].caption = "Y: " .. coords.y
    else
        dropdownlabels[1].caption = ""
        dropdownlabels[2].caption = ""
    end

    self.currentposition = coords
end

function gps:toggle()
    local visible = self.visible
    
    for i = 1, #visible do
        visible[i].visible = not visible[i].visible
    end
end

function gps:richtextreturn( button )
    local player = self.player_char
    local position = player.position

    if button == defines.mouse_button_type.left then
        if self.visible[1].visible then
            position = self.currentposition
        else
            player.print( { "Rich.CantAdd" } )
            
            return ""
        end
    end

    return "[gps=" .. position.x .. "," .. position.y .. "]"
end

function gps:on_gui_click( event )
    local number = event.element.name:sub( 18, 19 )

    if number == "01" then
        local selected_index = self.dropdown.selected_index

        if selected_index > 0 then
            local index = tostring( selected_index )
            local savedgps = self.savedgps

            savedgps.positions[index] = nil
            savedgps.positionnames[index] = nil

            self.savedgps =
            {
                number = 0,
                positions = {},
                positionnames = {}
            }

            local coordinates = savedgps.positions

            if next( coordinates ) then
                for entry, coords in pairs( coordinates ) do
                    self:addpreset( savedgps.positionnames[entry], coords )
                end

                selected_index = self.dropdown.selected_index

                if selected_index == 0 then
                    self:update( {} )
                    self:toggle()
                else
                    self.update( self.savedgps.postions[index] )
                end
            else
                self.dropdown.items = {}
                self:update( {} )
                self:toggle()
            end
        else
            self.player_char.print( { "Rich.NothingSelected" } )
        end
    elseif number == "02" then
        self:addpreset()
    elseif number == "03" then
        local text = self:richtextreturn( event.button )
        
        if #text > 0 then
            local richtext = self.player.richtext

            richtext:update_text( text .. richtext.richfield.text )
        end
    elseif number == "04" then
        local text = self:richtextreturn( event.button )
        
        if #text > 0 then
            local richtext = self.player.richtext

            richtext:update_text( richtext.richfield.text .. text )
        end
    end
end

function gps:on_gui_selection_state_changed( event )
    local element = event.element
    local number = element.name:sub( 17, 18 )

    if number == "01" then
        if not self.visible[1].visible then
            self:toggle()
        end

        self:update( self.savedgps.positions[tostring( element.selected_index )] )
    end
end

return gps
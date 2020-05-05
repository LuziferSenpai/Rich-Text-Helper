local richtext = {}

richtext.metatable = { __index = richtext }

function richtext.new( player )
    local module =
    {
        player = player,
        player_char = player.player,
        currentrichtext = "",
        savedrichtexts =
        {
            number = 0,
            richtexts = {},
            richtextnames = {}
        }
    }

    setmetatable( module, richtext.metatable )
    
    return module
end

function richtext:addpreset( oldname, oldtext )
    local savedrichtexts = self.savedrichtexts

    savedrichtexts.number = savedrichtexts.number + 1

    local index = tostring( savedrichtexts.number )
    local text =  oldtext or self.richfield.text
    local name = oldname or self.namefield.text

    if self.namefield then
        self.namefield.text = ""
    end

    if #name == 0 then
        name = index
    end

    savedrichtexts.richtexts[index] = text
    savedrichtexts.richtextnames[index] = name

    if self.dropdown then
        self.dropdown.items = savedrichtexts.richtextnames
    end
end

function richtext:gui( parent )
    local frame = parent.add{ type = "frame", direction = "vertical", style = "outer_frame_without_shadow" }
    local titleflow = frame.add{ type = "flow", direction = "horizontal", style = "richtitlebarflow8" }
    frame.add{ type = "line", direction = "horizontal", style = "richheadline" }
    local visible =
    {
        frame.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" },
        frame.add{ type = "line", direction = "horizontal", style = "richline" },
        frame.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" },
        frame.add{ type = "line", direction = "horizontal", style = "richline" }
    }
    visible[1].visible = false
    visible[2].visible = false
    visible[3].visible = false
    visible[4].visible = false
    self.visible = visible
    local richflows =
    {
        frame.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" },
        frame.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft88" },
        frame.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft88" }
    }
    frame.add{ type = "line", direction = "horizontal", style = "richline" }
    local buttonflow =
    {
        frame.add{ type = "flow", direction = "horizontal", style = "richbuttonflowcenter" },
        frame.add{ type = "flow", direction = "horizontal", style = "richbuttonflowcenter8" }
    }

    titleflow.add{ type = "label", caption = { "Rich.TextTitle" }, style = "richtitlelabel" }
    titleflow.add{ type = "empty-widget", style = "richwidget" }
    self.dropdown = titleflow.add{ type = "drop-down", name = "RICH_DROP_21_richtext01", items = self.savedrichtexts.richtextnames }
    titleflow.add{ type = "sprite-button", name = "RICH_CLICK_22_richtext01", sprite = "Senpais-remove", style = "richtoolbutton" }
    visible[1].add{ type = "label", caption = { "Rich.DropdownSelection" }, style = "description_label" }
    self.dropdownlabel = visible[1].add{ type = "label", style = "richsinglelabel" }
    visible[3].add{ type = "button", name = "RICH_CLICK_22_richtext02", caption = { "Rich.AddBefore" }, style = "richstretchbutton" }
    visible[3].add{ type = "button", name = "RICH_CLICK_22_richtext03", caption = { "Rich.AddAfter" }, style = "richstretchbutton" }
    visible[3].add{ type = "button", name = "RICH_CLICK_22_richtext04", caption = { "Rich.SetCurrent" }, style = "richstretchbutton" }
    self.richfield = richflows[1].add{ type = "textfield", name = "RICH_CHANGED_24_richtext01", text = self.currentrichtext, style = "richtextbox" }
    richflows[1].add{ type = "button", name = "RICH_CLICK_22_richtext05", caption = { "Rich.ClearField" } }
    richflows[2].add{ type = "label", caption = { "Rich.Output" }, style = "description_label" }
    self.richoutput = richflows[2].add{ type = "label", caption = self.currentrichtext, style = "richsinglelabelwidth" }
    richflows[2].add{ type = "empty-widget", style = "richwidget" }
    richflows[2].add{ type = "button", name = "RICH_CLICK_22_richtext06", caption = { "Rich.SelectAll" } }
    richflows[3].add{ type = "label", caption = { "Rich.Name" }, style = "description_label" }
    self.namefield = richflows[3].add{ type = "textfield", style = "richfield110" }
    richflows[3].add{ type = "button", name = "RICH_CLICK_22_richtext07", caption = { "Rich.AddPreset" } }
    self.chooseelem = buttonflow[1].add{ type = "choose-elem-button", elem_type = "signal", style = "richchooseelem28" }
    buttonflow[1].add{ type = "button", name = "RICH_CLICK_22_richtext08", caption = { "Rich.CreateTag" }, style = "richstretchbutton" }
    buttonflow[1].add{ type = "button", name = "RICH_CLICK_22_richtext09", caption = { "Rich.SendMessage" }, style = "richstretchbutton" }
    buttonflow[1].add{ type = "button", name = "RICH_CLICK_22_richtext10", caption = { "Rich.BackerName" }, style = "richstretchbutton" }
    local modbuttons =
    {
        buttonflow[2].add{ type = "button", name = "RICH_CLICK_23_richtext11", caption = { "Rich.SetLine" }, style = "richstretchbutton" },
        buttonflow[2].add{ type = "button", name = "RICH_CLICK_23_richtext12", caption = { "Rich.SetNetwork" }, style = "richstretchbutton" }
    }

    if not game.active_mods["Simple_Circuit_Trains"] then
        modbuttons[1].visible = false
    end

    if not game.active_mods["Wireless_Circuit_Network"] then
        modbuttons[2].visible = false
    end

    self.modbuttons = modbuttons
end

function richtext:clear()
    self.visible = nil
    self.dropdown = nil
    self.dropdownlabel = nil
    self.richfield = nil
    self.richoutput = nil
    self.namefield = nil
    self.chooseelem = nil
    self.modbuttons = nil
end

function richtext:update_text( text )
    self.richfield.text = text
    self.richoutput.caption = text

    if not self.player.savedentity then
        self.currentrichtext = text
    end
end

function richtext:toggle()
    local visible = self.visible
    
    for i = 1, #visible do
        visible[i].visible = not visible[i].visible
    end
end

function richtext:on_gui_click( event )
    local number = event.element.name:sub( 23, 24 )

    if number == "01" then
        local selected_index = self.dropdown.selected_index

        if selected_index >  0 then
            local index = tostring( selected_index )
            local savedrichtexts = self.savedrichtexts

            savedrichtexts.richtexts[index] = nil
            savedrichtexts.richtextnames[index] = nil

            self.savedrichtexts =
            {
                number = 0,
                richtexts = {},
                richtextnames = {}
            }

            local texts = savedrichtexts.richtexts

            if next( texts ) then
                for entry, text in pairs( texts ) do
                    self:addpreset( savedrichtexts.richtextnames[entry], text )
                end

                selected_index = self.dropdown.selected_index

                if selected_index == 0 then
                    self.dropdownlabel.caption = ""

                    self:toggle()
                else
                    self.dropdownlabel.caption = self.savedrichtexts.richtexts[tostring( selected_index )]
                end
            else
                self.dropdown.items = {}
                self.dropdownlabel.caption = ""

                self:toggle()
            end
        else
            self.player_char.print( { "Rich.NothingSelected" } )
        end
    elseif number == "02" then
        self:update_text( self.dropdownlabel.caption .. self.richfield.text )
    elseif number == "03" then
        self:update_text( self.richfield.text .. self.dropdownlabel.caption )
    elseif number == "04" then
        self:update_text( self.dropdownlabel.caption )
    elseif number == "05" then
        self:update_text( "" )
    elseif number == "06" then
        local element = self.richfield

        element.select_all()
        element.focus()
    elseif number == "07" then
        if self.richfield.text:len() > 0 then
            self:addpreset()
        else
            self.player_char.print( { "Rich.NoRichText" } )
        end
    elseif number == "08" then
        local text = self.richfield.text
        local player = self.player_char
        
        if text:len() > 0 then
            local elem_value = self.chooseelem.elem_value
            local tag =
            {
                position = player.position,
                text = text,
                last_user = player
            }

            if type( elem_value ) == "table" then
                tag.icon = elem_value
            end

            local position = self.player.gps.currentposition

            if next( position ) and event.button == defines.mouse_button_type.right then
                tag.position = position
            end

            player.force.add_chart_tag( player.surface, tag )
        else
            player.print( { "Rich.NoRichText" } )
        end
    elseif number == "09" then
        local player = self.player_char
        local text = self.richfield.text

        if text:len() > 0 then
            local chat_color = player.chat_color

            game.print( player.name .. ": " .. text, chat_color )
        else
            player.print( { "Rich.NoRichText" } )
        end
    elseif number == "10" then
        local player = self.player_char
        local text = self.richfield.text

        if text:len() > 0 then
            local entity = self.player.savedentity

            if entity then
                entity.backer_name = text
            elseif player.opened_gui_type == defines.gui_type.entity then
                entity = player.opened
                
                if entity.supports_backer_name() then
                    entity.backer_name = text
                else
                    player.print( { "Rich.NoBackerName" } )
                end
            else
                player.print( { "Rich.NoEntityOpen" } )
            end
        else
            player.print( { "Rich.NoRichText" } )
        end
    elseif number == "11" then
        local player = self.player_char
        local text = self.richfield.text

        if text:len() > 0 then
            local boolean = remote.call( "LineName", "Change", player.index, text )

            if boolean then
                player.print( { "Rich.CircuitNotOpen" } )
            end
        else
            player.print( { "Rich.NoRichText" } )
        end
    elseif number == "12" then
        local player = self.player_char
        local text = self.richfield.text

        if text:len() > 0 then
            local boolean = remote.call( "WirelessName", "Change", player.index, text )

            if boolean then
                player.print( { "Rich.WirelessNotOpen" } )
            end
        else
            player.print( { "Rich.NoRichText" } )
        end
    end
end

function richtext:on_gui_selection_state_changed( event )
    local element = event.element
    local number = element.name:sub( 22, 23 )

    if number == "01" then
        self.dropdownlabel.caption = self.savedrichtexts.richtexts[tostring( element.selected_index )]

        if not self.visible[1].visible then
            self:toggle()
        end
    end
end

function richtext:on_gui_text_changed( event )
    local element = event.element
    local number = element.name:sub( 25, 26 )

    if number == "01" then
        local text = element.text
        self.richoutput.caption = text

        if not self.player.savedentity then
            self.currentrichtext = text
        end
    end
end

function richtext:on_config_changed( event )
    local changes = event.mod_changes or {}

    local circuitchanges = changes["Simple_Circuit_Trains"] or {}
    local wirelesschanges = changes["Wireless_Circuit_Network"] or {}

    if next( circuitchanges ) then
        local visible = false

        if circuitchanges.new_version then
            visible = true
        end

        self.modbuttons[1].visible = visible
    end

    if next( wirelesschanges ) then
        local visible = false

        if wirelesschanges.new_version then
            visible = true
        end

        self.modbuttons[1].visible = visible
    end
end

return richtext
local multiplayer = {}

multiplayer.metatable = { __index = multiplayer }

function multiplayer.new( player )
    local module =
    {
        player = player,
        player_char = player.player
    }

    setmetatable( module, multiplayer.metatable )

    return module
end

function multiplayer:makedropdowntable()
    local player_char = self.player
    local players = player_char.players
    local dropdowntable = { {}, {} }
    local index_number = 0

    for index, player in pairs( players ) do
        if player.player.connected and index ~= player_char.index then
            index_number = index_number + 1

            dropdowntable[1][index_number] = player.player.name
            dropdowntable[2][index_number] = player
        end
    end

    self.dropdowntable = dropdowntable
end

function multiplayer:gui( parent )
    self:makedropdowntable()
    
    parent.add{ type = "flow", direction = "horizontal", style = "richtitlebarflowcenter" }.add{ type = "label", caption = { "Rich.Tab08Title" }, style = "richtitlelabel" }
    parent.add{ type = "line", direction = "horizontal", style = "richheadline" }
    local horizontalflow = parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" }
    local pane = horizontalflow.add{ type = "frame", style = "inside_deep_frame_for_tabs" }.add{ type = "tabbed-pane", style = "richpane250" }
    horizontalflow.add{ type = "line", direction = "vertical", style = "richlinevertical" }
    local verticalflow = horizontalflow.add{ type = "flow", direction = "vertical", style = "richflowvertical" }
    verticalflow.add{ type = "label", caption = { "Rich.PlayerList" }, style = "richtitlelabel" }
    verticalflow.add{ type = "line", direction = "horizontal", style = "richline" }
    self.listbox = verticalflow.add{ type = "list-box", items = self.dropdowntable[1], style = "richlistbox" }
    local tabs =
    {
        pane.add{ type = "tab", caption = { "Rich.Tab0801" } },
        pane.add{ type = "tab", caption = { "Rich.Tab0802" } },
        pane.add{ type = "tab", caption = { "Rich.Tab0803" } }
    }
    local scrollpanes =
    {
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane300" },
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane300" },
        pane.add{ type = "scroll-pane", direction = "vertical", style = "richtabscrollpane300" },
    }

    self.scrollpanes = scrollpanes

    pane.add_tab( tabs[1], scrollpanes[1] )
    pane.add_tab( tabs[2], scrollpanes[2] )
    pane.add_tab( tabs[3], scrollpanes[3] )

    parent.add{ type = "line", direction = "horizontal", style = "richline" }
    local buttonflow = parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_25_multiplayer01", caption = { "Rich.ReloadPresets" }, style = "richstretchbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_25_multiplayer02", caption = { "Rich.ReloadPlayers" }, style = "richstretchbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_25_multiplayer03", caption = { "Rich.Send" }, style = "richstretchbutton" }

    self:addcheckboxes()
end 

function multiplayer:addcheckboxes()
    local scrollpanes = self.scrollpanes
    local player = self.player
    local savedrichtexts = player.richtext.savedrichtexts
    local savedcolors = player.colors.savedcolors
    local savedgps = player.gps.savedgps
    local checkboxes = { {}, {}, {} }
    scrollpanes[1].clear()
    scrollpanes[2].clear()
    scrollpanes[3].clear()

    for index, name in pairs( savedrichtexts.richtextnames ) do
        checkboxes[1][index] = scrollpanes[1].add{ type = "checkbox", caption = name, state = false }
    end

    for index, name in pairs( savedcolors.colornames ) do
        checkboxes[2][index] = scrollpanes[2].add{ type = "checkbox", caption = name, state = false }
    end

    for index, name in pairs( savedgps.positionnames ) do
        checkboxes[3][index] = scrollpanes[3].add{ type = "checkbox", caption = name, state = false }
    end

    self.checkboxes = checkboxes

    local data = {}
    
    if next( checkboxes[1] ) then
        data["richtext"] = savedrichtexts
    end

    if next( checkboxes[2] ) then
        data["color"] = savedcolors
    end

    if next( checkboxes[3] ) then
        data["gps"] = savedgps
    end

    self.data = data
end

function multiplayer:clear()
    self.dropdowntable = nil
    self.listbox = nil
    self.scrollpanes = nil
    self.checkboxes = nil
    self.data = nil
end

function multiplayer:accept_gui( presets, player )
    if self.frame then
        player.print( { "Rich.AlreadyRecieving", self.player_char.name } )
    else
        local frame = self.player_char.gui.center.add{ type = "frame", direction = "vertical", style = "richmainframe" }
        frame.add{ type = "flow", direction = "horizontal", style = "richtitlebarflowcenter" }.add{ type = "label", caption = { "Rich.AcceptTitle" }, style = "richtitlelabel" }
        frame.add{ type = "line", direction = "horizontal", style = "richheadline" }
        local horizontalflow = frame.add{ type = "scroll-pane", direction = "vertical", style = "richscrollpane" }.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" }
        local verticalflow1 = horizontalflow.add{ type = "flow", direction = "vertical", style = "richflowvertical300" }
        verticalflow1.add{ type = "label", caption = { "Rich.Richtext" }, style = "richtitlelabel" }
        verticalflow1.add{ type = "line", direction = "horizontal", style = "richline" }
        local verticalflow12 = verticalflow1.add{ type = "flow", direction = "vertical", style = "richflowverticalleft" }
        horizontalflow.add{ type = "line", direction = "vertical", style = "richlinevertical300" }
        local verticalflow2 = horizontalflow.add{ type = "flow", direction = "vertical", style = "richflowvertical300" }
        verticalflow2.add{ type = "label", caption = { "Rich.Colors" }, style = "richtitlelabel" }
        verticalflow2.add{ type = "line", direction = "horizontal", style = "richline" }
        local verticalflow22 = verticalflow2.add{ type = "flow", direction = "vertical", style = "richflowverticalleft" }
        horizontalflow.add{ type = "line", direction = "vertical", style = "richlinevertical300" }
        local verticalflow3 = horizontalflow.add{ type = "flow", direction = "vertical", style = "richflowvertical300" }
        verticalflow3.add{ type = "label", caption = { "Rich.GPS" }, style = "richtitlelabel" }
        verticalflow3.add{ type = "line", direction = "horizontal", style = "richline" }
        local verticalflow32 = verticalflow3.add{ type = "flow", direction = "vertical", style = "richflowverticalleft" }
        frame.add{ type = "line", direction = "horizontal", style = "richline" }
        local buttonflow = frame.add{ type = "flow", direction = "horizontal", style = "richbuttonflowcenter" }
        buttonflow.add{ type = "button", name = "RICH_CLICK_25_multiplayer04", caption = { "Rich.Decline" }, style = "red_back_button" }
        buttonflow.add{ type = "empty-widget", style = "richwidget" }
        buttonflow.add{ type = "button", name = "RICH_CLICK_25_multiplayer05", caption = { "Rich.Accept" }, style = "confirm_button" }
        self.frame = frame

        for _, preset in pairs( presets["richtext"] ) do
            verticalflow12.add{ type = "label", caption = "• " .. preset.name, style = "richsinglelabel" }
        end

        for _, preset in pairs( presets["color"] ) do
            verticalflow22.add{ type = "label", caption = "• " .. preset.name, style = "richsinglelabel" }
        end

        for _, preset in pairs( presets["gps"] ) do
            verticalflow32.add{ type = "label", caption = "• " .. preset.name, style = "richsinglelabel" }
        end

        self.presets = presets
        self.sendingplayer = player
    end
end

function multiplayer:on_gui_click( event )
    local number = event.element.name:sub( 26, 27 )

    if number == "01" then
        self:addcheckboxes()
    elseif number == "02" then
        self:makedropdowntable()
        self.listbox.items = self.dropdowntable[1]
    elseif number == "03" then
        local selected_index = self.listbox.selected_index
        if selected_index > 0 then
            local checkboxes = self.checkboxes
            local data = self.data
            local sendingtable = { ["richtext"] = {}, ["color"] = {}, ["gps"] = {} }
            
            for index, box in pairs( checkboxes[1] ) do
                if box.state then
                    sendingtable["richtext"][index] = { richtext = data["richtext"].richtexts[index], name = data["richtext"].richtextnames[index] }
                end
            end

            for index, box in pairs( checkboxes[2] ) do
                if box.state then
                    sendingtable["color"][index] = { color = data["color"].colors[index], name = data["color"].colornames[index] }
                end
            end

            for index, box in pairs( checkboxes[3] ) do
                if box.state then
                    sendingtable["gps"][index] = { position = data["gps"].positions[index], name = data["gps"].positionnames[index] }
                end
            end

            self.dropdowntable[2][selected_index].multiplayer:accept_gui( sendingtable, self.player_char )
        else
            self.player_char.print( { "Rich.CantSend" } )
        end
    elseif number == "04" then
        self.sendingplayer.print( { "Rich.NotAccepted", self.player_char.name } )
        self.frame.destroy()
        self.frame = nil
        self.presets = nil
        self.sendingplayer = nil
    elseif number == "05" then
        self.sendingplayer.print( { "Rich.Accepted", self.player_char.name } )
        self.frame.destroy()
        self.frame = nil
        self.sendingplayer = nil

        local presets = self.presets
        local player = self.player
        local richtext = player.richtext
        local colors = player.colors
        local gps = player.gps
        self.presets = nil

        for _, preset in pairs( presets["richtext"] ) do
            richtext:addpreset( preset.name, preset.richtext )
        end

        for _, preset in pairs( presets["color"] ) do
            colors:addpreset( preset.name, preset.color )
        end

        for _, preset in pairs( presets["gps"] ) do
            gps:addpreset( preset.name, preset.position )
        end
    end
end

return multiplayer
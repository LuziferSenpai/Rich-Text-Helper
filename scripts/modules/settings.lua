local settings = {}

settings.metatable = { __index = settings }

local check = function( number, table1, table1type, table1check, table2 )
    local index_number, table01, table02

    if ( type( number ) ~= "number" or number < 1 or type( table1 ) ~= "table" or type( table2 ) ~= "table" ) then
        return false
    end

    for i = 1, number do
        index_number = tostring( i )
        table01 = table1[index_number]
        table02 = table2[index_number]
        
        if not ( table01 or table02 ) then
            return false
        end

        if type( table01 ) == table1type then
            if type( table01 ) == "table" then
                if table_size( table01 ) == table_size( table1check ) then
                    for index, _ in pairs( table1check ) do
                        if not table01[index] then
                            return false
                        elseif type( table01[index] ) ~= "number" then
                            return false
                        end
                    end
                end
            end
        else
            return false
        end

        if type( table02 ) ~= "string" then
            return false
        end
    end

    return true
end

function settings.new( player )
    local module =
    {
        player = player,
        player_char = player.player
    }

    setmetatable( module, settings.metatable )

    return module
end

function settings:gui( parent )
    parent.add{ type = "flow", direction = "horizontal", style = "richtitlebarflowcenter" }.add{ type = "label", caption = { "Rich.Tab07Title" }, style = "richtitlelabel" }
    parent.add{ type = "line", direction = "horizontal", style = "richheadline" }
    self.checkboxes =
    {
        parent.add{ type = "checkbox", caption = { "Rich.RichTemplates" }, state = false },
        parent.add{ type = "checkbox", caption = { "Rich.ColorTemplates" }, state = false },
        parent.add{ type = "checkbox", caption = { "Rich.GPSTemplates" }, state = false }
    }
    parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterright8" }.add{ type = "button", name = "RICH_CLICK_22_settings01", caption = { "Rich.Generate" }, style = "richbutton28height" }
    local output = parent.add{ type = "text-box", style = "richtextbox105height88" }
    output.read_only = true
    output.word_wrap = true
    self.output = output
    parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterright8" }.add{ type = "button", name = "RICH_CLICK_22_settings02", caption = { "Rich.SelectAll" }, style = "richbutton28height" }
    parent.add{ type = "line", direction = "horizontal", style = "richline" }
    local importfield = parent.add{ type = "flow", direction = "horizontal", style = "richflowcenterleft8" }
    self.input = importfield.add{ type = "textfield", style = "richtextbox" }
    importfield.add{ type = "button", name = "RICH_CLICK_22_settings03", caption = { "Rich.Import" } }
end

function settings:clear()
    self.checkboxes = nil
    self.output = nil
    self.input = nil
end

function settings:on_gui_click( event )
    local number = event.element.name:sub( 23, 24 )

    if number == "01" then
        local exporttable = {}
        local checkboxes = self.checkboxes
        local player = self.player
        local savedrichtexts = player.richtext.savedrichtexts
        local savedcolors = player.colors.savedcolors
        local savedgps = player.gps.savedgps

        if checkboxes[1].state and savedrichtexts.number > 0 then
            exporttable["richtext"] = savedrichtexts
        end

        if checkboxes[2].state and savedcolors.number > 0 then
            exporttable["color"] = savedcolors
        end

        if checkboxes[3].state and savedgps.number > 0 then
            exporttable["gps"] = savedgps
        end

        if next( exporttable ) then
            self.output.text = game.encode_string( game.table_to_json( exporttable ) )
        end
    elseif number == "02" then
        local element = self.output

        element.select_all()
        element.focus()
    elseif number == "03" then
        local text = self.input.text
        if #text > 0 then
            local player = self.player
            local richtext = player.richtext
            local colors = player.colors
            local gps = player.gps
            local importtable = game.json_to_table( game.decode_string( text ) )

            self.input.text = ""

            if type( importtable ) == "table" and next( importtable ) then
                local richtexttable = importtable["richtext"]
                local colorstable = importtable["color"]
                local gpstable = importtable["gps"]

                if type( richtexttable ) == "table" then
                    if check( richtexttable.number, richtexttable.richtexts, "string", nil, richtexttable.richtextnames ) then
                        for index, text in pairs( richtexttable.richtexts ) do
                            richtext:addpreset( richtexttable.richtextnames[index], text )
                        end
                    end
                end

                if type( colorstable ) == "table" then
                    if check( colorstable.number, colorstable.colors, "table", { r = 0, g = 0, b = 0 }, colorstable.colornames ) then
                        for index, color in pairs( colorstable.colors ) do
                            colors:addpreset( colorstable.colornames[index], color )
                        end
                    end
                end

                if type( gpstable ) == "table" then
                    if check( gpstable.number, gpstable.positions, "table", { y = 0, x = 0 }, gpstable.positionnames ) then
                        for index, position in pairs( gpstable.positions ) do
                            gps:addpreset( gpstable.positionnames[index], position )
                        end
                    end
                end
            end
        end
    end
end

return settings
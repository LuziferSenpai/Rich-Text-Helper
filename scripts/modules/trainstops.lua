local trainstops = {}

trainstops.metatable = { __index = trainstops }

function trainstops.new( player )
    local module =
    {
        player = player,
        player_char = player.player,
        savedstops =
        {
            number = 0,
            unitnumbers = {},
            dropdowns = {}
        }
    }

    setmetatable( module, trainstops.metatable )

    return module
end

function trainstops:gui( parent )
    local titleflow = parent.add{ type = "flow", direction = "horizontal", style = "richtitlebarflow" }
    parent.add{ type = "line", direction = "horizontal", style = "richheadline" }
    local buttonflow = parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" }

    titleflow.add{ type = "label", caption = { "Rich.Tab06Title" }, style = "richtitlelabel" }
    titleflow.add{ type = "empty-widget", style = "richwidget" }
    self.dropdown = titleflow.add{ type = "drop-down" }
    titleflow.add{ type = "sprite-button", name = "RICH_CLICK_24_trainstops01", sprite = "utility/refresh", style = "richtoolbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_24_trainstops02", caption = { "Rich.AddBefore" }, style = "richstretchbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_24_trainstops03", caption = { "Rich.AddAfter" }, style = "richstretchbutton" }

    self:update()
end

function trainstops:clear()
    self.dropdown = nil
end

function trainstops:update()
    local force = self.player_char.force
    local datatable = {}
    local savedstops =
    {
        number = 0,
        unitnumbers = {},
        dropdowns = {}
    }

    for _, surface in pairs( game.surfaces ) do
        local strainstops = surface.get_train_stops{ force }

        for _, trainstop in pairs( strainstops ) do
            datatable[tostring( trainstop.unit_number )] = trainstop.backer_name
        end
    end

    for unitnumber, name  in pairs( datatable ) do
        savedstops.number = savedstops.number + 1

        local index = tostring( savedstops.number )

        savedstops.unitnumbers[index] = unitnumber
        savedstops.dropdowns[index] = name
    end

    if self.dropdown then
        self.dropdown.items = savedstops.dropdowns
    end

    self.savedstops = savedstops
end

function trainstops:richtextreturn()
    local selected_index = self.dropdown.selected_index

    if selected_index > 0 then
        return "[train-stop=" .. self.savedstops.unitnumbers[tostring( selected_index )] .. "]"
    else
        self.player_char.print( { "Rich.CantAdd" } )

        return ""
    end
end

function trainstops:on_gui_click( event )
    local number = event.element.name:sub( 25, 26 )

    if number == "01" then
        self:update()
    elseif number == "02" then
        local text = self:richtextreturn()
        if #text > 0 then
            local richtext = self.player.richtext

            richtext:update_text( text .. richtext.richfield.text )
        end
    elseif number == "03" then
        local text = self:richtextreturn()
        if #text > 0 then
            local richtext = self.player.richtext

            richtext:update_text( richtext.richfield.text .. text )
        end
    end
end

return trainstops
local trains = {}

trains.metatable = { __index = trains }

function trains.new( player )
    local module =
    {
        player = player,
        player_char = player.player,
        savedtrains =
        {
            number = 0,
            unitnumbers = {},
            dropdowns = {}
        }
    }

    setmetatable( module, trains.metatable )

    return module
end

function trains:gui( parent )
    local titleflow = parent.add{ type = "flow", direction = "horizontal", style = "richtitlebarflow" }
    parent.add{ type = "line", direction = "horizontal", style = "richheadline" }
    local buttonflow = parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" }

    titleflow.add{ type = "label", caption = { "Rich.Tab05Title" }, style = "richtitlelabel" }
    titleflow.add{ type = "empty-widget", style = "richwidget" }
    self.dropdown = titleflow.add{ type = "drop-down" }
    titleflow.add{ type = "sprite-button", name = "RICH_CLICK_20_trains01", sprite = "utility/refresh", style = "richtoolbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_20_trains02", caption = { "Rich.AddBefore" }, style = "richstretchbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_20_trains03", caption = { "Rich.AddAfter" }, style = "richstretchbutton" }

    self:update()
end

function trains:clear()
    self.dropdown = nil
end

function trains:update()
    local force = self.player_char.force
    local datatable = {}
    local savedtrains =
    {
        number = 0,
        unitnumbers = {},
        dropdowns = {}
    }

    for _, surface in pairs( game.surfaces ) do
        local strains = surface.get_trains( force )

        for _, train in pairs( strains ) do
            local locomotives = train.locomotives

            for _, locomotive in pairs( locomotives.back_movers ) do
                datatable[tostring( locomotive.unit_number )] = train.id .. ": " .. locomotive.backer_name
            end

            for _, locomotive in pairs( locomotives.front_movers ) do
                datatable[tostring( locomotive.unit_number )] = train.id .. ": " .. locomotive.backer_name
            end
        end

        for unitnumber, name in pairs( datatable ) do
            savedtrains.number = savedtrains.number + 1

            local index = tostring( savedtrains.number )

            savedtrains.unitnumbers[index] = unitnumber
            savedtrains.dropdowns[index] = name
        end
    end

    if self.dropdown then
        self.dropdown.items = savedtrains.dropdowns
    end

    self.savedtrains = savedtrains
end

function trains:richtextreturn()
    local selected_index = self.dropdown.selected_index

    if selected_index > 0 then
        return "[train=" .. self.savedtrains.unitnumbers[tostring( selected_index )] .. "]"
    else
        self.player_char.print( { "Rich.CantAdd" } )

        return ""
    end
end

function trains:on_gui_click( event )
    local number = event.element.name:sub( 21, 22 )

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

return trains
local fonts = {}

fonts.metatable = { __index = fonts }

local dropdownselection =
{
    {
        "[font=compi]compi[/font]",
        "[font=compilatron-message-font]compilatron-message-font[/font]",
        "[font=count-font]count-font[/font]",
        "[font=default]default[/font]",
        "[font=default-bold]default-bold[/font]",
        "[font=default-dialog-button]default-dialog-button[/font]",
        "[font=default-dropdown]default-dropdown[/font]",
        "[font=default-game]default-game[/font]",
        "[font=default-large]default-large[/font]",
        "[font=default-large-bold]default-large-bold[/font]",
        "[font=default-large-semibold]default-large-semibold[/font]",
        "[font=default-listbox]default-listbox[/font]",
        "[font=default-semibold]default-semibold[/font]",
        "[font=default-small]default-small[/font]",
        "[font=default-small-bold]default-small-bold[/font]",
        "[font=default-small-semibold]default-small-semibold[/font]",
        "[font=default-tiny-bold]default-tiny-bold[/font]",
        "[font=heading-1]heading-1[/font]",
        "[font=heading-2]heading-2[/font]",
        "[font=heading-3]heading-3[/font]",
        "[font=locale-pick]locale-pick[/font]",
        "[font=scenario-message-dialog]scenario-message-dialog[/font]",
        "[font=technology-slot-level-font]technology-slot-level-font[/font]",
        "[font=var]var[/font]"
    },
    {
        "compi",
        "compilatron-message-font",
        "count-font",
        "default",
        "default-bold",
        "default-dialog-button",
        "default-dropdown",
        "default-game",
        "default-large",
        "default-large-bold",
        "default-large-semibold",
        "default-listbox",
        "default-semibold",
        "default-small",
        "default-small-bold",
        "default-small-semibold",
        "default-tiny-bold",
        "heading-1",
        "heading-2",
        "heading-3",
        "locale-pick",
        "scenario-message-dialog",
        "technology-slot-level-font",
        "var"
    }
}

function fonts.new( player )
    local module =
    {
        player = player,
        player_char = player.player
    }

    setmetatable( module, fonts.metatable )

    return module
end

function fonts:gui( parent )
    local titleflow = parent.add{ type = "flow", direction = "horizontal", style = "richtitlebarflow" }
    parent.add{ type = "line", direction = "horizontal", style = "richheadline" }
    local buttonflow = parent.add{ type = "flow", direction = "horizontal", style = "richbuttonflow" }

    titleflow.add{ type = "label", caption = { "Rich.Tab03Title" }, style = "richtitlelabel" }
    titleflow.add{ type = "empty-widget", style = "richwidget" }
    self.dropdown = titleflow.add{ type = "drop-down", items = dropdownselection[1] }
    buttonflow.add{ type = "button", name = "RICH_CLICK_19_fonts01", caption = { "Rich.AddBefore" }, style = "richstretchbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_19_fonts02", caption = { "Rich.AddAfter" }, style = "richstretchbutton" }
    buttonflow.add{ type = "button", name = "RICH_CLICK_19_fonts03", caption = { "Rich.Applyto" }, style = "richstretchbutton" }
end

function fonts:clear()
    self.dropdown = nil
end

function fonts:richtextreturn()
    local selected_index = self.dropdown.selected_index

    if selected_index > 0 then
        return "[font=" .. dropdownselection[2][selected_index] .. "]"
    else
        self.player_char.print( { "Rich.CantAdd" } )
        
        return ""
    end
end

function fonts:on_gui_click( event )
    local text = self:richtextreturn()

    if text:len() > 0 then
        local number = event.element.name:sub( 20, 21 )
        local richtext = self.player.richtext

        if number == "01" then
            richtext:update_text( text .. "[/font]" .. richtext.richfield.text )
        elseif number == "02" then
            richtext:update_text( richtext.richfield.text .. text .. "[/font]" )
        elseif number == "03" then
            richtext:update_text( text .. richtext.richfield.text .. "[/font]" )
        end
    end
end

return fonts
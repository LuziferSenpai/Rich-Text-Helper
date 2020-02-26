local UpdateText = require "scripts/Shared Functions".UpdateText
local AddPreset = require "scripts/Shared Functions".RichTextAddPreset
local de = defines.events
local Format = string.format
local script_data = {}

local ToggleDropDown = function( player_id )
    local gui = script_data.GUIS[player_id].B["02"]

    gui["03"].visible = not gui["03"].visible
    gui["04"].visible = not gui["04"].visible
    gui["05"].visible = not gui["05"].visible
    gui["06"].visible = not gui["06"].visible
end

local Click =
{
    ["RichButtonBGUI01"] = function( event )
        local player_id = event.player_index
        local gui = script_data.GUIS[player_id].B

        if gui["02"]["05"].visible then
            UpdateText( player_id, gui["03"]["06"].caption .. gui["03"]["10"].text )
        else
            game.players[player_id].print( { "Rich.CantAdd" } )
        end
    end,
    ["RichButtonBGUI02"] = function( event )
        local player_id = event.player_index
        local gui = script_data.GUIS[player_id].B

        if gui["02"]["05"].visible then
            UpdateText( player_id, gui["03"]["10"].text .. gui["03"]["06"].caption )
        else
            game.players[player_id].print( { "Rich.CantAdd" } )
        end
    end,
    ["RichButtonBGUI03"] = function( event )
        local player_id = event.player_index
        local gui = script_data.GUIS[player_id].B

        if gui["02"]["05"].visible then
            	UpdateText( player_id, gui["03"]["06"].caption )
        else
            game.players[player_id].print( { "Rich.CantAdd" } )
        end
    end,
    ["RichButtonBGUI04"] = function( event )
        UpdateText( event.player_index, "" )
    end,
    ["RichButtonBGUI05"] = function( event )
        local element = script_data.GUIS[event.player_index].B["03"]["10"]

        element.select_all()
        element.focus()
    end,
    ["RichButtonBGUI06"] = function( event )
        local player_id = event.player_index
        if script_data.GUIS[player_id].B["03"]["10"].text:len() > 0 then
            AddPreset( player_id )
        else
            game.players[player_id].print( { "Rich.NoRichText" } )
        end
    end,
    ["RichButtonBGUI07"] = function( event )
        local player_id = event.player_index
        local player = game.players[player_id]
        local gui = script_data.GUIS[player_id].B
        local text = gui["03"]["10"].text

        if text:len() > 0 then
            local elem_value = gui["03"]["19"].elem_value
            local tag =
            {
                position = player.position,
                text = text,
                last_user = player
            }

            if type( elem_value ) == "table" then
                tag.icon = elem_value
            end

            local currentposition = script_data.CurrentPosition[player_id]

            if next( currentposition ) and event.button == defines.mouse_button_type.right then
                tag.position = currentposition
            end

            player.force.add_chart_tag( player.surface, tag )
        else
            player.print( { "Rich.NoRichText" } )
        end
    end,
    ["RichButtonBGUI08"] = function( event )
        local player_id = event.player_index
        local player = game.players[player_id]
        local text = script_data.GUIS[player_id].B["03"]["10"].text

        if text:len() > 0 then
            local chat_color = player.chat_color

            game.print( "[color=" .. chat_color.r .. "," .. chat_color.g .. "," .. chat_color.b .. "]" .. player.name .. ": " .. text .. "[/color]" )
        else
            player.print( { "Rich.NoRichText" } )
        end
    end,
    ["RichButtonBGUI09"] = function( event )
        local player_id = event.player_index
        local player = game.players[player_id]
        local text = script_data.GUIS[player_id].B["03"]["10"].text

        if text:len() > 0 then
            local entity = script_data.SavedEntity[player_id]

            if next( entity ) then
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
    end,
    ["RichButtonBGUI10"] = function( event )
        local player_id = event.player_index
        local player = game.players[player_id]
        local text = script_data.GUIS[player_id].B["03"]["10"].text

        if text:len() > 0 then
            local boolean = remote.call( "LineName", "Change", player_id, text )

            if boolean then
                player.print( { "Rich.CircuitNotOpen" } )
            end
        else
            player.print( { "Rich.NoRichText" } )
        end
    end,
    ["RichButtonBGUI11"] = function( event )
        local player_id = event.player_index
        local player = game.players[player_id]
        local text = script_data.GUIS[player_id].B["03"]["10"].text

        if text:len() > 0 then
            local boolean = remote.call( "WirelessName", "Change", player_id, text )

            if boolean then
                player.print( { "Rich.WirelessNotOpen" } )
            end
        else
            player.print( { "Rich.NoRichText" } )
        end
    end,
    ["RichSpriteButtonBGUI01"] = function( event )
        local player_id = event.player_index
        local gui = script_data.GUIS[player_id].B["03"]
        local selected_index = gui["03"].selected_index

        if selected_index > 0 then
            local index_number = Format( "%02d", selected_index )
            local SavedRichTexts = script_data.SavedRichTexts[player_id]

            SavedRichTexts.RichTexts[index_number] = nil
            SavedRichTexts.RichTextNames[index_number] = nil

            script_data.SavedRichTexts[player_id] =
            {
                Number = 0,
                RichTexts = {},
                RichTextNames = {}
            }

            local Texts = SavedRichTexts.RichTexts

            if next( Texts ) then
                for entry, text in pairs( Texts ) do
                    AddPreset( player_id, "addcurrent", SavedRichTexts.RichTextNames[entry], text )
                end

                gui = script_data.GUIS[player_id].B["03"]
                selected_index = gui["03"].selected_index

                if selected_index == 0 then
                    gui["06"].caption = ""

                    ToggleDropDown( player_id )
                else
                    gui["06"].caption = script_data.SavedRichTexts[player_id].RichTexts[Format( "%02d", selected_index )]
                end
            else
                gui["03"].items = {}
                gui["06"].caption = ""

                ToggleDropDown( player_id )
            end
        else
            game.players[player_id].print( { "Rich.NothingSelected" } )
        end
    end
}

local Events =
{
    ["RichDropDownBGUI01"] = function( event )
        local player_id = event.player_index
        local gui = script_data.GUIS[player_id].B

        gui["03"]["06"].caption = script_data.SavedRichTexts[player_id].RichTexts[Format( "%02d", event.element.selected_index )]

        if not gui["02"]["03"].visible then
            ToggleDropDown( player_id )
        end
    end,
    ["RichTextFieldBGUI01"] = function( event )
        local player_id = event.player_index
        local text = event.element.text

        script_data.GUIS[player_id].B["03"]["13"].caption = text

        if not next( script_data.SavedEntity[player_id] ) then
            script_data.CurrentRichText[player_id] = text
        end
    end
}

--Events
local on_gui_click = function( event )
    if event.element.valid then
        local click = Click[event.element.name]

        if click then
            click( event )
        end
    end
end

local on_gui_event = function( event )
    local events = Events[event.element.name]

    if events then
        events( event )
    end
end

local lib = {}

lib.events =
{
   [de.on_gui_click] = on_gui_click,
   [de.on_gui_selection_state_changed] = on_gui_event,
   [de.on_gui_text_changed] = on_gui_event
}

lib.on_init = function()
    script_data = global.script_data
end

lib.on_load = function()
    script_data = global.script_data
end

lib.on_configuration_changed = function( event )
    local changes = event.mod_changes or {}
    
    if next( changes ) then
        script_data = global.script_data
    end

    local circuitchanges = changes["Simple_Circuit_Trains"] or {}
    local wirelesschanges = changes["Wireless_Circuit_Network"] or {}

    if next( circuitchanges ) then
        local visible = false

        if circuitchanges.new_version then
            visible = true
        end

        for _, p in pairs( game.players ) do
            if next( script_data.GUIS[p.index] ) then
                script_data.GUIS[p.index].B["03"]["23"].visible = visible
            end
        end
    end

    if next( wirelesschanges ) then
        local visible = false

        if wirelesschanges.new_version then
            visible = true
        end

        for _, p in pairs( game.players ) do
            if next( script_data.GUIS[p.index] ) then
                script_data.GUIS[p.index].B["03"]["24"].visible = visible
            end
        end
    end
end

return lib
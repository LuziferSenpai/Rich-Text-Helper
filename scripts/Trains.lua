local de = defines.events
local Format = string.format
local script_data = {}

local richtextreturn = function( player_id )
    local selected_index = script_data.GUIS[player_id].G["02"]["03"].selected_index

    if selected_index > 0 then
        return "[train=" .. script_data.SavedTrains[player_id].UnitNumbers[Format( "%03d", selected_index )] .. "]"
    else
        game.players[player_id].print( { "Rich.CantAdd" } )

        return ""
    end
end

local Update = function( player_id )
    local player = game.players[player_id]
	local force = player.force
	local datatable = {}
	local sorttable = {}
	local SavedTrains =
	{
		Number = 0,
		UnitNumbers = {},
		BackerNames = {}
	}
	local index_number = 0

	for _, surface in pairs( game.surfaces ) do
		local trains = surface.get_trains( force )

		if next( trains ) then
			for _, train in pairs( trains ) do
				local locomotives = train.locomotives

				if next( locomotives.back_movers ) then
					for _, locomotive in pairs( locomotives.back_movers ) do
						datatable[locomotive.backer_name] = locomotive.unit_number

						table.insert( sorttable, locomotive.backer_name )
					end
				end

				if next( locomotives.front_movers ) then
					for _, locomotive in pairs( locomotives.front_movers ) do
						datatable[locomotive.backer_name] = locomotive.unit_number

						table.insert( sorttable, locomotive.backer_name )
					end
				end
			end
		end
	end

	if next( sorttable ) then
		table.sort( sorttable )

		for _, name in pairs( sorttable ) do
			SavedTrains.Number = SavedTrains.Number + 1

			if SavedTrains.Number < 1000 then
				index_number = Format( "%03d", SavedTrains.Number )

				SavedTrains.UnitNumbers[index_number] = datatable[name]
				SavedTrains.BackerNames[index_number] = name
			else
				player.print( { "Rich.PresetsError1000" } )

				return
			end
		end
	end

	script_data.GUIS[player_id].G["02"]["03"].items = SavedTrains.BackerNames
    script_data.SavedTrains[player_id] = SavedTrains
end

Click =
{
    ["RichButtonGGUI01"] = function( event )
        local player_id = event.player_index
        local richtext = richtextreturn( player_id )

        if richtextreturn ~= "" then
            script_data.UpdateText( player_id, richtext .. script_data.GUIS[player_id].B["03"]["10"].text )
        end
    end,
    ["RichButtonGGUI02"] = function( event )
        local player_id = event.player_index
        local richtext = richtextreturn( player_id )

        if richtextreturn ~= "" then
            script_data.UpdateText( player_id, script_data.GUIS[player_id].B["03"]["10"].text .. richtext )
        end
    end,
    ["RichSpriteButtonGGUI01"] = function( event )
        Update( event.player_index )
    end
}

--Events
local on_gui_click = function( event )
    local click = Click[event.element.name]

    if click then
        click( event )
    end
end

local lib = {}

lib.events =
{
    [de.on_gui_click] = on_gui_click
}

lib.on_init = function()
    script_data = global.script_data

    script_data.TrainUpdate = Update
end

lib.on_load = function()
    script_data = global.script_data
end

lib.on_configuration_changed = function( event )
    local changes = event.mod_changes or {}

    if next( changes ) then
		script_data = global.script_data

		script_data.TrainUpdate = Update
    end
end

return lib
require "mod-gui"

local GUI = require "GUI"
local de = defines.events
local mod_button_flow = mod_gui.get_button_flow
local script_data = {}

local MainGUIToggle = function( player_id )
	local player = game.players[player_id]
	local screen = player.gui.screen

	if screen.RichFrameAGUI01 then
		local gui = script_data.GUIS[player_id].A["01"]

		gui.visible = not gui.visible
	else
		local gui = GUI.Main( screen )

		gui["01"].location = script_data.Position[player_id]

		script_data.GUIS[player_id].A = gui

		local gui2 = GUI.RichText( gui["01"] )

		gui2["03"]["03"].items = script_data.SavedRichTexts[player_id].RichTextNames
		gui2["03"]["10"].text = script_data.CurrentRichText[player_id]
		gui2["03"]["13"].caption = script_data.CurrentRichText[player_id]

		script_data.GUIS[player_id].B = gui2

		script_data.GUIS[player_id].C = GUI.Tab01( gui["04"]["08"] )

		script_data.GUIS[player_id].D = GUI.Tab02( gui["04"]["09"] )

		script_data.ColorUpdate( player_id, "" )

		script_data.GUIS[player_id].E = GUI.Tab03( gui["04"]["10"] )

		local gui3 = GUI.Tab04( gui["04"]["11"] )

		gui3["02"]["03"].items = script_data.SavedGPS[player_id].PositionNames

		script_data.GUIS[player_id].F = gui3

		script_data.GUIS[player_id].G = GUI.Tab05( gui["04"]["12"] )

		script_data.TrainUpdate( player_id )

		script_data.GUIS[player_id].H = GUI.Tab06( gui["04"]["13"] )

		script_data.TrainStopUpdate( player_id )

		script_data.GUIS[player_id].I = GUI.Tab07( gui["04"]["14"] )

		if script_data.Reset[player_id] then
			script_data.Reset[player_id] = false

			local SavedColors = script_data.SavedColors[player_id]

			script_data.SavedColors[player_id] =
			{
				Number = 0,
				Colors = {},
				ColorNames = {}
			}

			local Colors = SavedColors.Colors

			if next( Colors ) then
				for entry, color in pairs( Colors ) do
					script_data.ColorAddPreset( player_id, "addcurrent", SavedColors.ColorNames[entry], color )
				end
			end
		end
	end
end

local Click =
{
	["RichButton"] = function( event )
		MainGUIToggle( event.player_index )
	end,
	["RichSpriteButtonAGUI01"] = function( event )
		script_data.GUIS[event.player_index].A["01"].visible = false
	end
}

local PlayerStart = function( player_id )
	local player = game.players[player_id]

	local button_flow = mod_button_flow( player )

	if not button_flow.RichButton then
		local b = GUI.AddSpriteButton( button_flow, "RichButton", "utility/rename_icon_normal" )

		b.visible = not settings.get_player_settings( player )["Rich-Hide-Button"].value
	end

	script_data.CurrentHEX[player_id] = script_data.CurrentHEX[player_id] or "#000000"
	script_data.CurrentPosition[player_id] = script_data.CurrentPosition[player_id] or {}
	script_data.CurrentRichText[player_id] = script_data.CurrentRichText[player_id] or ""
	script_data.GUIS[player_id] = script_data.GUIS[player_id] or {}
	script_data.Position[player_id] = script_data.Position[player_id] or { x = 5, y = 85 * player.display_scale }
	script_data.Reset[player_id] = script_data.Reset[player_id] or false
	script_data.SavedColors[player_id] = script_data.SavedColors[player_id] or
	{
		Number = 0,
		Colors = {},
		ColorNames = {}
	}
	script_data.SavedEntity[player_id] = script_data.SavedEntity[player_id] or {}
	script_data.SavedGPS[player_id] = script_data.SavedGPS[player_id] or
	{
		Number = 0,
		Positions = {},
		PositionNames = {}
	}
	script_data.SavedRichTexts[player_id] = script_data.SavedRichTexts[player_id] or
	{
		Number = 0,
		RichTexts = {},
		RichTextNames = {}
	}
	script_data.SavedTrains[player_id] = script_data.SavedTrains[player_id] or
	{
		Number = 0,
		UnitNumbers = {},
		BackerNames = {}
	}
	script_data.SavedTrainStops[player_id] = script_data.SavedTrainStops[player_id] or
	{
		Number = 0,
		UnitNumbers = {},
		BackerNames = {}
	}
end

local PlayerLoad = function()
	for _, player in pairs( game.players ) do
		PlayerStart( player.index )
	end
end

--Events
local on_gui_click = function( event )
	local click = Click[event.element.name]

	if click then
		click( event )
	end
end

local on_gui_location_changed = function( event )
	local element = event.element

	if element.name == "RichFrameAGUI01" then
		script_data.Position[event.player_index] = element.location
	end
end

local on_player_created = function( event )
	PlayerStart( event.player_index )
end

local on_player_removed = function( event )
	local player_id = event.player_index

	script_data.CurrentHEX[player_id] = nil
	script_data.CurrentPosition[player_id] = nil
	script_data.CurrentRichText[player_id] = nil
	script_data.GUIS[player_id] = nil
	script_data.Position[player_id] = nil
	script_data.Reset[player_id] = nil
	script_data.SavedColors[player_id] = nil
	script_data.SavedEntity[player_id] = nil
	script_data.SavedGPS[player_id] = nil
	script_data.SavedRichTexts[player_id] = nil
	script_data.SavedTrains[player_id] = nil
	script_data.SavedTrainStops[player_id] = nil
end

local on_runtime_mod_setting_changed = function( event )
	if event.setting == "Rich-Hide-Button" then
		local player = game.players[event.player_index]
		local gui = mod_button_flow( player ).RichButton

		if gui then
			gui.visible = not settings.get_player_settings( player )["Rich-Hide-Button"].value
		end
	end
end

local lib = {}

lib.events =
{
	[de.on_gui_click] = on_gui_click,
	[de.on_gui_location_changed] = on_gui_location_changed,
	[de.on_player_created] = on_player_created,
	[de.on_player_removed] = on_player_removed,
	[de.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed,
	["RichGUI"] = function( event )
		local player_id = event.player_index
		local player = game.players[player_id]

		MainGUIToggle( player_id )

		if script_data.GUIS[player_id].A["01"].visible then
			local selected = player.selected

			if type( selected ) == "table" then
				if selected.supports_backer_name() then
					script_data.SavedEntity[player_id] = selected

					script_data.UpdateText( player_id, selected.backer_name )
				else
					player.print( { "Rich.NoBackerName" } )
				end
			end
		end
	end,
	["RichBacker"] = function( event )
		local player_id = event.player_index
		local player = game.players[player_id]
		local text = script_data.GUIS[player_id].B["03"]["10"].text

		if text:len() > 0 then
			local selected = player.selected

			if type( selected ) == "table" then
				if selected.supports_backer_name() then
					selected.backer_name = text
				else
					player.print( { "Rich.NoBackerName" } )
				end
			else
				player.print( { "Rich.NoEntitySelected" } )
			end
		else
			player.print( { "Rich.NoRichText" } )
		end
	end
}

lib.on_init = function()
	script_data = global.script_data

	PlayerLoad()
end

lib.on_load = function()
	script_data = global.script_data
end

lib.on_configuration_changed = function( event )
	local changes = event.mod_changes or {}

	if next( changes ) then
		script_data = global.script_data

		PlayerLoad()
	end
end

return lib
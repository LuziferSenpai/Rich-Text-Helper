if script.active_mods["debugadapter"] then require('__debugadapter__/debugadapter.lua') end

local handler = require "event_handler"

local script_data =
{
	CurrentHEX = {},
	CurrentPosition = {},
	CurrentRichText = {},
	GUIS = {},
	Position = {},
	Reset = {},
	SavedColors = {},
	SavedEntity = {},
	SavedGPS = {},
	SavedRichTexts = {},
	SavedTrains = {},
	SavedTrainStops = {}
}

local lib = {}

lib.on_init = function()
	global.script_data = global.script_data or script_data
end

lib.on_load = function()
	script_data = global.script_data or script_data
end

lib.on_configuration_changed = function( event )
	local changes = event.mod_changes or {}

	if next( changes ) then
		global.script_data = global.script_data or script_data

		local richchanges = changes["Rich_Text_Helper"] or {}

		if next( richchanges ) then
			local oldversion = richchanges.old_version

			if oldversion and richchanges.new_version then
				if oldversion <= "0.0.2" then
					for _, p in pairs( game.players ) do
						local player_id = p.index

						if next( global.GUIS[player_id] ) then
							local screen = p.gui.screen
							screen.RichFrame01.destroy()
							global.Reset[player_id] = true
							global.GUIS[player_id] = {}
						end
					end
				end

				if oldversion <= "0.0.4" then
					for _, p in pairs( game.players ) do
						if next( global.GUIS[p.index] ) then
							global.GUIS[p.index].A["01"].destroy()
							global.GUIS[p.index] = {}
							global.Reset[p.index] = true
						end
					end
				end

				if oldversion <= "0.1.0" then
					for _, p in pairs( game.players ) do
						if next( global.GUIS[p.index] ) then
							if not p.gui.screen.RichFrameAGUI01 then
								global.GUIS[p.index] = {}
								global.Reset[p.index] = true
							end
						end
					end
				end

				if oldversion <= "0.1.2" then
					for _, p in pairs( game.players ) do
						if next( global.GUIS[p.index] ) then
							global.GUIS[p.index].A["01"].destroy()
							global.GUIS[p.index] = {}
							global.Reset[p.index] = true
						end
					end
				end

				if oldversion <= "0.3.0" then
					script_data.CurrentHEX = global.CurrentHEX
					script_data.CurrentPosition = global.CurrentPosition
					script_data.CurrentRichText = global.CurrentRichText
					script_data.GUIS = global.GUIS
					script_data.Position = global.Position
					script_data.Reset = global.Reset
					script_data.SavedColors = global.SavedColors
					script_data.SavedEntity = global.SavedEntity
					script_data.SavedGPS = global.SavedGPS
					script_data.SavedRichTexts = global.SavedRichTexts
					script_data.SavedTrains = global.SavedTrains
					script_data.SavedTrainStops = global.SavedTrainStops

					global.CurrentHEX = nil
					global.CurrentPosition = nil
					global.CurrentRichText = nil
					global.GUIS = nil
					global.Position = nil
					global.Reset = nil
					global.SavedColors = nil
					global.SavedEntity = nil
					global.SavedGPS = nil
					global.SavedRichTexts = nil
					global.SavedTrains = nil
					global.SavedTrainStops = nil

					for _, p in pairs( game.players ) do
						if next( script_data.GUIS[p.index] ) then
							script_data.GUIS[p.index].A["01"].destroy()
							script_data.GUIS[p.index] = {}
							script_data.Reset[p.index] = true
						end
					end
				end
			end
		end
	end
end

local libs =
{
	["01"] = lib,
	["02"] = require "scripts/Main",
	["03"] = require "scripts/Rich Text",
	["04"] = require "scripts/Types",
	["05"] = require "scripts/Colors",
	["06"] = require "scripts/Fonts",
	["07"] = require "scripts/GPS",
	["08"] = require "scripts/Trains",
	["09"] = require "scripts/Train Stops",
	["10"] = require "scripts/Settings",
	["11"] = require "scripts/Shared Functions".lib
}

handler.add_libraries( libs )
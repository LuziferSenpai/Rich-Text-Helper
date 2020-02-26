local de = defines.events
local Format = string.format
local script_data = {}

local CheckMulti = function( event )
    script_data.Multi = game.is_multiplayer()

    if script_data.Multi then
        for _, p in pairs( game.players ) do
            if next( script_data.GUIS[p.index] ) then
                script_data.GUIS[p.index].A["04"]["08"].visible = true
            end
        end
    else
        for _, p in pairs( game.players ) do
            if next( script_data.GUIS[p.index] ) then
                script_data.GUIS[p.index].A["04"]["08"].visible = false
            end
        end
    end
end

local Click =
{

}

local Events =
{

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
    [de.on_player_joined_game] = CheckMulti
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
end

return lib
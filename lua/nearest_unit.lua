function wesnoth.wml_actions.nearest_unit(cfg)
    local starting_x = tonumber(cfg.starting_x) or wml.error("Missing required starting_x in [nearest_unit]")
    local starting_y = tonumber(cfg.starting_y) or wml.error("Missing required starting_y in [nearest_unit]")
    local filter = (wml.get_child(cfg, "filter")) or wml.error("Missing required [filter] in [nearest_unit]")
    local variable = cfg.variable or "nearest_unit" -- default

    local current_distance = math.huge -- feed it the biggest value possible
    local nearest_unit_found

    for index,unit in ipairs(wesnoth.units.find_on_map(filter)) do
        local distance = wesnoth.map.distance_between( starting_x, starting_y, unit.x, unit.y )
        if distance < current_distance then
            current_distance = distance
            nearest_unit_found = unit
        end
    end

    if nearest_unit_found then
        wesnoth.wml_actions.store_unit( { variable = variable, { "filter", { id = nearest_unit_found.id } } } )
    else wesnoth.interface.add_chat_message( "WML", "No suitable unit found by [nearest_unit]" )
    end
end
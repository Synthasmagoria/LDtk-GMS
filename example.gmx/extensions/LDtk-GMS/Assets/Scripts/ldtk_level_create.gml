/// ldtk_level_create(world, level, world_data, level_data, lua_state)->ds_list
var world = argument0, level = argument1, world_data = argument2, level_data = argument3, lua_state = argument4;

// Create all tiles
var _tile_layers = ds_map_find_value(level_data, "tile_layers"),
_tile_layer;
for (var i = 0, n = ds_list_size(_tile_layers); i < n; i++)
{
    _tile_layer = ds_list_find_value(_tile_layers, i);
    ldtk_create_tiles(
        ldtk_level_get_world_x(level),
        ldtk_level_get_world_y(level),
        ds_map_find_value(_tile_layer, "tiles"),
        ds_map_find_value(_tile_layer, "grid"),
        ds_map_find_value(_tile_layer, "depth"),
        ds_map_find_value(_tile_layer, "background"));
}

var _level_instance = ds_list_create();

// Create all instances
ldtk_instdata_create_instances(
    ds_map_find_value(level_data, "light_instances"),
    _level_instance);

ldtk_instdata_create_instances_variable(
    ds_map_find_value(level_data, "instances"),
    _level_instance,
    lua_state);

// Execute room start script
var _room_start_script = ds_map_find_value(level_data, "room_start_script");
if (_room_start_script != -1)
    script_execute(_room_start_script);

return _level_instance;

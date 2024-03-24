/// ldtk_world_get_tileset_data(world, world_data_out)
var world = argument0, world_data_out = argument1;

/*
    Puts a map of tileset definitions into world data with their respective uid as key
*/

var
_definitions = __ldtk_iutil_ds_get(world, "defs", "tilesets"),
_definition,
_data = ds_map_find_value(world_data_out, "tileset_data"),
_tileset_data;

for (var i = 0, n = ds_list_size(_definitions); i < n; i++)
{
    _definition = ds_list_find_value(_definitions, i);
    _tileset_data = ds_map_create();
    ds_map_add(_tileset_data, "background", __ldtk_iutil_asset_get_index_type(ds_map_find_value(_definition, "identifier"), asset_background));
    ds_map_add(_tileset_data, "grid", ds_map_find_value(_definition, "tileGridSize"));
    ds_map_add_map(_data, ds_map_find_value(_definition, "uid"), _tileset_data);
}

global.world_data_out = world_data_out;

/// ldtk_layer_prepare_tilemap_instances(world, level, layer, world_data, level_data_out)
var world = argument0, level = argument1, layer = argument2, world_data = argument3, level_data_out = argument4;

// TODO: Review the fuck out of this code
var _definition = ldtk_def_find_by_uid(world, "tilesets", ds_map_find_value(layer, "__tilesetDefUid"));

if (_definition == -1)
{
    show_debug_message(
        "LDtk log: Layer '" +
        string(ds_map_find_value(layer, "__identifier")) +
        "' did not specify a valid tileset (uid: " +
        string(ds_map_find_value(layer, "__tilesetDefUid")) +
        " does not exist)");
    exit;
}

var _custom_data = ds_map_find_value(
    ds_map_find_value(world_data, "tileset_custom_data"),
    ds_map_find_value(_definition, "identifier"));

if (is_undefined(_custom_data))
{
    exit;
}

var
_tiles = ds_map_find_value(layer, "gridTiles"),
_wxoff = ldtk_level_get_world_x(level),
_wyoff = ldtk_level_get_world_y(level),
_light_instances_out = ds_map_find_value(level_data_out, "light_instances"),
_custom_data_instance;

var _tile_definition, _inst, _x, _y, _x_src, _y_src, _tile_id;

for (var i = 0, n = ds_list_size(_tiles); i < n; i++)
{
    _tile_definition = ds_list_find_value(_tiles, i);
    _tile_id = ds_map_find_value(_tile_definition, "t");
    _custom_data_instance = ds_list_find_value(_custom_data, _tile_id);
    
    if (_custom_data_instance != undefined)
    {
        ds_list_add(_light_instances_out, ldtk_instdata_create_light(
                ds_list_find_value(ds_map_find_value(_tile_definition, "px"), 0) + _wxoff,
                ds_list_find_value(ds_map_find_value(_tile_definition, "px"), 1) + _wyoff,
                1,
                1,
                ds_map_find_value(_custom_data_instance, "object_index"))); // Not marked for deletion since this resource is reference counted
    }
}

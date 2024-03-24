/// ldtk_tiles_layer_get_background(layer, world_data)->background
var layer = argument0, world_data = argument1;
// TODO: Find a way for this function to be less confusing in regards to usage with intgrid layers

var _background_data = ds_map_find_value(
    ds_map_find_value(world_data, "tileset_data"),
    ds_map_find_value(layer, "__tilesetDefUid"));

if (_background_data == undefined)
{
    show_debug_message(string(ds_map_find_value(layer, "__tilesetDefUid")) + " uhuh? interesting");
    return -1;
}

return ds_map_find_value(_background_data, "background");

/// ldtk_layer_prepare_tile_layer(layer, dpth, world_data, level_data_out)
var layer = argument0, dpth = argument1, world_data = argument2, level_data_out = argument3;

var _tileset_data = ds_map_find_value(
    ds_map_find_value(world_data, "tileset_data"),
    ds_map_find_value(layer, "__tilesetDefUid"));

if (_tileset_data == undefined)
{
    // NOTE: There's an LDtk log printed before this point that says something about the missing tileset
    // show_debug_message("LDtk log: Tile layer '" + ds_map_find_value(layer, "__identifier") + "' didn't have a tileset and was therefore skipped");
    exit;
}

if (ds_map_find_value(_tileset_data, "background") == -1)
{
    // NOTE: Since tiles can be used to add instances to a room, the identifier not corresponding to a background resources should not be considered a warning
    show_debug_message(
        "LDtk log: Tile layer '" +
        ds_map_find_value(layer, "__identifier") +
        "'s identifier didn't correspond with a background resource name, and was therefore not used as a tileset");
    exit;
}

var _tile_layer = ds_map_create();
ds_map_add(_tile_layer, "depth", dpth);
ds_map_add(_tile_layer, "background", ds_map_find_value(_tileset_data, "background"));
ds_map_add(_tile_layer, "grid", ds_map_find_value(_tileset_data, "grid"));
ds_map_add(_tile_layer, "tiles", ldtk_tiles_layer_get_tile_list(layer)); // NOTE: See ldtk_level_data_create

__ldtk_iutil_ds_list_add_map(
    ds_map_find_value(level_data_out, "tile_layers"),
    _tile_layer);

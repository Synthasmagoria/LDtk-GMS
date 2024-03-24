/// ldtk_tile_layer_get_tile_list(layer)
var layer = argument0;
var _layer_type = ds_map_find_value(layer, "__type");
switch (ds_map_find_value(layer, "__type"))
{
    case "Tiles":
        return ds_map_find_value(layer, "gridTiles");
        break;
    case "IntGrid":
    case "AutoLayer":
        return ds_map_find_value(layer, "autoLayerTiles");
        break;
    default:
        show_debug_message(
            "LDtk error: Couldn't find tile list in layer instance named " +
            ds_map_find_value(layer, "__identifier"));
        return -1;
        break;
}

/// ldtk_intgrid_layer_has_tiles(layer)->bool
var layer = argument0;
return !is_undefined(ds_map_find_value(layer, "__tilesetDefUid"));

/// ldtk_world_get_level_count(world)->real
var world = argument0;
return ds_list_size(ds_map_find_value(world, "levels"));

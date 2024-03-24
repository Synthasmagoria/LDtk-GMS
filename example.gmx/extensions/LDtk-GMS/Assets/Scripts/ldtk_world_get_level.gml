/// ldtk_world_get_level(world, index)->ds_map
var world = argument0, index = argument1;
if (index >= 0 && index < ldtk_world_get_level_count(world))
    return ds_list_find_value(ds_map_find_value(world, "levels"), index);
else
    return -1;

/// ldtk_is_instance_in_level(level, inst)->bool
var level = argument0, inst = argument1;

return point_in_rectangle(
    inst.x,
    inst.y,
    ds_map_find_value(level, "worldX"),
    ds_map_find_value(level, "worldY"),
    ds_map_find_value(level, "worldX") + ds_map_find_value(level, "pxWid"),
    ds_map_find_value(level, "worldY") + ds_map_find_value(level, "pxHei"));

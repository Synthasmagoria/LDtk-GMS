/// ldtk_find_level_by_position(levels, xx, yy)->real
var levels = argument0, xx = argument1, yy = argument2;

var _level, _wx, _wy;
for (var i = 0, n = ds_list_size(levels); i < n; i++)
{
    _level = ds_list_find_value(levels, i);
    _wx = ds_map_find_value(_level, "worldX");
    _wy = ds_map_find_value(_level, "worldY");
    if (point_in_rectangle(xx, yy, _wx, _wy, _wx + ds_map_find_value(_level, "pxWid"), _wy + ds_map_find_value(_level, "pxHei")))
    {
        return i;
    }
}

show_debug_message("LDtk log: Couldn't find a level at x:" + string(xx) + ", y:" + string(yy));
return -1;

/// ldtk_def_find_by_uid(world, def_type, uid)->ds_map
var world = argument0, def_type = argument1, uid = argument2;

// TODO: This function is inefficient and shouldn't be used lol
var _defs = ds_map_find_value(ds_map_find_value(world, "defs"), def_type);
var _def;
for (var i = 0, n = ds_list_size(_defs); i < n; i++)
{
    _def = ds_list_find_value(_defs, i);
    if (ds_map_find_value(_def, "uid") == uid)
    {
        return _def;
    }
}

return -1;

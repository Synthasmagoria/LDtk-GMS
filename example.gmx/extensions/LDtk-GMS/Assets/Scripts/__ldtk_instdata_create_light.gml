/// __ldtk_instdata_create_light()->ds_map

/*
    Returns the data that should be used to create
    non-configurable instances
*/

var _inst = ds_map_create();
ds_map_add(_inst, "x", 0);
ds_map_add(_inst, "y", 0);
ds_map_add(_inst, "image_xscale", 1);
ds_map_add(_inst, "image_yscale", 1);
ds_map_add(_inst, "object_index", -1);
return _inst;

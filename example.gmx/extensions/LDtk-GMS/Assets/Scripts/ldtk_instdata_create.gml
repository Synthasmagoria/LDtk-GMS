/// ldtk_instdata_create(xx, yy, xscl, yscl, obj_ind, code)
/// ldtk_instdata_create
var xx = argument0, yy = argument1, xscl = argument2, yscl = argument3, obj_ind = argument4, code = argument5;
var _inst = ds_map_create();
ds_map_add(_inst, "x", xx);
ds_map_add(_inst, "y", yy);
ds_map_add(_inst, "image_xscale", xscl);
ds_map_add(_inst, "image_yscale", yscl);
ds_map_add(_inst, "object_index", obj_ind);
ds_map_add(_inst, "creation_code", code);
ds_map_add_list(_inst, "instance_variables", ds_list_create());
return _inst;

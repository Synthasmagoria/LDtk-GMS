/// ldtk_instdata_create_light(xx, yy, xscl, yscl, obj_ind)->ds_map
var xx = argument0, yy = argument1, xscl = argument2, yscl = argument3, obj_ind = argument4;
global.__ldtkgms_instance_pool_index = (global.__ldtkgms_instance_pool_index + 1) % LDTKGMS_CONSTS.INSTANCE_POOL_SIZE;
var _inst = global.__ldtkgms_instance_pool[global.__ldtkgms_instance_pool_index];
ds_map_set(_inst, "x", xx);
ds_map_set(_inst, "y", yy);
ds_map_set(_inst, "image_xscale", xscl);
ds_map_set(_inst, "image_yscale", yscl);
ds_map_set(_inst, "object_index", obj_ind);
return _inst;

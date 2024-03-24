/// ldtk_instdata_ext_add_local_var(inst_data, name, value)
var inst_data = argument0, name = argument1, value = argument2;

// Adds a local variable to an instdata_ext map

var _local_variables = ds_map_find_value(inst_data, "instance_variables");
var _local_variable = ds_map_create();
ds_map_add(_local_variable, "name", name);
ds_map_add(_local_variable, "value", value);
__ldtk_iutil_ds_list_add_map(_local_variables, _local_variable);

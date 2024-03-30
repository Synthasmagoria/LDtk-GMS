/// ldtk_instdata_create_instances_variable(instances, lvinst_out, lua_state)
var instances = argument0, lvinst_out = argument1, lua_state = argument2;

var _inst_data, _inst, _local_variables, _local_variable;
for (var i = 0, n = ds_list_size(instances); i < n; i++)
{
    _inst_data = ds_list_find_value(instances, i);
    var _inst = instance_create(
        ds_map_find_value(_inst_data, "x"),
        ds_map_find_value(_inst_data, "y"),
        ds_map_find_value(_inst_data, "object_index"));
    _inst.image_xscale = ds_map_find_value(_inst_data, "image_xscale");
    _inst.image_yscale = ds_map_find_value(_inst_data, "image_yscale");
    
    // Setting id allows the instance to reference itself in its creation code
    lua_global_set(lua_state, "id", _inst);
    lua_add_code(lua_state, ds_map_find_value(_inst_data, "creation_code"));
    
    _local_variables = ds_map_find_value(_inst_data, "instance_variables");
    for (var ii = 0; ii < ds_list_size(_local_variables); ii++)
    {
        _local_variable = ds_list_find_value(_local_variables, ii);
        variable_instance_set(
            _inst,
            ds_map_find_value(_local_variable, "name"),
            ds_map_find_value(_local_variable, "value"));
    }
    
    ds_list_add(lvinst_out, _inst);
}

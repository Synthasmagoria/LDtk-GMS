/// ldtk_instdata_create_instances(instances, lvinst_out)
var instances = argument0, lvinst_out = argument1;

var _inst_data, _inst;
for (var i = 0, n = ds_list_size(instances); i < n; i++)
{
    _inst_data = ds_list_find_value(instances, i);
    var _inst = instance_create(
        ds_map_find_value(_inst_data, "x"),
        ds_map_find_value(_inst_data, "y"),
        ds_map_find_value(_inst_data, "object_index"));
    _inst.image_xscale = ds_map_find_value(_inst_data, "image_xscale");
    _inst.image_yscale = ds_map_find_value(_inst_data, "image_yscale");
    
    ds_list_add(lvinst_out, _inst);
}

/// ldtk_layer_get_intgrid_instances(level, layer, world_data, level_data_out)
var level = argument0, layer = argument1, world_data = argument2, level_data_out = argument3;

// TODO: Support multiple intgrid values (also counting ones that don't have objects tied to them)

/*
    Creates a list where the index corresponds to intgrid values + 1
    Within a list there's another list of instance data
    Adds the list of instances to the layer_instances map in level_data_out
*/

var
_intgrid_data = ds_map_find_value(layer, "intGridCsv"),
_grid_width = ds_map_find_value(layer, "__cWid"),
_grid_size = ds_map_find_value(layer, "__gridSize"),
_wxoff = ldtk_level_get_world_x(level),
_wyoff = ldtk_level_get_world_y(level),
_objects = __ldtk_iutil_ds_get(world_data, "intgrid_objects", ds_map_find_value(layer, "__identifier")),
_light_instances_out = ds_map_find_value(level_data_out, "light_instances"),
_x,
_y;

var _inst, _value, _start, _object, _instances = ds_list_create();

// Create instances and stretch horizontally
for (var i = 0, n = ds_list_size(_intgrid_data); i < n; i++)
{
    _value = ds_list_find_value(_intgrid_data, i);
    _object = ds_list_find_value(_objects, _value - 1);
    
    if (_value > 0 && _object != undefined && _object != -1) // <- make sure this value can't also be '.1'
    {
        _value = ds_list_find_value(_intgrid_data, i);
        _start = i;
        _x = (i % _grid_width) * _grid_size + _wxoff;
        _y = floor(i / _grid_width) * _grid_size + _wyoff;
        
        while (
            i + 1 < n &&
            (i % _grid_width) < ((i + 1) % _grid_width) &&
            _value == ds_list_find_value(_intgrid_data, i + 1))
        {
            i++;
        }
        
        ds_list_add(_instances, ldtk_instdata_create_light(_x, _y, i - _start + 1, 1, _object)); // Not reference counted because this reference is pooled
    }
}

// Stretch instances downwards into other instances and remove
var _inst_2, _bottom, _yscale;
for (var i = 0, n = ds_list_size(_instances); i < n; i++)
{
    for (var ii = i + 1; ii < n; ii++)
    {
        _inst = ds_list_find_value(_instances, i);
        _inst_2 = ds_list_find_value(_instances, ii);
        
        _yscale = ds_map_find_value(_inst, "image_yscale");
        _bottom = ds_map_find_value(_inst, "y") + sprite_get_height(object_get_sprite(ds_map_find_value(_inst, "object_index"))) * _yscale;
        
        if (ds_map_find_value(_inst, "x") == ds_map_find_value(_inst_2, "x") &&
            ds_map_find_value(_inst, "object_index") && ds_map_find_value(_inst_2, "object_index") &&
            _bottom == ds_map_find_value(_inst_2, "y") &&
            ds_map_find_value(_inst, "image_xscale") == ds_map_find_value(_inst_2, "image_xscale"))
        {
            ds_map_set(_inst, "image_yscale", _yscale + 1);
            ds_list_delete(_instances, ii);
            n--;
            ii--;
        }
        else if (_bottom < ds_map_find_value(_inst_2, "y"))
        {
            // Break out of the loop when checking against instances lower bbox_bottom+1
            break;
        }
    }
}

for (var i = 0, n = ds_list_size(_instances); i < n; i++)
    ds_list_add(_light_instances_out, ds_list_find_value(_instances, i)); // Not reference counted because this reference is pooled
ds_list_destroy(_instances);

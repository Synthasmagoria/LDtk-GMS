/// ldtk_world_get_intgrid_objects(world, world_data_out)
var world = argument0, world_data_out = argument1;

/*
    This function creates a map where the key corrsponds to IntGrid layer identifiers
    Each of those contains a list where the index corresponds to the IntGrid value - 1 and
    the value in the list corresponds to an object or -1 if the identifier of the value doesn't correspond to an object
*/

var
_intgrid_objects = ds_map_find_value(world_data_out, "intgrid_objects"),
_layer_definitions = __ldtk_iutil_ds_get(world, "defs", "layers"),
_layer_definition,
_value_definition;

for (var i = 0, n = ds_list_size(_layer_definitions); i < n; i++)
{
    _layer_definition = ds_list_find_value(_layer_definitions, i);
    
    if (ds_map_find_value(_layer_definition, "type") == "IntGrid")
    {
        var _int_grid_values = ds_map_find_value(_layer_definition, "intGridValues");
        var _objects = ds_list_create();
        __ldtk_iutil_ds_list_resize(_objects, ds_list_size(_int_grid_values), -1);
        var _object_name, _object;
        
        for (var ii = 0, nn = ds_list_size(_int_grid_values); ii < nn; ii++)
        {
            _value_definition = ds_list_find_value(_int_grid_values, ii);
            _object_name = ds_map_find_value(_value_definition, "identifier");
            if (!is_string(_object_name))
            {
                show_debug_message(
                    "LDtk log: Identifier of intgrid value " +
                    string(ds_map_find_value(_value_definition, "value")) +
                    " on layer " +
                    ds_map_find_value(_layer_definition, "identifier") +
                    " has not been set and is therefore skipped")
                continue;
            }
            
            _object = __ldtk_iutil_asset_get_index_type(_object_name, asset_object);
            
            if (_object == -1)
            {
                show_debug_message(
                    "LDtk log: Identifier of intgrid value " +
                    string(ds_map_find_value(_value_definition, "value")) +
                    " on layer " +
                    ds_map_find_value(_layer_definition, "identifier") +
                    " (" +
                    _object_name +
                    ") doesn't correspond to an object name and has therefore been skipped");
                continue;
            }
            
            ds_list_set(
                _objects,
                ds_map_find_value(_value_definition, "value") - 1,
                _object);
        }
        
        ds_map_add_list(_intgrid_objects, __ldtk_iutil_ds_get(_layer_definition, "identifier"), _objects);
    }
}

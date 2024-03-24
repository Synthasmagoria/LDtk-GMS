/// ldtk_level_prepare_field_data(level, level_data_out)
var level = argument0, level_data_out = argument1;
var _field_instances = ds_map_find_value(level, "fieldInstances");
var _field_instance, _identifier;

for (var i = 0, n = ds_list_size(_field_instances); i < n; i++)
{
    _field_instance = ds_list_find_value(_field_instances, i);
    _identifier = ds_map_find_value(_field_instance, "__identifier");
    
    switch (_identifier)
    {
        case "room_start_script":
        {
            var _room_start_script_name = ds_map_find_value(_field_instance, "__value");
            
            if (_room_start_script_name == undefined)
            {
                show_debug_message("LDtk log: Undefined room start script name");
                continue;
            }
            
            var _room_start_script = __ldtk_iutil_asset_get_index_type(_room_start_script_name, asset_script);
            
            if (_room_start_script == -1)
            {
                show_debug_message(
                    "LDtk log: No room start script called " +
                    _room_start_script_name +
                    " found for level " +
                    ds_map_find_value(level, "identifier"));
                continue;
            }
            
            ds_map_set(level_data_out, "room_start_script", _room_start_script);
        }
        break;
        
        case "tile_layer_depth_start":
        {
            var _tile_layer_depth_start = ds_map_find_value(_field_instance, "__value");
            
            if (_tile_layer_depth_start == undefined)
            {
                show_debug_message("LDtk log: Undefined tile layer depth start");
                continue;
            }
            
            ds_map_set(level_data_out, "tile_layer_depth_start", _tile_layer_depth_start);
        }
        break;
        
        case "tile_layer_depth_increment":
        {
            var _tile_layer_depth_increment = ds_map_find_value(_field_instance, "__value");
            
            if (_tile_layer_depth_increment == undefined)
            {
                show_debug_message("LDtk log: Undefined tile layer depth increment");
                continue;
            }
            
            ds_map_set(level_data_out, "tile_layer_depth_increment", _tile_layer_depth_increment);
        }
        break;
    }
}

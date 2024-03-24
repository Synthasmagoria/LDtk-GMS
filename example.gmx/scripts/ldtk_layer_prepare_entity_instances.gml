/// ldtk_layer_get_entity_instances(level, layer, world_data, level_data_out)
var level = argument0, layer = argument1, world_data = argument2, level_data_out = argument3;

/*
    This function adds a list to the map in 'optimization_out' with layer identifier as key
    The list contains all configurable_instance maps that can be passed to ldtk_instdata_create_instances_variable_instances
*/

// TODO: Consider making the entity identifier the object name
var
_entity_fields = ds_map_find_value(world_data, "entity_fields"),
_entities = ds_map_find_value(layer, "entityInstances"),
_wxoff = ldtk_level_get_world_x(level),
_wyoff = ldtk_level_get_world_y(level),
_level_instances_out = ds_map_find_value(level_data_out, "instances");

var _entity, _entity_identifier, _entity_field_data, _entity_field_instances;
var _object_index_field_index, _object, _object_name;
var _creation_code_field_index, _creation_code;
var _inst_data;

for (var i = 0, n = ds_list_size(_entities); i < n; i++)
{
    _entity = ds_list_find_value(_entities, i);
    _entity_identifier = ds_map_find_value(_entity, "__identifier");
    _entity_field_data = ds_map_find_value(_entity_fields, _entity_identifier);
    
    // NOTE: This code verifies that the object index has been set for the instance
    _object_index_field_index = ds_map_find_value(_entity_field_data, "object_index_field_index");
    
    if (is_undefined(_object_index_field_index))
    {
        show_debug_message("LDtk log (" + _entity_identifier + "): object_index field did not exist, skipping");
        continue;
    }
    
    _entity_field_instances = ds_map_find_value(_entity, "fieldInstances");
    _object_name = ds_map_find_value(
        ds_list_find_value(_entity_field_instances, _object_index_field_index),
        "__value");
    
    if (is_undefined(_object_name) || _object_name == "")
    {
        show_debug_message("LDtk warning (" + _entity_identifier + "): no object name specified in object_index");
        continue;
    }
    
    _object = __ldtk_iutil_asset_get_index_type(_object_name, asset_object);
    
    if (_object == -1)
    {
        show_debug_message("LDtk warning (" + _entity_identifier + "): object with name " + _object_name + " doesn't exist");
        continue;
    }
    
    // NOTE: This code verifies that creation code has been set for the instance
    _creation_code_field_index = ds_map_find_value(_entity_field_data, "creation_code_field_index");
    
    if (is_undefined(_creation_code_field_index))
    {
        _creation_code = "";
    }
    else
    {
        _creation_code = ds_map_find_value(
            ds_list_find_value(_entity_field_instances, _creation_code_field_index),
            "__value");
        
        if (is_undefined(_creation_code))
            _creation_code = "";
    }
    
    // Create and instdata structure with the set information
    _inst_data = ldtk_instdata_create(
        ds_list_find_value(ds_map_find_value(_entity, "px"), 0) + _wxoff,
        ds_list_find_value(ds_map_find_value(_entity, "px"), 1) + _wyoff,
        ds_map_find_value(_entity, "width") / sprite_get_width(object_get_sprite(_object)),
        ds_map_find_value(_entity, "height") / sprite_get_height(object_get_sprite(_object)),
        _object,
        _creation_code);
    
    var _instance_variable_fields = ds_map_find_value(_entity_field_data, "instance_variable_field_indices");
    var _field_index;
    for (var ii = 0, nn = ds_list_size(_instance_variable_fields); ii < nn; ii++)
    {
        _field_index = ds_list_find_value(_instance_variable_fields, ii);
        ldtk_instdata_add_variable(
            _inst_data,
            ds_map_find_value(ds_list_find_value(_entity_field_instances, _field_index), "__identifier"),
            ds_map_find_value(ds_list_find_value(_entity_field_instances, _field_index), "__value"));
    }
    
    __ldtk_iutil_ds_list_add_map(_level_instances_out, _inst_data);
}

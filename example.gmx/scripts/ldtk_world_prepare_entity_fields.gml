/// ldtk_world_get_entity_fields(world, world_data_out)
var world = argument0, world_data_out = argument1;

/*
    Creates a map where the keys correspond to entity identifier names
    Each entry has a map with the following values:
    - The index of the object index in the entity field list ("object_index_field_index")
    - A list of indices pointing to the local variables in the entity field list ("instance_variable_field_indices")
*/

var _entity_fields = ds_map_find_value(world_data_out, "entity_fields");

var _entity_definitions = __ldtk_iutil_ds_get(world, "defs", "entities");
for (var i = 0, n = ds_list_size(_entity_definitions); i < n; i++)
{
    var _entity_definition = ds_list_find_value(_entity_definitions, i);
    var _field_definitions = ds_map_find_value(_entity_definition, "fieldDefs");
    var _object_index_field_index = undefined; // TODO: Evaluate if this should be undefined by default
    var _creation_code_field_index = undefined; // <- This makes it mandatory to have doesn't it?
    var _instance_variable_field_indices = ds_list_create();
    
    for (var ii = 0, nn = ds_list_size(_field_definitions); ii < nn; ii++)
    {
        var _field_definition = ds_list_find_value(_field_definitions, ii);
        var _field_identifier = ds_map_find_value(_field_definition, "identifier");
        
        switch (_field_identifier)
        {
            case "object_index":
                _object_index_field_index = ii;
                break;
            case "creation_code":
                _creation_code_field_index = ii;
                break;
            default:
                ds_list_add(_instance_variable_field_indices, ii);
                break;
        }
    }
    
    var _entity_field_definition = ds_map_create();
    ds_map_add(_entity_field_definition, "object_index_field_index", _object_index_field_index);
    ds_map_add(_entity_field_definition, "creation_code_field_index", _creation_code_field_index);
    ds_map_add_list(_entity_field_definition, "instance_variable_field_indices", _instance_variable_field_indices);
    ds_map_add_map(_entity_fields, ds_map_find_value(_entity_definition, "identifier"), _entity_field_definition);
}

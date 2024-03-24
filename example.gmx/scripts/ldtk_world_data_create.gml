/// ldtk_world_data_structure_create()->ds_map
var _data = ds_map_create();
    // For every intgrid layer there are values. The identifiers of those values can correspond to object names. Those are saved in this map.
    /*"intgrid_objects":
    {
        "<layer identifier>": [<object_index>, ...]
    }*/
    ds_map_add_map(_data, "intgrid_objects", ds_map_create());
    
    // Really this is just a map containing the object index for the tile in case it is supposed to be mapped to an object
    // TODO: Simplify this by turning it into a single value thing
    /*{
        "<tileset identifier>": [<object_index>, ...]
    }*/
    ds_map_add_map(_data, "tileset_custom_data", ds_map_create());
    
    // Field index refers to indices in the list of entity instance parameters in level data
    /*{
        "<entity identifier>":
        {
            "instance_variable_field_indices": [],
            "object_index_field_index": 0,
            "creation_code_field_index": 0
        } ...
    }*/
    ds_map_add_map(_data, "entity_fields", ds_map_create());
    
    // All the tileset definitions in the project
    /*"tileset_definitions":
    {
        "<tileset uid>":
        {
            "background": <background resource index>
            "grid": <tileset grid size>
        }
    }*/
    ds_map_add_map(_data, "tileset_data", ds_map_create());

return _data;

/// ldtk_level_prepare(world, level, world_data)->ds_map
var world = argument0, level = argument1, world_data = argument2;

var _level_data = ldtk_level_data_create();

ldtk_level_prepare_field_data(level, _level_data);

var
_layers = ds_map_find_value(level, "layerInstances"),
_layer,
_tile_depth_increment = ds_map_find_value(_level_data, "tile_layer_depth_increment"),
_tile_depth = ds_map_find_value(_level_data, "tile_layer_depth_start");

for (var i = 0, n = ds_list_size(_layers); i < n; i++)
{
    _layer = ds_list_find_value(_layers, i);
    
    switch (ds_map_find_value(_layer, "__type"))
    {
        case "IntGrid":
        ldtk_layer_prepare_intgrid_instances(level, _layer, world_data, _level_data);
        if (ldtk_intgrid_layer_has_tiles(_layer))
        {
            ldtk_layer_prepare_tile_layer(_layer, _tile_depth, world_data, _level_data);
            _tile_depth += _tile_depth_increment;
        }
        break;
        
        case "Tiles":
        ldtk_layer_prepare_tilemap_instances(world, level, _layer, world_data, _level_data);
        ldtk_layer_prepare_tile_layer(_layer, _tile_depth, world_data, _level_data);
        _tile_depth += _tile_depth_increment;
        break;
        
        case "AutoLayer":
        ldtk_layer_prepare_tile_layer(_layer, _tile_depth, world_data, _level_data);
        _tile_depth += _tile_depth_increment;
        break;
        
        case "Entities":
        ldtk_layer_prepare_entity_instances(level, _layer, world_data, _level_data);
        break;
    }
}

return _level_data;

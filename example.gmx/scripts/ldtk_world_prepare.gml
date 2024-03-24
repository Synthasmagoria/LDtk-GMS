/// ldtk_world_prepare(world)->ds_map
var world = argument0;

var _world_data = ldtk_world_data_create();
ldtk_world_prepare_intgrid_objects(world, _world_data);
ldtk_world_prepare_tileset_data(world, _world_data);
ldtk_world_prepare_tileset_custom_data(world, _world_data);
ldtk_world_prepare_entity_fields(world, _world_data);
return _world_data;

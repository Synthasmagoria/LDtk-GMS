/// ldtk_level_data_structure_create()->ds_map

/*
    *** = This is a resource borrowed from the ldtk world file.
    It is not marked as a data structure by using [ds_list/ds_map]_add_[list/map] when added in the preparation function
    This is done so on purpose to prevent the resource from being freed prematurely
*/

var _data = ds_map_create();
    // A list of all instances without creation code to spawn (from intgrid and tile layers)
    /*[
        {
            "x":
            "y":
            "image_xscale":
            "image_yscale":
            "object_index":
        }
    ]*/
    ds_map_add_list(_data, "light_instances", ds_list_create());
    
    // A list of all instances with creation code to spawn (from entity layers)
    /*[
        {
            < same as light_instances >
            "instance_variables"
            [
                {
                    "name": <name of the instance variable
                    "value": <value of the instance variable
                }
            ]
        }
    ]*/
    ds_map_add_list(_data, "instances", ds_list_create());
    
    // Maps containing tile layer depth values and references to the ldtk tile data lists associated with them
    ds_map_add_list(_data, "tile_layers", ds_list_create());
    /*[
        {
            "tiles": <reference to the tile data list in the ldtk world list>
            "depth": <depth value calculated by using level tile depth fields>,
            "grid": <grid size of the tileset>
            "background": <background resource of the tile layer> ***
        }
    ]*/
    
    // The asset index for the script to be called at room start
    ds_map_add(_data, "room_start_script", -1);
    
    // TODO: Deprecate this // The tile depth of the first ldtk tile layer / auto layer / intgrid w tiles
    ds_map_add(_data, "tile_layer_depth_start", -50);
    
    // TODO: Deprecate this // The amount the depth will change for every subsequent tile layer / auto layer / intgrid w tiles
    ds_map_add(_data, "tile_layer_depth_increment", 100);

return _data;

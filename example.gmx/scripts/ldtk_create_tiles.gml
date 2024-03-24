/// ldtk_create_tiles(xx, yy, tile_list, grid, _depth, background)
var xx = argument0, yy = argument1, tile_list = argument2, grid = argument3, _depth = argument4, background = argument5;

var i, _tile, _tile_data, _flip;

i = 0;

repeat (ds_list_size(tile_list))
{
    _tile_data = ds_list_find_value(tile_list, i);
    _flip = ds_map_find_value(_tile_data, "f");
    _tile = tile_add(
        background,
        ds_list_find_value(ds_map_find_value(_tile_data, "src"), 0),
        ds_list_find_value(ds_map_find_value(_tile_data, "src"), 1),
        grid,
        grid,
        ds_list_find_value(ds_map_find_value(_tile_data, "px"), 0) + grid * __ldtk_iutil_int_get_bit(_flip, 0) + xx,
        ds_list_find_value(ds_map_find_value(_tile_data, "px"), 1) + grid * __ldtk_iutil_int_get_bit(_flip, 1) + yy,
        _depth);
    
    tile_set_scale(_tile, 1 - __ldtk_iutil_int_get_bit(_flip, 0) * 2, 1 - __ldtk_iutil_int_get_bit(_flip, 1) * 2);
    
    i++;
}

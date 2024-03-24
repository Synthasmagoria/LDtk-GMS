/// ldtk_world_get_tileset_custom_data(world, world_data_out)
var world = argument0, world_data_out = argument1;

/*
    Returns a map with tileset identifiers as keys
    Below it lies an object_index field that corresponds to an object index
    If the tileset doesn't have custom data then it is not included in the map
*/

var
_tileset_custom_data = ds_map_find_value(world_data_out, "tileset_custom_data"),
_tileset_definitions = ds_map_find_value(ds_map_find_value(world, "defs"), "tilesets");

for (var i = 0, n = ds_list_size(_tileset_definitions); i < n; i++)
{
    var _tileset_definition = ds_list_find_value(_tileset_definitions, i);
    var _tileset_identifier = ds_map_find_value(_tileset_definition, "identifier");
    var _tileset_data = ds_map_find_value(_tileset_definition, "customData");
    var _data = ds_list_create();
    __ldtk_iutil_ds_list_resize(_data, ds_map_find_value(_tileset_definition, "__cWid") * ds_map_find_value(_tileset_definition, "__cHei"), undefined);
    var _custom_data_text, _custom_data, _tile_id, _obj, _valid_custom_data_exists = false;
    
    for (var ii = 0, nn = ds_list_size(_tileset_data); ii < nn; ii++)
    {
        _custom_data_text = -1;
        _custom_data = -1;
        _tile_id = -1;
        _obj = -1;
        
        _custom_data_text = ds_map_find_value(ds_list_find_value(_tileset_data, ii), "data");
        
        if (_custom_data_text == "" || _custom_data_text == undefined)
        {
            show_debug_message("LDtk log: No custom data for tile id " + string(_tile_id) + " in tileset " + _tileset_identifier);
            continue;
        }
        
        _tile_id = ds_map_find_value(ds_list_find_value(_tileset_data, ii), "tileId");
        _custom_data = json_decode(_custom_data_text);
        
        if (_custom_data == -1)
        {
            show_debug_message(
                "LDtk error: Couldn't read JSON in custom data for tile id " +
                string(_tile_id) +
                " in tileset " +
                _tileset_identifier);
            continue;
        }
        
        if (is_undefined(ds_map_find_value(_custom_data, "object_index")))
        {
            // TODO: Figure out what custom data fields are mandatory
            show_debug_message(
                "LDtk error: Custom data for tile id " +
                string(_tile_id) +
                " in tileset " +
                _tileset_identifier +
                " doesn't define object_index");
            continue;
        }
        
        _obj = __ldtk_iutil_asset_get_index_type(ds_map_find_value(_custom_data, "object_index"), asset_object);
        
        if (_obj == -1)
        {
            show_debug_message(
                "LDtk error: object_index field in custom data for tile id " +
                string(_tile_id) +
                " in tileset " +
                _tileset_identifier +
                " doesn't contain a valid object_name (" + ds_map_find_value(_custom_data, "object_index") + ")");
            continue;
        }
        
        // TODO: Get local variable fields from json
        
        _valid_custom_data_exists |= true;
        
        ds_map_set(_custom_data, "object_index", _obj);
        ds_list_set(_data, _tile_id, _custom_data);
    }
    
    if (_valid_custom_data_exists)
        ds_map_add_list(_tileset_custom_data, _tileset_identifier, _data);
    else
        ds_list_destroy(_data);
}

#define asset_get_index_type
/// asset_get_index_type(name, type)
var name = argument0, type = argument1;

var _asset = asset_get_index(name);

switch (type)
{
    case asset_object: if (object_exists(_asset)) return _asset; break;
    case asset_sprite: if (sprite_exists(_asset)) return _asset; break;
    case asset_sound: if (sound_exists(_asset)) return _asset; break;
    case asset_room: if (room_exists(_asset)) return _asset; break;
    case asset_background: if (background_exists(_asset)) return _asset; break;
    case asset_path: if (path_exists(_asset)) return _asset; break;
    case asset_script: if (script_exists(_asset)) return _asset; break;
    case asset_font: if (font_exists(_asset)) return _asset; break;
    case asset_timeline: if (timeline_exists(_asset)) return _asset; break;
}

return -1;

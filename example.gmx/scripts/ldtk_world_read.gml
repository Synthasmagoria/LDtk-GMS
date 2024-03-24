/// ldtk_world_read(path)->ds_map
var path = argument0;

var _path = working_directory + global.__ldtkgms_worlds_directory + "/" + path;

var _f = file_text_open_read(_path);

if (_f == -1)
{
    show_debug_message("LDtk warning: .ldtk file at '" + _path + "' doesn't exist");
    return -1;
}

var _text_buffer = buffer_create(1, buffer_grow, 1);

while (!file_text_eof(_f))
{
    buffer_write(_text_buffer, buffer_text, file_text_readln(_f));
}

file_text_close(_f);

buffer_seek(_text_buffer, buffer_seek_start, 0);

var _json_string = buffer_read(_text_buffer, buffer_text);
buffer_delete(_text_buffer);

var _world = json_decode(_json_string);

if (_world == -1)
{
    show_debug_message("LDtk warning: file at '" + _path + "' contains invalid json");
}

return _world;

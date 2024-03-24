/// ldtk_write_debug_structure(map, name)
var map = argument0, name = argument1;
var _f = file_text_open_write(name + ".json");
file_text_write_string(_f, json_encode(map));
file_text_close(_f);

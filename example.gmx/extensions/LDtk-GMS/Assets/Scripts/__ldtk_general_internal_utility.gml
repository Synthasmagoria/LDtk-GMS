#define __ldtk_general_internal_utility
/// ldtk_general_internal_utility(placeholder0, placeholder1, placeholder2, placeholder3, placeholder4)
var placeholder0 = argument0, placeholder1 = argument1, placeholder2 = argument2, placeholder3 = argument3, placeholder4 = argument4;
/*
	Because of the way "multi-scripts" work this needs to be here so that the next script
	can be referre to by the right name
*/

#define __ldtk_iutil_asset_get_index_type
/// __ldtk_iutil_asset_get_index_type(name, type)
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

#define __ldtk_iutil_string_rpos
/// __ldtk_iutil_string_rpos(substr,str)
//
//  Returns the right-most position of a substring within a string.
//
//      substr      substring of text, string
//      str         string of text, string
//
/// GMLscripts.com/license
{
    var sub,str,pos,ind;
    sub = argument0;
    str = argument1;
    pos = 0;
    ind = 0;
    do {
        pos += ind;
        ind = string_pos(sub,str);
        str = string_delete(str,1,ind);
    } until (ind == 0);
    return pos;
}

#define __ldtk_iutil_string_get_filename_from_path
/// __ldtk_iutil_string_get_filename_from_path(path, keep_extension)->string
var path = argument0, keep_extension = argument1;
/*
    This script will extract the file name from a path
    "C:/example_directory/file_name.txt" -> "file_name"
*/

var _filename_start = __ldtk_iutil_string_rpos("/", path) + 1;
if (keep_extension)
    return string_copy(path, _filename_start, 90000);
else
    return string_copy(path, _filename_start, __ldtk_iutil_string_rpos(".", path) - _filename_start);

#define __ldtk_iutil_string_get_directory_from_path
/// __ldtk_iutil_string_get_directory_from_path(path)->string
var path = argument0;
return string_copy(path, 0, __ldtk_iutil_string_rpos("/", path));

#define __ldtk_iutil_int_get_bit
///__ldtk_iutil_int_get_bit(int, ind)
return (argument0 >> argument1) & 1;

#define __ldtk_iutil_file_text_open_read_all_strings
/// __ldtk_iutil_file_text_open_read_all_strings(path)
var path = argument0;
var _f = file_text_open_read(path);

if (_f == -1)
{
    show_debug_message("LDtk warning: .ldtk file at '" + path + "' doesn't exist");
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
return _json_string;

#define __ldtk_iutil_ds_list_resize
/// __ldtk_iutil_ds_list_resize(list, size, ...)
var list = argument[0], size = argument[1];

var value = 0;

if (argument_count > 2)
{
    value = argument[2];
}

var _difference = abs(ds_list_size(list) - size);

if (ds_list_size(list) < size)
{
    repeat (_difference)
    {
        ds_list_add(list, value);
    }
}
else
{
    repeat (_difference)
    {
        ds_list_delete(list, ds_list_size(list) - 1);
    }
}

#define __ldtk_iutil_ds_list_add_map
/// __ldtk_iutil_ds_list_add_map(src, map)
var src = argument0, map = argument1;
ds_list_add(src, map);
ds_list_mark_as_map(src, ds_list_size(src) - 1);

#define __ldtk_iutil_ds_list_add_list
/// __ldtk_iutil_ds_list_add_list(src, list)
var src = argument0, list = argument1;
ds_list_add(src, list);
ds_list_mark_as_list(src, ds_list_size(src) - 1);

#define __ldtk_iutil_ds_get
/// __ldtk_iutil_ds_get(l_val, ...)
var l_val = argument[0];
var l_ind = 0;
repeat (argument_count - 1) {
	var l_key = argument[++l_ind];
	if (is_string(l_key)) {
		l_val = ds_map_find_value(l_val, l_key);
	} else if (is_real(l_key) || is_int32(l_key) || is_int64(l_key) || is_bool(l_key)) {
		l_val = ds_list_find_value(l_val, l_key);
	} else {
		show_error(string(l_key) + "(argument[" + string(l_ind) + "]) is not a valid index.", true);
	}
}
return l_val;

#define __ldtk_iutil_color_to_int
/// __ldtk_iutil_color_to_int(color, alpha)
var color = argument0, alpha = argument1;
var _int = int64(0);
_int |= int64(color_get_blue(color));
_int |= int64(color_get_red(color)) << 8;
_int |= int64(color_get_green(color)) << 16;
_int |= int64(clamp(alpha, 0, 1) * 255) << 24;
return _int;

#define __ldtk_iutil_draw_text_outline
/// __ldtk_iutil_draw_text_outline(xx, yy, str, col, ocol)
var xx = argument0, yy = argument1, str = argument2, col = argument3, ocol = argument4;
var xx = argument0;
var yy = argument1;
var str = argument2;
var textColor = argument3;
var outlineColor = argument4;

//draw the text outline
draw_set_color(ocol);
draw_text(xx-1,yy+1,str);
draw_text(xx-1,yy,str);
draw_text(xx-1,yy-1,str);
draw_text(xx+1,yy+1,str);
draw_text(xx+1,yy,str);
draw_text(xx+1,yy-1,str);
draw_text(xx,yy+1,str);
draw_text(xx,yy-1,str);

//draw the text itself
draw_set_color(col);
draw_text(xx,yy,str);
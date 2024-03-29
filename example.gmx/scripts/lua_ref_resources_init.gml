/// lua_ref_resources_init(q)
var q = argument0;
var i;
for (i = 0; sprite_exists(i); i++) {
    lua_global_set(q, sprite_get_name(i), i);
}
for (i = 0; object_exists(i); i++) {
    lua_global_set(q, object_get_name(i), i);
}
for (i = 0; sound_exists(i); i++) {
    lua_global_set(q, sound_get_name(i), i);
}
for (i = 0; room_exists(i); i++) {
    lua_global_set(q, room_get_name(i), i);
}
for (i = 0; path_exists(i); i++) {
    lua_global_set(q, path_get_name(i), i);
}
for (i = 0; script_exists(i); i++) {
    lua_add_function(q, script_get_name(i), i);
}

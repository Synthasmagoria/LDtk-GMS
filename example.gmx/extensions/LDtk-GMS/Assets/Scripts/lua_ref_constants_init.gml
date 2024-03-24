#define lua_ref_constants_init
/// lua_ref_constants_init(q)
var q = argument0;
_lua_ref_constants_color_init(q);

#define _lua_ref_constants_color_init
/// _lua_ref_constants_color_init(q)
var q = argument0;
lua_global_set(q, "c_aqua", c_aqua);
lua_global_set(q, "c_black", c_black);
lua_global_set(q, "c_blue", c_blue);
lua_global_set(q, "c_dkgray", c_dkgray);
lua_global_set(q, "c_fuchsia", c_fuchsia);
lua_global_set(q, "c_gray", c_gray);
lua_global_set(q, "c_green", c_green);
lua_global_set(q, "c_lime", c_lime);
lua_global_set(q, "c_ltgray", c_ltgray);
lua_global_set(q, "c_maroon", c_maroon);
lua_global_set(q, "c_navy", c_navy);
lua_global_set(q, "c_olive", c_olive);
lua_global_set(q, "c_purple", c_purple);
lua_global_set(q, "c_red", c_red);
lua_global_set(q, "c_silver", c_silver);
lua_global_set(q, "c_teal", c_teal);
lua_global_set(q, "c_white", c_white);
lua_global_set(q, "c_yellow", c_yellow);
lua_global_set(q, "c_orange", c_orange);
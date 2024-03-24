#define lua_ref_variable_instance_init
/// ref_variable_instance_init(q)
var q = argument0;
lua_add_function(q, "variable_instance_get", _lua_ref_variable_instance_get);
lua_add_function(q, "variable_instance_set", _lua_ref_variable_instance_set);
lua_add_code(q, '-- ref_variable_instance_init()
    __idfields = __idfields or { };
    debug.setmetatable(0, {
        __index = function(self, name)
            if (__idfields[name]) then
                return _G[name];
            else
                return variable_instance_get(self, name);
            end
        end,
        __newindex = variable_instance_set,
    })
');

#define _lua_ref_variable_instance_set
/// _lua_ref_variable_instance_set(context, name, value)
var q = argument0, s = argument1, v = argument2, n = 0;
with (q) { variable_instance_set(id, s, v); n++; }
if (n) exit;
if (q < 100000) {
    lua_show_error("Couldn't find any instances of " + string(q) + " (" + object_get_name(q) + ")");
} else lua_show_error("Couldn't find instance " + string(q));

#define _lua_ref_variable_instance_get
/// _lua_ref_variable_instance_get(q, s)
var q = argument0, s = argument1;
with (q) return variable_instance_get(id, s);
if (q < 100000) {
    lua_show_error("Couldn't find any instances of " + string(q) + " (" + object_get_name(q) + ")");
} else lua_show_error("Couldn't find instance " + string(q));
return undefined;
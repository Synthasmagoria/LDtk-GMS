/// scrMakeTriggerable(_inst, trg_id, hspd, vspd)
var _inst = argument0, trg_id = argument1, hspd = argument2, vspd = argument3;
with (objTrigger) {
    show_debug_message(trigger_id + " : " + trg_id);
    if (trigger_id == trg_id) {
        ds_list_add(inst, _uinst);
        ds_list_add(hs, hspd);
        ds_list_add(vs, vspd);
    }
}
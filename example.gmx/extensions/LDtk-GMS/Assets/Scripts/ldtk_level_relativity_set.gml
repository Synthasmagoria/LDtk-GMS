/// ldtk_level_relativity_set(val)
/*
    This variable decides whether levels are spawned at 0,0 coordinates
    or at their world position as defined in the LDtk file
    
    Use cases:
    true = used when spawning levels to test and iterate using objLdtkWorldManager
    false = used when generating gamemaker room files using ldtk_generate_rooms
*/
global.__ldtkgms_level_create_relative = argument0;

/// ldtk_init(world_directory, player_object, player_kill_script)
var world_directory = argument0, player_object = argument1, player_kill_script = argument2;

enum LDTKGMS_CONSTS
{
    INSTANCE_POOL_SIZE = 3000
}

global.__ldtkgms_intialized = false;

global.__ldtkgms_player_object = player_object;

// This is the script that will be called when the player exits the level bounds
// NOTE: Cannot have arguments
global.__ldtkgms_player_kill_script = player_kill_script;

// NOTE: This is only used to generate the save.bat and generate rooms
global.__ldtkgms_project_directory = "";

// NOTE: This variable needs to be initialized in able for LDtk to find the worlds directory
global.__ldtkgms_worlds_directory = world_directory;

if (!directory_exists(global.__ldtkgms_worlds_directory))
{
    show_error("LDtk error: World's directory folder not found in included files at path '" + global.__ldtkgms_worlds_directory + "'", true);
}

var _config_json_example = "{
" + chr(34) + "project_directory" + chr(34) + ": <absolute project directory path in quotes>
" + chr(34) + "worlds_directory" + chr(34) + ": <relative world directory path in quotes>
}";

if (!file_exists("ldtkgms_config.json"))
{
    show_debug_message(
        "LDtk warning: Couldn't find ldtkgms_config.json in your project
Please create the file in the root of your included files
The content of ldtkgms_config.json should be as follows:
" + _config_json_example);
}
else
{
    var _config = json_decode(__ldtk_iutil_file_text_open_read_all_strings("ldtkgms_config.json"));
    
    if (_config == -1)
    {
        show_debug_message("LDtk error: ldtkgms_config.json in included files did not contain valid json
You might have forgotten to change your backslashes (" + chr(92) + ") into forwardslashes (" + chr(47) + ")
The content of ldtkgms_config.json should be as follows:
" + _config_json_example);
    }
    else
    {
        global.__ldtkgms_project_directory = ds_map_find_value(_config, "project_directory");
        if (global.__ldtkgms_project_directory == undefined)
        {
            show_error("LDtk error: No project directory was specified in ldtkgms_config.json. Please specify it by creating a
" + chr(34) + "project_directory" + chr(34) + " name-value pair with the absolute path to the gamemaker project on your computer", true);
            global.__ldtkgms_project_directory = "";
            exit;
        }
        else if (global.__ldtkgms_project_directory == "")
        {
            show_error("LDtk error: No project directory was specified in ldtkgms_config.json", true);
            exit;
        }
        else if (!directory_exists_ns(global.__ldtkgms_project_directory))
        {
            show_error("LDtk error: Project directory in ldtkgms_config.json does not point to a valid directory", true);
        }
    }
}

// NOTE: This variable is only for generating world and level data.
// It does not affect the spawning of the left after the preparation functions.
global.__ldtkgms_level_create_relative = true;

// NOTE: In code this means that when these structures are appended to level_data maps it should be done without marking them as maps
// Example: Using ds_map_add instead ds_map_add_map
// Initialize pooled maps for instance spawning
global.__ldtkgms_instance_pool = array_create(LDTKGMS_CONSTS.INSTANCE_POOL_SIZE);

for (var i = 0; i < LDTKGMS_CONSTS.INSTANCE_POOL_SIZE; i++)
{
    global.__ldtkgms_instance_pool[i] = __ldtk_instdata_create_light();
}

global.__ldtkgms_instance_pool_index = 0;



ldtk_generate_save_bat();

global.__ldtkgms_intialized = true;

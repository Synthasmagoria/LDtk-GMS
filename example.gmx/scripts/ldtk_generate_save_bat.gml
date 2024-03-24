/// ldtk_generate_save_bat()
/*
    Every time you compile and run your gamemaker project from within the editor
    it generates a new folder in a temp directory on your machine from which to run it.
    In order to update your LDtk levels while the game is running, you'll have to update
    the levels in this generated directory.
    This script creates a .bat file which you can tell your LDtk projects execute upon every save
    by setting up a path to it in: Project Settings -> Custom Commands -> Run after saving.
*/

if (global.__ldtkgms_project_directory == "")
{
    show_debug_message("LDtk warning: Couldn't generate save.bat because project directory was not set");
    exit;
}

var _included_files_dir = global.__ldtkgms_project_directory + "/datafiles";

var _bat = file_text_open_write_ns(_included_files_dir + "/" + global.__ldtkgms_worlds_directory + "/save.bat", -1);
if (_bat == -1)
{
    show_debug_message("LDtk log: Couldn't open to write bat file at location: " + _included_files_dir);
    exit;
}

// NOTE: json does not easily work with backslashes so this safety-conversion might be redundant
// cmd works with backslashes, so convert those forward slashes into backslashes
var _inc_dir_forward = string_replace_all(_included_files_dir, "/", "\");
var _world_dir_forward = string_replace_all(global.__ldtkgms_worlds_directory, "/", "\");

file_text_write_line_ns(
    _bat,
    "Xcopy " +
    chr(34) + _inc_dir_forward + chr(92) + _world_dir_forward + chr(34) +
    " " +
    chr(34) + working_directory + chr(92) + _world_dir_forward + chr(34) +
    " /y /c /q");

file_text_close_ns(_bat);

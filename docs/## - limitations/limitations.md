# Limitations

## Instance order
Note that instance order in a room loaded using ldtk-gms does not work the same as a Gamemaker room.
If you can avoid relying on instance order it will not be a problem.

## Lua to GML conversion when generating rooms
It is totally possible to take full advantage of all of Lua's features in entity instance creation code. However, ldtk_generate_rooms doesn't actually convert the Lua code to GML. It simply puts it into creation code as is.

This is fine for setting variables or calling scripts, but anything that requires Lua specific syntax such as if statements will reqiure you to do the conversion manually once you've generated the rooms.

To illustrate:
```lua
id.hspeed = 1.0;
```
Is completely valid GML creation code that does the same as `hspeed = 1.0;`. And works in Lua because LDtk sets the global variable "id" to the instance id that the creation code belongs to.

This code will work in LDtk-gms creation code. However, it will not work once the world is converted to rooms and the code is run as GML because the "then" and "end" keywords the same way in Lua as they do in GML.
```lua
if scrGetImportantVariable() == 5 then
    id.hspeed = 1.0;
end
```

For these reasons I suggest you only write Lua code in creation_code fields that also works in GML. Or feel free to customize ldtk_generate_rooms so that it converts basic Lua syntax to valid GML - such as replacing "then" with "{" and "end" with "}".
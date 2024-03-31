# Getting started
In order for anything in the LDtk world to be able to appear in your room a link must be established. This is done in a few different ways. This document will go over all of them.

This tutorial wont teach LDtk specific concepts. I'd encourage you to familiarize yourself with the basics of LDtk by playing around in the editor.

Remember that throghout this tutorial you'll be able to reload your LDtk world after saving and having your changes applied to your running Gamemaker game by pressing the reload key (default = 0).

## Objects
There are a few ways to place instances using LDtk they vary depending on your preferred amount of flexibility versus convenience.

### Entity instances (flexible)
#### Creating in entity instance
The most flexible way to add an instance is using Entities.
The general rule is: if you need creation code for an instance, then you should use an entity.

1) Create an entity<br>
2) Add a single string value to it and call it object_index<br>
3) Put the name of the object into the "Default value" field<br>
![How to create an entity instance](img-placing-instances/how-to-create-an-entity-instance.png)

#### Changing a variable of an entity instance using fields
To change instance variables add more fields and name them after the variable you want to change.<br>
![How to change an instance variable](img-placing-instances/entity-instance-variable.png)

The limitation to this is that you cannot easily reference other gamemaker resources. Example: you want to set the sprite index.
- You create a string field and name it "sprite_index"
- You set the value to "sprPlayer"
Doing the above would be equivalent to writing the following GML:
`sprite_index = "sprPlayer;"`
Which is not the same as writing:
`sprite_index = sprPlayer;`
Because if sprPlayer is a sprite then referencing it in GML actually becomes a number, not a string. However, this problem can be solved by adding creation code.

#### Calling functions and referencing resources using lua
To run creation code on your instance you can add a "multilines" field to your entity. Name the field "creation_code". You can have LDtk add basic syntax highlighting by setting the language field to lua.
![Entity instance creation code](img-placing-instances/entity-instance-creation-code.png)<br>
Now you can write code that references your sprite
![Creation code example](img-placing-instances/creation-code-example.png)<br>
Note that in order to reference the instance's sprite index you'll have to use "id". Just doing `sprite_index = sprPlayer` will not set the sprite_index. It boils down to "Lua is not GML". For further explanation see the Lua limitations document. By default in LDtk-gms you'll be able to reference all sprites, objects, sounds, rooms, scripts, and paths in Lua - see the lua bindings folder in ldtk gms scripts folder to see how this works (specifically lua_ref_resources_init).

### Tile instances (convenient)
Chances are that you want to place a bunch of instances without customizing each one. Additionally, using entities can make the ui very cluttered. Using tilemaps for some objects is ideal for this.
1) Add an image to your included files containing the visual assets for the objects you're going to be placing in the world.
![Tile instances visual assets](img-placing-instances/tile-instances-visual-assets.png)
2) Add a tileset to your LDtk world using the image you just added.
![LDtk tileset](img-placing-instances/tile-instances-ldtk-tileset.png)
3) Click on each tile and add json containing an object index key containing the name of the object you want the tile to correspond with.
![Binding object to tileset using JSON](img-placing-instances/tile-instances-json-binding.png)

Tile instances are a lot easier to work with when you have a lot of instances to place.
But you cannot change their individual variables or add lua scripts to them.
To work around this you can create entities that you use when you need to customize them.

### Enum instances (special)
You can tie instances to IntGrid layers as well. In those cases they will be based on LDtk Enums.
These have the extra functionality to scale the objects that they contain to fit optimally within their area in order to optimize instance count.
This behavior is best for wall objects and the like.

1) Create a new enum layer
2) Create a new enum value and name it after the object want it to represent.
Make sure that the object fits the grid size of the IntGrid layer, else it will be scaled wrong.
*ps: you might have to change the identifiers format convention depending on the name of your object*
![Create an enum instance layer](img-placing-instances/enum-instance-create.png)

With this set up we get automatic scaling of objects on the layer, while maintaining the flexibility of being able to carve a path through a wall without having to manually resize those instances.
![Enum instance scaling](img-placing-instances/enum-instance-scaling.png)
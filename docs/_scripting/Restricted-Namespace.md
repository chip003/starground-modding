# About Restrictions
Due to the nature of modding, some classes/namespaces from Godot are blocked within the ModLoader. A list of these restrictions are able to be found below and alternative methods have been added within the `ModAPI` class to help restore some of the methods needed for modding.

### Restricted Classes
* OS
* DirAccess
* ResourceLoader
* IP
* FileAccess
* Steam

### Alternative Methods
Currently none of the Restricted Godot Namespaces/Classes have had any issues being restricted from within a Mod. If you find something that has a valid usage for modding, please open a issue on the [Modding Github](https://github.com/chip003/starground-modding).
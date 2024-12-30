Thanks for being interested in wanting to mod Starground! This wiki will go over the requirements and basics of setting up your Godot project to create a mod for the game.

## Requirements
Mod projects require a few things:
1. You must use [Godot version 4.3](https://godotengine.org/download/windows/).
2. Mods need to export GDScript as text (more on that in exporting).
3. Mods require an `info.json` file. An example can be found inside of templates or [here](_general/info-JSON.md).
4. Restricted classes are disallowed. Mods are scanned on load, and will fail to load if containing these. A list can be found on [Restricted Classes](_scripting/Restricted-Namespace.md) page.

## Game Version
Mods can support multiple versions of the base game as long as they are still compatible. To see your current game version, take a look at the number on the bottom of the screen. The version should be a number without any letters (e.x 0.9.0.0, 0.8.3.0).

## Modding
Modding is pretty flexible since it's done through Godot. This allows you to do all sorts of things like:
* Adding new buildings, items, effects, and more
* Modifying base-game assets (images, sounds, scripts, etc.)
* Texture packs that just replace images or sounds
* And pretty much anything else you can think of!

Here is a page about what is currently not possible within Modding. See [Not Possible within Modding](_general/not-possible.md).

Modding is done the same way as regular game development in Godot. You can add scenes, code, and images into your project in the usual way.

## Integrating Modded Content
To integrate your content into the game, it's recommended to do this through the ModAPI class. This is a helper class that integrates your content in a way that is safe alongside other mods. Anything you do through the ModAPI class should rarely ever have conflicts with other mods (as long as IDs and asset names are different).

### Adding or Replacing Content
Inside of `info.json`, you can point to an initial script to load within the `res://` directory. This script will be ran once when your mod is initiated. This is the perfect place to use functions like `add_building_entry()` in order to integrate your modded content in. Examples of how to do this and other related modding functions can be seen in the project in templates.

In order to replace base-game assets, you only need to name them the same thing in the same location. For example, to replace the collector, you can create the Sprites folder and name your new sprite collector.png. This works the same way with sounds and any other assets.

## Exporting
When you've built your mod exporting is pretty straight forward, but there are a few things to be aware of.

First you need to build an export preset in the export tab under `Project`. Under scripts inside of your export preset, you need to set GDScript Export Mode to `Text` (easier debugging). This is so that Starground can scan your mod for malicious code.

Once your export settings are configured properly, export it as a *ZIP* (not a pck!). Do this by manually selecting `ZIP file` on the bottom right. Name your .zip, and you're good to go!

## Tips
1. You should avoid replacing base-game scenes and code as little as possible. Every time you modify something in vanilla Starground, you run the risk of conflicting with other mods. You should always use the ModAPI script for adding your modded content into the game in the proper way.
2. Mods can be client side or server side. As long as you don't need any networking, you can make mods that work on vanilla servers.

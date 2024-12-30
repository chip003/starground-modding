# Info JSON Schema
Mod Developers are required to include a JSON Schema that contains information about their mod within the packed version of their mod. Below is an explanation of the `info.json` file that is required in every mod.

### Example `info.json` File
```json
{
	"Format": 1,
	"Script": "res://AwesomeMod/loader.gd",
	"Data": {
		"ID": "bbg_templatemod_1",
		"DisplayName": "Awesome mod!",
		"ModVersion": "1.0",
		"Description": "A super awesome mod!",
		"GameVersions": ["0.9.0.0"],
		"Author": "Jesse Schramm",
		"Dependencies": [],
	}
}
```

### Important Fields within `info.json`

| Key                                 | Description of Usage                                                                             |
| ----------------------------------- | ------------------------------------------------------------------------------------------------ |
| Format<br>(int)                     | Used by Jesse for marking modding api format changes.                                            |
| Script<br>(String)                  | Entry resource that will autoload on Mod Load.                                                   |
| Data.ID<br>(String)                 | This is the identifier for your mod. Must be `Unique`.                                           |
| Data.DisplayName<br>(String)        | Name of your mod.                                                                                |
| Data.ModVersion<br>(String)         | The current version of your mod.                                                                 |
| Data.Description                    | A description of your mod and what it does.                                                      |
| Data.GameVersions<br>(String Array) | An Array of supported Game Versions that your mod works on.                                      |
| Data.Author<br>(String)             | The Author of the mod. (You)                                                                     |
| Data.Dependencies<br>(String Array) | This is not yet used, hopefully will be implemented soon to control what mods have a dependency. |

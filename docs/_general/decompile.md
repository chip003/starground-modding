
# Decompile Starground Project
Currently decompiling the game is allowed, however redistributing any of the project files is strictly forbidden. This guide will walk you thought the decompiling of the game and cover some of the basics about using it for development.

  <div class="alert alert-error radius">
<strong class="font__weight-semibold">WARNING!</strong> Keep in mind that this project, including its codebase and assets, are property of BigBoyGames, and must not be used outside of this modding scope or redistributed in any way, unless stated otherwise.
  </div>

***
## Decompiling Requirements
- Have the version of Starground installed via Steam.
- You will need a custom version of Godot engine called GodotSteam found [here.](https://github.com/GodotSteam/MultiPlayerPeer/releases/tag/v4.11-mp)
- You will need GDSdecomp from [here.](https://github.com/bruvzg/gdsdecomp/releases/tag/v0.7.0-prerelease.1)
- Basic understanding of Godot Engine to fix any decompile issues. (Decompile doesn't always work properly)

## Setting Up Project
This is the actual guide in order to get the source files. This may not always work if the game update changes engine version or etc.

1. Open Godot RE Tools, select RE Tools from the tool bar on the top and then click the Recover project button.
2. Navigate to your Starground installation files (On `steam: Properties > Installed Files > Browse`), select `starground.pck` and click open.
3. Wait for it to finish loading, make sure Full Recovery is on, select your destination folder, and click extract.
4. Open the GodotSteam Editor, and open the project generated in the last step, either by clicking Import on the Project Manager and navigating to the project folder, or by opening the `project.godot` file using GodotSteam (Regular Godot won't work).

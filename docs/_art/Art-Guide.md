This section of documentation goes over the art side of Starground, and what measures should be taken if modders want to emulate the vanilla art style. There's nothing wrong with mods having their own unique aesthetic, but sometimes fitting in is a better experience for players.

## Drawing Program
All art for Starground is done in [paint.net](https://www.getpaint.net/) (different from Microsoft Paint!). However, I don't recommend this unless you're on Windows, need a general multi-purpose program, and need something free.

I recommend using [Aseprite](https://www.aseprite.org/), which is currently one of the best and most feature-rich pixel art programs. The source code is available here on GitHub, and can be installed for free if you compile it yourself. 

## Color Palette
Starground uses a modified version of the Endesga color palette [here.](https://lospec.com/palette-list/endesga-32) Some common additional colors and their hex codes are:
* 35354C
> Black color used for outlines and anything in complete darkness.
* 75B778, 7FC675, 5E9186
> Green colors used for grass.
* FF8C32, DB753C, B76458, 7F465F
> Orange colors used for the player and movers.

Typically I recommend using the base colors of the Endesga palette, but don't be afraid to use other colors if you're struggling going from one color to another.

## Asset Sizes
Starground is centered around the standard tile size, which is 16x16. All assets in the game are typically a multiple of this tile size, or use it as a frame of reference in some way. Some common sizes are:

* Buildings (typically a multiple of a tile, like 16x16, 32x32, 48x48, etc)
* Items (12x12 for most items)
* Weapons (varies greatly since sprite size determines reach, but usually around 8x16 for sword-type components)
* Entities (16x16 for player-sized entities, otherwise usually 32x32)
* Icons (16x16 with a 1px transparent gap on all sides)

It's important to remember that resolution will correlate to size. A building with a 32x32 resolution should be 2x2 tiles big, otherwise sprites can start to look odd.

## General "Rules"
Some things that I do with all sprites are:

* All outlines are solid black without anti-aliasing, except pixels that make direct contact to the ground (which should be grey).
* All lighting comes from directly above for most sprites, and then only top-right when needed.
* Excessive detail should be avoided in order to maintain readability and simplicity (detail stems from multiple sprites next to each other anyways).

When in doubt, look at what sprites are already in the game!
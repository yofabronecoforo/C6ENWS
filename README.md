# Enhanced Natural Wonders Selection for Civilization VI
A mod which enables variable numbers of Natural Wonders on standard map sizes.

New Frontend text fully localized in the following language(s):
- English (en_US)
- Spanish (es_ES)
- French (fr_FR)

# Features
### Natural Wonders slider
Provides a slider which allows for control over the number of Natural Wonders that spawn in a game. The range of this slider varies with the selected map size, per the table below. 

Map Size | Default Natural Wonders | Minimum Natural Wonders | Maximum Natural Wonders
-------- | ----------------------- | ----------------------- | -----------------------
Duel     | 2 | 0 | 4
Tiny     | 3 | 0 | 6
Small    | 4 | 0 | 8
Standard | 5 | 0 | 10
Large    | 6 | 0 | 12
Huge     | 7 | 0 | 14

Default values for each size are currently unchanged from base-game defaults.
Maximum value for a given size is currently equal to 2x the default value for that size.

Used in conjunction with the official Natural Wonders selector, it is almost possible to guarantee that only the number of and specific NWs selected spawn. The generated map must still contain a valid plot to place a given NW in; if none exist or remain, the NW won't be placed.

A Duel map with up to two Natural Wonders per player?
A Huge map with only the one Natural Wonder you select?
A Small map with six players and six Natural Wonders?
Any size map with only two, only one, or completely devoid of any, Natural Wonder(s)?
These, and more, are now possible.

### Natural Wonders selector
The official Natural Wonders selector now utilizes a modified version of the official City-States selector's framework; as a result of this:
- The Natural Wonders slider is now accessible from within the Natural Wonders selector. When the selector is opened, the slider inside will reflect the value of the primary Natural Wonders slider provided in the Advanced Setup; when selections are confirmed, the primary slider will reflect the value of the selector's slider.
- Available Natural Wonders will be displayed in two columns, and the size of each item in the list has been slightly increased compared to the default. These items are presented as is; no sorting options are available, as none are provided.

The button text for the official Natural Wonders selector now reflects the number of selected NWs when all available NWs have been selected, like it does for custom selections. The tooltip text for this option now dynamically updates to reflect the source(s) of available Natural Wonders, which can vary depending on enabled additional content and the currently selected ruleset.
- This functionality extends to the built-in City-States and Random Leaders selector(s).

# Compatibility
Definitely requires the [August 2020 Game Update](https://civilization.com/news/entries/civilization-vi-august-2020-game-update-available-now/); **will break prior builds**.

Requires the [December 2020 Game Update](https://civilization.com/news/entries/civilization-vi-december-2020-game-update-available-now/) and the [February 2021 Game Update](https://civilization.com/news/entries/civilization-vi-february-2021-game-update-available-now/) for full compatibility.

## SP / MP
Compatible with Single- and Multi-Player game setups.

## Rulesets
Compatible with the following rulesets:
- Standard
- Rise and Fall
- Gathering Storm

## Game Modes
Compatible with the following game modes:

* Apocalypse
* Barbarian Clans
* Dramatic Ages
* Heroes & Legends
* Monopolies and Corporations
* Secret Societies

Has not been tested with the following game modes:

* Tech and Civic Shuffle
* Zombie Defense

## Mods
Should work with other mods that add new Natural Wonder(s).

# Installation
### Automatic
ENWS is [Steam Workshop item 2273495829](https://steamcommunity.com/sharedfiles/filedetails/?id=2273495829). Subscribe to automatically download and install the latest release, and to automatically receive any updates as they are published to the Workshop.

### Manual
Download the [latest release](https://github.com/zzragnar0kzz/C6ENWS/releases/latest) and extract it into the game's local mods folder. Alternately, clone the repository into the game's local mods folder using your preferred tools. The local mods folder varies:
- Windows : `$userprofile\Documents\My Games\Sid Meier's Civilization VI\Mods`
- Linux : 
- MacOS : 

To update to a newer release, clone or download the latest release as described above, overwriting any existing items in the destination folder.

# Conflicts
ENWS adds the following custom table(s) to the game's Configuration database:
- ContentFlags

If your mod uses any similarly-named custom tables, compatibility issues *may* arise.

ENWS adds custom columns to the following table(s) in the game's Configuration database:
- MapSizes

If your mod employs similar database customizations to any of these tables, compatibility issues *may* arise.

ENWS replaces the following existing Frontend context file(s):
- AdvancedSetup.lua and AdvancedSetup.xml
- GameSetupLogic.lua
- HostGame.lua and HostGame.xml
- Mods.lua

ENWS adds the following new Frontend context file(s):
- NaturalWonderPicker.lua and NaturalWonderPicker.xml

ENWS replaces the following Ingame script file(s):
- NaturalWonderGenerator.lua

If your mod replaces any of the abvoe existing files, or adds any similarly-named new ones, compatibility issues **will** arise.

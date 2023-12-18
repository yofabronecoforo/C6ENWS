# Enhanced Natural Wonders Selection for Civilization VI
A mod which enables variable numbers of Natural Wonders on standard map sizes.

New Frontend text fully localized in the following language(s):
- English (en_US)
- Spanish (es_ES)
- French (fr_FR)

ENWS is compatible with mods that replace the AdvancedSetup, GameSetupLogic, and HostGame Frontend Lua context files. See "Conflicts" below for details and limitations.

# Features
### Natural Wonders Slider
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

A Duel map with up to two Natural Wonders per player?
A Huge map with only one Natural Wonder?
A Small map with six players and six Natural Wonders?
Any size map with only two, only one, or completely devoid of any, Natural Wonder(s)?
These, and more, are now possible.

### Natural Wonders Picker
The Natural Wonders picker now utilizes a modified version of the official City-States picker's framework; as a result of this:
- The Natural Wonders slider is now accessible from within the Natural Wonders picker. When the picker is opened, the slider inside will reflect the value of the primary Natural Wonders slider provided in the Advanced Setup; when selections are confirmed, the primary slider will reflect the value of the picker's slider.
- Available Natural Wonders will be displayed in two columns, and the size of each item in the list has been slightly increased compared to the default. These items are presented as is; no sorting options are available, as none are provided.
- Each Natural Wonder now has a second checkbox on the right side of its picker button, in addition to the existing checkbox on the left side. The left-side checkbox still controls consideration or exclusion, while the right-side checkbox controls prioritization as described below.

### Natural Wonders Prioritization
When a Natural Wonder's priority box is checked, it is placed in a list that is considered for placement ingame before any non-priority selections. A Natural Wonder must be selected to be prioritized; exclusion and prioritization are mutually exclusive, so checking its priority box will also check its selection box, and unchecking its selection box will also uncheck its priority box. Map plot requirements and the slider value are still respected, so like selection, prioritization does not guarantee placement, but as long as the map contains a valid location and there are still Natural Wonders remaining to be placed, a priority selection will be placed before any non-priority selections.

### Picker Button and Controls Text
The text of the Natural Wonders picker button now reflects the number of selected Natural Wonders and the total number of Natural Wonders available for the currently selected ruleset.
- This functionality extends to the official City-States and Random Leaders pickers.

When any priority selections have been made, the text of the Natural Wonders picker button will also reflect the number of such selections.
- The framework to extend this functionality to other pickers is in place, but not implemented because no other pickers currently use such a system.

The tooltip text of the Natural Wonders picker button now dynamically updates to reflect the source(s) of available Natural Wonders, which can vary depending on enabled additional content and the currently selected ruleset.
- This functionality extends to the official City-States and Random Leaders pickers.

Within the picker, each Natural Wonder's button, selection checkbox, and priority checkbox have tooltip text describing their usage.

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
ENWS should work with other mods that add or alter Natural Wonders, as long as those mods are designed to work with the official Natural Wonders picker.

ENWS is compatible with mods that replace the AdvancedSetup, GameSetupLogic, and HostGame Frontend Lua context files. See "Conflicts" below for details and limitations.

ENWS is __NOT__ compatible with Select Natural Wonders++; this mod will be blocked from loading when ENWS is enabled.

# Installation
### Automatic
[Subscribe to ENWS in the Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2273495829) to automatically download and install the latest published release, and to automatically receive any updates as they are published to the Workshop.

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
- MainMenu.xml

The only modifications to this file consist of changing the filenames used for the "AdvancedSetup" and "HostGame" Lua contexts. The ENWS replacements for these files are:
- EnhancedAdvancedSetup.lua and EnhancedAdvancedSetup.xml
- EnhancedHostGame.lua and EnhancedHostGame.xml

The above new XML files contain changes to incorporate ENWS's replacement Natural Wonders picker as well as the new Goody Hut picker from [EGHV](https://steamcommunity.com/sharedfiles/filedetails/?id=2474051781), and in the case of EnhancedAdvancedSetup, to allow for interoperability with [YnAMP](https://steamcommunity.com/sharedfiles/filedetails/?id=871861883) when it is also loaded. YnAMP-specific buttons in the Advanced Setup header will be hidden when it is not loaded.

The above new Lua files contain directives to include the currently active AdvancedSetup or HostGame scripts for SP and MP setups. These will either be the base versions found in the game's UI/FrontEnd folder, or the last imported version from another mod, such as YnAMP. Necessary changes to AdvancedSetup and HostGame are now contained in separate files:
- CommonFrontend.lua    contains new code used by both the AdvancedSetup and HostGame contexts
- AdvancedSetup_ENWS.lua    contains modifications to existing code in the AdvancedSetup context
- GameSetupLogic_ENWS.lua    contains modifications to existing code in the GameSetupLogic script, which is used by both the AdvancedSetup and HostGame contexts
- HostGame_ENWS.lua    contains modifications to existing code in the HostGame context

The above files are included by directive in the appropriate contexts. Additional directives will, as appropriate, include any other imported file whose name matches any of the following patterns:
- AdvancedSetup_
- GameSetupLogic_
- HostGame_

Doing this simulates the behavior of the Ingame "ReplaceUIScript" modinfo tag, which does nothing in the Frontend. This removes the need to overwrite the aforementioned original scripts with new versions containing any necessary changes, and allows for such changes to be placed in separate files that are loaded as needed after the existing scripts are loaded. When care is exercised, this allows multiple mods to make precision changes to these scripts and interoperate with one another. Crucially, since ENWS's load order generally makes it one of the last mods loaded, if not the last one loaded, it also allows for ENWS to function alongside other mods that __DO__ replace the original scripts, without resorting to a Frankenstein's monster of a single script containing changes from different mods. This functionality has been tested with YnAMP, but it *should* work with any mod that replaces the AdvancedSetup, GameSetupLogic, and/or HostGame script(s); however, there are limitations:
- ENWS cannot make the game retain multiple versions of a script with the same name, so only the last imported version of each of these files will be used. This means other mods that overwrite one or more of these scripts will likely continue to conflict with each other.
- Mods that make extensive changes to the AdvancedSetup and/or HostGame XML templates are not supported by ENWS. Notably, this applies to Sukritact's Civ Selection Screen.

To implement the new Natural Wonders picker, ENWS adds the following new Frontend context file(s):
- NaturalWonderPicker.lua and NaturalWonderPicker.xml

ENWS replaces the following Ingame script file(s):
- NaturalWonderGenerator.lua

If your mod replaces any of the above existing files, or adds any similarly-named new ones, compatibility issues __WILL__ arise.

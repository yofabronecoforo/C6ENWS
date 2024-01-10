# Enhanced Natural Wonders Selection (ENWS) for Civilization VI
A mod which enables additional frontend and gameplay settings related to Natural Wonders.

# Overview
ENWS enables variable amounts of Natural Wonders on standard map sizes, with new minimum, maximum, and default amounts. For each size, any specific amount greater than or equal to the minimum value and less than or equal to the maximum value can be selected using the provided slider during game setup.

ENWS replaces the built-in Natural Wonders picker with a custom version based on the built-in City-States picker, where each Natural Wonder has a second checkbox to indicate priority placement; prioritized Natural Wonders will be placed ingame before other selected Natural Wonders. If Start by Wonders is present and enabled, ENWS' priority list will be used to determine starting plots, and Start by Wonders' picker will be hidden.

Some limitations apply; see below for these and more comprehensive details.

# Translations
New Frontend text fully localized in the following languages:
- English (en_US)
- Spanish (es_ES)
- French (fr_FR)

# Dependencies
ENWS **REQUIRES** Enhanced Community FrontEnd, and will be blocked from loading if that mod is not present or is not enabled.

# Features
ENWS alters Frontend and Ingame components relating to the selection and placement of Natural Wonders. These changes are described below.

## Natural Wonders Slider
ENWS provides a slider which allows for control over the number of Natural Wonders that spawn in a game. The range of this slider varies with the selected map size and the total amount of Natural Wonders available for the selected ruleset, per the table below.

Map Size | Default Natural Wonders | Minimum Natural Wonders | Maximum Natural Wonders
-------- | ----------------------- | ----------------------- | -----------------------
Duel     | 2 | 0 | 4
Tiny     | 4 | 0 | 6
Small    | 6 | 0 | 10
Standard | 8 | 0 | 14
Large    | 10 | 0 | 16
Huge     | 12 | 0 | 20

For each size, the minimum amount is zero, and the default and maximum amounts are as follows:
- The default amount for a given size is equal to the default number of major players for that size.
- The maximum amount for a given size is equal to the maximum number of major players for that size.

In some circumstances, there may be fewer total Natural Wonders available than the maximum number of major players for the selected map size; when this happens, the maximum selectable amount of Natural Wonders will be capped at the total available amount.

## Natural Wonders Picker
The Natural Wonders picker now utilizes a modified version of the official City-States picker's framework; as a result of this:
- The Natural Wonders slider is now accessible from within the Natural Wonders picker. When the picker is opened, the slider inside will reflect the value of the primary Natural Wonders slider provided in the Advanced Setup; when selections are confirmed, the primary slider will reflect the value of the picker's slider.
- Available Natural Wonders will be displayed in two columns, and the size of each item in the list has been slightly increased compared to the default. These items are presented as is; no sorting options are available, as none are provided.
- Each Natural Wonder now has a second checkbox on the right side of its picker button, in addition to the existing checkbox on the left side. The left-side checkbox still controls consideration or exclusion, while the right-side checkbox controls prioritization as described below.

## Natural Wonders Prioritization
When a Natural Wonder's priority box is checked, it is placed in a list that is considered for placement ingame before any non-priority selections. A Natural Wonder must be selected to be prioritized; exclusion and prioritization are mutually exclusive, so checking its priority box will also check its selection box, and unchecking its selection box will also uncheck its priority box. As long as the selected map contains a valid location for it and there are still Natural Wonders remaining to be placed, a priority selection will be placed before any non-priority selections.

## Picker Button and Tooltip Text
When any priority selections have been made with the picker, the text of the Natural Wonders picker button will change to reflect the number of such selections in addition to regular selections.

Within the picker, each Natural Wonder's button, selection checkbox, and priority checkbox have tooltip text describing their usage.

# Limitations
ENWS does not fundamentally alter the methods the game uses to place Natural Wonders ingame. Plot requirements are still respected, so selection and/or prioritization are not guarantees that a given Natural Wonder will be placed.

The full amount of Natural Wonders selected via the slider may not be placed if the game cannot identify suitable locations for all of them; the likelihood of this happening increases as the amount selected increases.

# Compatibility
ENWS definitely requires the [August 2020 Game Update](https://civilization.com/news/entries/civilization-vi-august-2020-game-update-available-now/); ***WILL BREAK EARLIER BUILDS***.

ENWS requires the [December 2020 Game Update](https://civilization.com/news/entries/civilization-vi-december-2020-game-update-available-now/) and the [February 2021 Game Update](https://civilization.com/news/entries/civilization-vi-february-2021-game-update-available-now/) for full compatibility.

ENWS is compatible with single- and multi-player game setups.

ENWS is compatible with all official rulesets.

## Game Modes
ENWS is compatible with the following official game modes:
- Apocalypse
- Barbarian Clans
- Dramatic Ages
- Heroes & Legends
- Monopolies and Corporations
- Secret Societies

ENWS has not been tested with the following official game modes:
- Tech and Civic Shuffle
- Zombie Defense

## Mod Compatibility
ECFE was developed with the following mods enabled, and is thus known to be compatible with them:
- Better Civilization Icons
- Better Coastal Cities and Water Tiles
- Better Report Screen (UI)
- Civilizations Expanded
- CIVITAS City-States
- Colorized Historic Moments
- Community Quick User Interface (CQUI)
- Enhanced Mod Manager
- Extended Policy Cards
- More Barbarian EXP
- More Maritime: Seaside Sectors
- Ophidy's Start by Wonders
- Real Great People
- Religion Expanded
- Removable Districts
- Sailor Cat's Wondrous Goody Huts
- Tomatekh's Historical Religions
- Yet (not) Another Maps Pack

ENWS *should* work with other mods that add or alter Natural Wonders, as long as those mods are designed to work with the official Natural Wonders picker.

When Start by Wonders is present and enabled, ENWS' priority list will be used to determine starting plots when the appropriate game mode is enabled, and Start by Wonders' picker will be hidden; the actual placement of players will be handled by that mod.

ENWS **IS NOT** compatible with Select Natural Wonders++; this mod will be blocked from loading when ENWS is enabled.

# Installation
ENWS can be installed via the Steam Workshopo or GitHub.

## Automatic
[Subscribe to ENWS in the Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2273495829) to automatically download and install the latest published release, and to automatically receive any updates as they are published to the Workshop.

## Manual
Download the [latest release](https://github.com/zzragnar0kzz/C6ENWS/releases/latest) and extract it into the game's local mods folder. Alternately, clone the repository into a new folder within the game's local mods folder using your preferred tools. To update to a newer release, clone or download the latest release as described above, overwriting any existing items in the destination folder. The local mods folder varies.

### Windows
`"$userprofile\Documents\My Games\Sid Meier's Civilization VI\Mods"`

### Linux
`"~/.local/share/aspyr-media/Sid Meier's Civilization VI/Mods"`

-or-

`"~/.steam/steam/steamapps/compatdata/289070/pfx/drive_c/users/steamuser/Documents/My Games/Sid Meier's Civilization VI/Mods"`

Which of these is correct depends on whether you are using the native Linux client or the Windows client via Proton Experimental.

# Conflicts
Following is a non-comprehensive list of items that may potentially cause conflicts with other content.

## Configuration Database
ENWS adds custom columns to the following table(s) in the game's Configuration database:
- MapSizes

If your mod employs similar customizations to any of these tables, compatibility issues _MAY_ arise.

## Frontend Context
To implement the new Natural Wonders picker, ENWS adds the following new Frontend context file(s):
- `NaturalWonderPicker.lua` and `NaturalWonderPicker.xml`

If your mod replaces any of these files, compatibility issues __WILL__ arise.

## Ingame Context
ENWS replaces the following Ingame script file(s):
- `NaturalWonderGenerator.lua`

If your mod replaces any of these files, compatibility issues _MAY_ arise.

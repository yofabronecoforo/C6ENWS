# Enhanced Natural Wonders Selection for Civilization VI
A mod which enables variable numbers of Natural Wonders on standard map sizes.

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
The button text for the official Natural Wonders selector now reflects the number of selected NWs when all available NWs have been selected, like it does for custom selections. The tooltip text for this option now dynamically updates to reflect the source(s) of available Natural Wonders, which can vary depending on enabled additional content and the currently selected ruleset.
- This functionality extends to the built-in City-States and Random Leaders selector(s).

# Compatibility
Requires the official Natural Wonders selector, so probably won't work with builds lacking this feature.

Works with the following rulesets:
- Standard
- Rise and Fall
- Gathering Storm

# Conflicts
This mod uses the following custom table(s) in the game's SQLite Configuration database:
- ContentFlags

If your mod uses any similarly-named custom tables, compatibility issues *may* arise.

This mod adds custom columns to the following table(s) in the game's SQLite Configuration database:
- MapSizes

If your mod uses any similarly-named custom columns, in any of the tables named above, compatibility issues *may* arise.

This mod replaces the following lua file(s):
- AdvancedSetup.lua
- GameSetupLogic.lua
- HostGame.lua
- NaturalWonderGenerator.lua

If your mod replaces any of these files, compatibility issues **will** arise.

# Enhanced Natural Wonders Selection for Civilization VI
A mod which enables variable numbers of Natural Wonders on standard map sizes.

# Features
## Natural Wonders slider
Provides a slider which allows for control over the number of Natural Wonders that spawn in a game. The range of this slider varies with the selected map size, per the table below. 

Map Size | Default Natural Wonders | Minimum Natural Wonders | Maximum Natural Wonders
-------- | ----------------------- | ----------------------- | -----------------------
Duel     | 2 | 0 | 4
Tiny     | 3 | 0 | 6
Small    | 4 | 0 | 8
Standard | 5 | 0 | 10
Large    | 6 | 0 | 12
Huge     | 7 | 0 | 14

- Default values for each size are currently unchanged from base-game defaults.
- Maximum value for a given size is currently equal to 2x the default value for that size.

A Duel map with 1-2 NWs per player? A Huge map with only one total NW? Any size map, completely devoid of any NWs? These and more are now possible.

Used in conjunction with the official Natural Wonders selector, it is almost possible to guarantee that only the number of and specific NWs selected spawn. The generated map must still contain a valid plot to place a given NW in; if none exist or remain, the NW won't be placed.

## Natural Wonders selector
The button text for the official Natural Wonders selector now reflects the number of selected NWs when all available NWs have been selected, like it does for custom selections. The tooltip text for this option now dynamically updates to reflect the source(s) of available Natural Wonders, which can vary depending on enabled additional content and the currently selected ruleset.

# Compatibility
Requires the official Natural Wonders selector, so probably won't work with builds lacking this feature.

Works with the following rulesets:
- Standard
- Rise and Fall
- Gathering Storm

# Conflicts
Replaces the following lua files:
- AdvancedSetup.lua
- GameSetupLogic.lua
- NaturalWonderGenerator.lua

This will break mods that make changes to any of these files.

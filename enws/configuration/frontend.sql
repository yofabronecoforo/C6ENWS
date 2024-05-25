/* ###########################################################################
    C6ENWS : Enhanced Natural Wonders Selection for Civilization VI
    Copyright (c) 2020-2024 yofabronecoforo
    All rights reserved.
########################################################################### */

/* ###########################################################################
    begin C6ENWS configuration
########################################################################### */

-- hide Start by Wonders' picker if it is present; the priority list will be copied to the StartWonders list if applicable
UPDATE Parameters SET Visible = 0 WHERE ParameterID = 'StartWonders';

-- reposition the Game Speed parameter
UPDATE Parameters SET SortIndex = 70 WHERE ParameterId = 'GameSpeeds';

-- reposition the Disaster Intensity slider
UPDATE Parameters SET SortIndex = 71 WHERE Domain = 'RealismRange';

-- reposition the Leader Pool 1 selector
UPDATE Parameters SET SortIndex = 72 WHERE ParameterId = 'LeaderPool1';

-- reposition the Leader Pool 2 selector
UPDATE Parameters SET SortIndex = 73 WHERE ParameterId = 'LeaderPool2';

-- reposition the City-States selector
UPDATE Parameters SET SortIndex = 81 WHERE ParameterId = 'CityStates';

-- reposition the Resources parameter
UPDATE Parameters SET SortIndex = 235 WHERE Domain = 'Resources';

-- define the Natural Wonders slider(s), one for each ruleset
INSERT INTO Parameters (Key1, Key2, ParameterId, Name, Description, Domain, ConfigurationGroup, ConfigurationId, Hash, GroupId, SortIndex)
VALUES
    ('Ruleset', 'RULESET_STANDARD', 'NaturalWonderCount', 'LOC_NATURAL_WONDER_COUNT_NAME', 'LOC_NATURAL_WONDER_COUNT_DESCRIPTION', 'StandardNaturalWonderCountRange', 'Game', 'NATURAL_WONDER_COUNT', '0', 'GameOptions', '229'),
	('Ruleset', 'RULESET_EXPANSION_1', 'NaturalWonderCount', 'LOC_NATURAL_WONDER_COUNT_NAME', 'LOC_NATURAL_WONDER_COUNT_DESCRIPTION', 'Expansion1NaturalWonderCountRange', 'Game', 'NATURAL_WONDER_COUNT', '0', 'GameOptions', '229'),
	('Ruleset', 'RULESET_EXPANSION_2', 'NaturalWonderCount', 'LOC_NATURAL_WONDER_COUNT_NAME', 'LOC_NATURAL_WONDER_COUNT_DESCRIPTION', 'Expansion2NaturalWonderCountRange', 'Game', 'NATURAL_WONDER_COUNT', '0', 'GameOptions', '229');

-- disable certain options if this is for the world builder
INSERT INTO ParameterDependencies (ParameterId, ConfigurationGroup, ConfigurationId, Operator, ConfigurationValue)
VALUES
    ('NaturalWonderCount', 'Game', 'WORLD_BUILDER', 'NotEquals', 1);

-- define dynamic ranges for the Natural Wonders slider(s)
INSERT INTO DomainRangeQueries (QueryId)
VALUES
    ('StandardNaturalWonderCountRange'),
    ('Expansion1NaturalWonderCountRange'),
    ('Expansion2NaturalWonderCountRange');

/* ###########################################################################
define value queries to set the lower and upper boundaries of the Natural Wonders slider(s)
lower boundary : the value defined in MapSizes.MinNaturalWonders for the selected map size
upper boundary : the lesser of:
    (1) the number of Natural Wonders available with the selected ruleset and any enabled additional content; or
    (2) the value defined in MapSizes.MaxNaturalWonders for the selected map size
########################################################################### */
INSERT INTO Queries (QueryId, SQL)
VALUES
    ('StandardNaturalWonderCountRange', 'SELECT ''StandardNaturalWonderCountRange'' AS Domain, ?1 AS MinimumValue, (SELECT CASE WHEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''StandardNaturalWonders'') < ?2 THEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''StandardNaturalWonders'') ELSE ?2 END) AS MaximumValue LIMIT 1'),
	('Expansion1NaturalWonderCountRange', 'SELECT ''Expansion1NaturalWonderCountRange'' AS Domain, ?1 AS MinimumValue, (SELECT CASE WHEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''Expansion1NaturalWonders'') < ?2 THEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''Expansion1NaturalWonders'') ELSE ?2 END) AS MaximumValue LIMIT 1'),
	('Expansion2NaturalWonderCountRange', 'SELECT ''Expansion2NaturalWonderCountRange'' AS Domain, ?1 AS MinimumValue, (SELECT CASE WHEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''Expansion2NaturalWonders'') < ?2 THEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''Expansion2NaturalWonders'') ELSE ?2 END) AS MaximumValue LIMIT 1');

/*
-- parameters for the queries defined above *** BROKEN ***
INSERT INTO QueryParameters (QueryId, Index, ConfigurationGroup, ConfigurationId)
VALUES
    ('StandardNaturalWonderCountRange', '1', 'Map', 'MAP_MIN_NATURAL_WONDERS'),
    ('StandardNaturalWonderCountRange', '2', 'Map', 'MAP_MAX_NATURAL_WONDERS'),
    ('Expansion1NaturalWonderCountRange', '1', 'Map', 'MAP_MIN_NATURAL_WONDERS'),
    ('Expansion1NaturalWonderCountRange', '2', 'Map', 'MAP_MAX_NATURAL_WONDERS'),
    ('Expansion2NaturalWonderCountRange', '1', 'Map', 'MAP_MIN_NATURAL_WONDERS'),
    ('Expansion2NaturalWonderCountRange', '2', 'Map', 'MAP_MAX_NATURAL_WONDERS');
*/

-- define minimum, maximum, and default values for the Natural Wonders slider(s) for each standard map size
-- UPDATE MapSizes 
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 4, DefaultNaturalWonders = 2
-- WHERE MapSizeType = 'MAPSIZE_DUEL' AND Domain = 'StandardMapSizes';

-- UPDATE MapSizes 
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 6, DefaultNaturalWonders = 4
-- WHERE MapSizeType = 'MAPSIZE_TINY' AND Domain = 'StandardMapSizes';

-- UPDATE MapSizes 
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 10, DefaultNaturalWonders = 6
-- WHERE MapSizeType = 'MAPSIZE_SMALL' AND Domain = 'StandardMapSizes';

-- UPDATE MapSizes 
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 14, DefaultNaturalWonders = 8
-- WHERE MapSizeType = 'MAPSIZE_STANDARD' AND Domain = 'StandardMapSizes';

-- UPDATE MapSizes 
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 16, DefaultNaturalWonders = 10
-- WHERE MapSizeType = 'MAPSIZE_LARGE' AND Domain = 'StandardMapSizes';

-- UPDATE MapSizes 
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 20, DefaultNaturalWonders = 12
-- WHERE MapSizeType = 'MAPSIZE_HUGE' AND Domain = 'StandardMapSizes';

-- define minimum, maximum, and default Natural Wonders values for all Standard map sizes
UPDATE MapSizes 
SET DefaultNaturalWonders = DefaultPlayers, MaxNaturalWonders = (DefaultPlayers * 2), MinNaturalWonders = 0 
WHERE Domain = 'StandardMapSizes';

/* ###########################################################################
    end C6ENWS configuration
########################################################################### */

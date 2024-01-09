/* ###########################################################################
    ENWS : Enhanced Natural Wonders Selection for Civilization VI
    Copyright (c) 2020-2023 zzragnar0kzz
    All rights reserved.
########################################################################### */

/* ###########################################################################
    Begin ENWS Frontend configuration
########################################################################### */

-- 
-- REPLACE INTO ContentFlags (Id, Name, GUID, CityStates, GoodyHuts, Leaders, NaturalWonders, Base, XP1, XP2, Tooltip)
-- VALUES 
--     ('DLC01', 'Aztec', '02A8BDDE-67EA-4D38-9540-26E685E3156E', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_AZTEC_TT'),
--     ('DLC02', 'Poland', '3809975F-263F-40A2-A747-8BFB171D821A', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_POLAND_TT'),
--     ('DLC03', 'Vikings', '2F6E858A-28EF-46B3-BEAC-B985E52E9BC1', 1, 0, 1, 1, 1, 1, 1, 'LOC_DLC_VIKINGS_TT'),
--     ('DLC04', 'Australia', 'E3F53C61-371C-440B-96CE-077D318B36C0', 0, 0, 1, 1, 1, 1, 1, 'LOC_DLC_AUSTRALIA_TT'),
--     ('DLC05', 'Persia', 'E2749E9A-8056-45CD-901B-C368C8E83DEB', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_PERSIA_TT'),
--     ('DLC06', 'Nubia', '643EA320-8E1A-4CF1-A01C-00D88DDD131A', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_NUBIA_TT'),
--     ('DLC07', 'Khmer', '1F367231-A040-4793-BDBB-088816853683', 0, 0, 1, 1, 1, 1, 1, 'LOC_DLC_KHMER_TT'),
--     ('DLC08', 'Maya', '9DE86512-DE1A-400D-8C0A-AB46EBBF76B9', 1, 0, 1, 1, 1, 1, 1, 'LOC_DLC_MAYA_TT'),
--     ('DLC09', 'Ethiopia', '1B394FE9-23DC-4868-8F0A-5220CB8FB427', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_ETHIOPIA_TT'),
--     ('DLC10', 'Byzantium', 'A1100FC4-70F2-4129-AC27-2A65A685ED08', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_BYZANTIUM_TT'),
--     ('DLC11', 'Babylon', '8424840C-92EF-4426-A9B4-B4E0CB818049', 1, 0, 1, 0, 1, 1, 1, 'LOC_DLC_BABYLON_STK_TT'),
--     ('DLC12', 'Vietnam', 'A3F42CD4-6C3E-4F5A-BC81-BE29E0C0B87C', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_VIETNAM_TT'),
--     ('DLC13', 'Portugal', 'FFDF4E79-DEE2-47BB-919B-F5739106627A', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_PORTUGAL_TT'),
--     ('XP1', 'Expansion1', '1B28771A-C749-434B-9053-D1380C553DE9', 0, 0, 1, 1, 0, 1, 1, 'LOC_XP1_TT'),
--     ('XP2', 'Expansion2', '4873eb62-8ccc-4574-b784-dda455e74e68', 1, 1, 1, 1, 0, 0, 1, 'LOC_XP2_TT'),
--     ('ENWS', 'ENWS', 'd0afae5b-02f8-4d01-bd54-c2bbc3d89858', 0, 0, 0, 0, 1, 1, 1, 'LOC_ENWS_TT'),
--     ('EGHV', 'EGHV', 'a4b1fac6-8c9e-4873-a1c1-7ddf08dbbf11', 0, 1, 0, 0, 1, 1, 1, 'LOC_EGHV_TT'),
--     ('WGH', 'WGH', '2d90451f-08c9-47de-bce8-e9b7fdecbe92', 0, 1, 0, 0, 1, 1, 1, 'LOC_WGH_TT');

-- Reposition the Game Speed parameter
UPDATE Parameters SET SortIndex = 70 WHERE ParameterId = 'GameSpeeds';

-- Reposition the Disaster Intensity slider
UPDATE Parameters SET SortIndex = 71 WHERE Domain = 'RealismRange';

-- Reposition the Leader Pool 1 selector
UPDATE Parameters SET SortIndex = 72 WHERE ParameterId = 'LeaderPool1';

-- Reposition the Leader Pool 2 selector
UPDATE Parameters SET SortIndex = 73 WHERE ParameterId = 'LeaderPool2';

-- Reposition the City-States selector
UPDATE Parameters SET SortIndex = 81 WHERE ParameterId = 'CityStates';

-- Reposition the Resources parameter
UPDATE Parameters SET SortIndex = 235 WHERE Domain = 'Resources';

-- Define the Natural Wonders slider(s), one for each ruleset
INSERT INTO Parameters (Key1, Key2, ParameterId, Name, Description, Domain, ConfigurationGroup, ConfigurationId, Hash, GroupId, SortIndex)
VALUES
    ('Ruleset', 'RULESET_STANDARD', 'NaturalWonderCount', 'LOC_NATURAL_WONDER_COUNT_NAME', 'LOC_NATURAL_WONDER_COUNT_DESCRIPTION', 'StandardNaturalWonderCountRange', 'Game', 'NATURAL_WONDER_COUNT', '0', 'GameOptions', '229'),
	('Ruleset', 'RULESET_EXPANSION_1', 'NaturalWonderCount', 'LOC_NATURAL_WONDER_COUNT_NAME', 'LOC_NATURAL_WONDER_COUNT_DESCRIPTION', 'Expansion1NaturalWonderCountRange', 'Game', 'NATURAL_WONDER_COUNT', '0', 'GameOptions', '229'),
	('Ruleset', 'RULESET_EXPANSION_2', 'NaturalWonderCount', 'LOC_NATURAL_WONDER_COUNT_NAME', 'LOC_NATURAL_WONDER_COUNT_DESCRIPTION', 'Expansion2NaturalWonderCountRange', 'Game', 'NATURAL_WONDER_COUNT', '0', 'GameOptions', '229');

-- Disable certain options if this is for the world builder
INSERT INTO ParameterDependencies (ParameterId, ConfigurationGroup, ConfigurationId, Operator, ConfigurationValue)
VALUES
    ('NaturalWonderCount', 'Game', 'WORLD_BUILDER', 'NotEquals', 1);

-- Define dynamic ranges for the Natural Wonders slider(s)
INSERT INTO DomainRangeQueries (QueryId)
VALUES
    ('StandardNaturalWonderCountRange'),
    ('Expansion1NaturalWonderCountRange'),
    ('Expansion2NaturalWonderCountRange');

/* ###########################################################################
Define value queries to set the lower and upper boundaries of the Natural Wonders slider(s)
Lower boundary : the value defined in MapSizes.MinNaturalWonders for the selected map size
Upper boundary : the lesser of:
    (1) the number of Natural Wonders available with the selected ruleset and any enabled additional content; or
    (2) the value defined in MapSizes.MaxNaturalWonders for the selected map size
########################################################################### */
INSERT INTO Queries (QueryId, SQL)
VALUES
    ('StandardNaturalWonderCountRange', 'SELECT ''StandardNaturalWonderCountRange'' AS Domain, ?1 AS MinimumValue, (SELECT CASE WHEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''StandardNaturalWonders'') < ?2 THEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''StandardNaturalWonders'') ELSE ?2 END) AS MaximumValue LIMIT 1'),
	('Expansion1NaturalWonderCountRange', 'SELECT ''Expansion1NaturalWonderCountRange'' AS Domain, ?1 AS MinimumValue, (SELECT CASE WHEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''Expansion1NaturalWonders'') < ?2 THEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''Expansion1NaturalWonders'') ELSE ?2 END) AS MaximumValue LIMIT 1'),
	('Expansion2NaturalWonderCountRange', 'SELECT ''Expansion2NaturalWonderCountRange'' AS Domain, ?1 AS MinimumValue, (SELECT CASE WHEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''Expansion2NaturalWonders'') < ?2 THEN (SELECT Count(*) FROM NaturalWonders WHERE Domain = ''Expansion2NaturalWonders'') ELSE ?2 END) AS MaximumValue LIMIT 1');

/*
-- Parameters for the queries defined above *** BROKEN ***
INSERT INTO QueryParameters (QueryId, Index, ConfigurationGroup, ConfigurationId)
VALUES
    ('StandardNaturalWonderCountRange', '1', 'Map', 'MAP_MIN_NATURAL_WONDERS'),
    ('StandardNaturalWonderCountRange', '2', 'Map', 'MAP_MAX_NATURAL_WONDERS'),
    ('Expansion1NaturalWonderCountRange', '1', 'Map', 'MAP_MIN_NATURAL_WONDERS'),
    ('Expansion1NaturalWonderCountRange', '2', 'Map', 'MAP_MAX_NATURAL_WONDERS'),
    ('Expansion2NaturalWonderCountRange', '1', 'Map', 'MAP_MIN_NATURAL_WONDERS'),
    ('Expansion2NaturalWonderCountRange', '2', 'Map', 'MAP_MAX_NATURAL_WONDERS');
*/

-- Define minimum, maximum, and default values for the Natural Wonders slider(s) for each standard map size
UPDATE MapSizes
SET MinNaturalWonders = 0, MaxNaturalWonders = 4, DefaultNaturalWonders = 2
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 4, DefaultNaturalWonders = 2
WHERE MapSizeType = 'MAPSIZE_DUEL' AND Domain = 'StandardMapSizes';

UPDATE MapSizes
SET MinNaturalWonders = 0, MaxNaturalWonders = 6, DefaultNaturalWonders = 3
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 6, DefaultNaturalWonders = 4
WHERE MapSizeType = 'MAPSIZE_TINY' AND Domain = 'StandardMapSizes';

UPDATE MapSizes
SET MinNaturalWonders = 0, MaxNaturalWonders = 8, DefaultNaturalWonders = 4
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 10, DefaultNaturalWonders = 6
WHERE MapSizeType = 'MAPSIZE_SMALL' AND Domain = 'StandardMapSizes';

UPDATE MapSizes
SET MinNaturalWonders = 0, MaxNaturalWonders = 10, DefaultNaturalWonders = 5
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 14, DefaultNaturalWonders = 8
WHERE MapSizeType = 'MAPSIZE_STANDARD' AND Domain = 'StandardMapSizes';

UPDATE MapSizes
SET MinNaturalWonders = 0, MaxNaturalWonders = 12, DefaultNaturalWonders = 6
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 16, DefaultNaturalWonders = 10
WHERE MapSizeType = 'MAPSIZE_LARGE' AND Domain = 'StandardMapSizes';

UPDATE MapSizes
SET MinNaturalWonders = 0, MaxNaturalWonders = 14, DefaultNaturalWonders = 7
-- SET MinNaturalWonders = 0, MaxNaturalWonders = 20, DefaultNaturalWonders = 12
WHERE MapSizeType = 'MAPSIZE_HUGE' AND Domain = 'StandardMapSizes';

/* ###########################################################################
    End ENWS Frontend configuration
########################################################################### */

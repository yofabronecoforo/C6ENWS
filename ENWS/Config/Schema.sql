/* ###########################################################################
    ENWS	:	Enhanced Natural Wonders Selection for Civilization VI
    Copyright (c) 2020-2021 zzragnar0kzz
    All rights reserved.
########################################################################### */

/* ###########################################################################
   	Begin ENWS Configuration schema
########################################################################### */

-- Define table for flagging the presence of available additional content
CREATE TABLE IF NOT EXISTS 'ContentFlags' (
    'Name' TEXT NOT NULL,
	'Value' INTEGER NOT NULL DEFAULT 0
);

-- Add the specified column(s) to table MapSizes - these are values for the Natural Wonders slider(s)
ALTER TABLE MapSizes ADD MinNaturalWonders INTEGER NOT NULL DEFAULT 0;
ALTER TABLE MapSizes ADD MaxNaturalWonders INTEGER NOT NULL DEFAULT 0;
ALTER TABLE MapSizes ADD DefaultNaturalWonders INTEGER NOT NULL DEFAULT 0;

-- Define trigger to detect the presence of installed and enabled content : Aztec DLC
CREATE TRIGGER IF NOT EXISTS AztecDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_AZTEC' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_AZTEC_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Poland DLC
CREATE TRIGGER IF NOT EXISTS PolandDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_POLAND' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_POLAND_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Vikings DLC
CREATE TRIGGER IF NOT EXISTS VikingsDLC_Enabled AFTER INSERT ON NaturalWonders WHEN NEW.FeatureType = 'FEATURE_EYJAFJALLAJOKULL' AND NEW.Domain = 'StandardNaturalWonders'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_VIKINGS_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Australia DLC
CREATE TRIGGER IF NOT EXISTS AustraliaDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_AUSTRALIA' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_AUSTRALIA_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Persia and Macedon DLC
CREATE TRIGGER IF NOT EXISTS PersiaMacedonDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_PERSIA' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_PERSIA_MACEDON_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Nubia DLC
CREATE TRIGGER IF NOT EXISTS NubiaDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_NUBIA' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_NUBIA_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Khmer and Indonesia DLC
CREATE TRIGGER IF NOT EXISTS KhmerIndonesiaDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_KHMER' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_KHMER_INDONESIA_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Expansion 1
CREATE TRIGGER IF NOT EXISTS XP1_Enabled AFTER INSERT ON NaturalWonders WHEN NEW.FeatureType = 'FEATURE_DELICATE_ARCH' AND NEW.Domain = 'Expansion1NaturalWonders'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('EXPANSION_1_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Expansion 2
CREATE TRIGGER IF NOT EXISTS XP2_Enabled AFTER INSERT ON NaturalWonders WHEN NEW.FeatureType = 'FEATURE_CHOCOLATEHILLS' AND NEW.Domain = 'Expansion2NaturalWonders'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('EXPANSION_2_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Gran Colombia and Maya DLC
CREATE TRIGGER IF NOT EXISTS GranColombiaMayaDLC_Enabled AFTER INSERT ON NaturalWonders WHEN NEW.FeatureType = 'FEATURE_BERMUDA_TRIANGLE' AND NEW.Domain = 'StandardNaturalWonders'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_GRANCOLOMBIA_MAYA_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Ethiopia DLC
CREATE TRIGGER IF NOT EXISTS EthiopiaDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_ETHIOPIA' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_ETHIOPIA_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Byzantium & Gaul DLC
CREATE TRIGGER IF NOT EXISTS ByzantiumGaulDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_BYZANTIUM' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_BYZANTIUM_GAUL_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Babylon DLC
CREATE TRIGGER IF NOT EXISTS BabylonDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_BABYLON_STK' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_BABYLON_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Vietnam & Kublai Khan DLC
CREATE TRIGGER IF NOT EXISTS VietnamKublaiKhanDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_VIETNAM' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_VIETNAM_KUBLAI_KHAN_ENABLED', 1);
END;

-- Define trigger to detect the presence of installed and enabled content : Portugal DLC
CREATE TRIGGER IF NOT EXISTS PortugalDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_PORTUGAL' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_PORTUGAL_ENABLED', 1);
END;

/* ###########################################################################
   	End ENWS Configuration schema
########################################################################### */

/* ###########################################################################
    ENWS : Enhanced Natural Wonders Selection for Civilization VI
    Copyright (c) 2020-2021 zzragnar0kzz
    All rights reserved.
########################################################################### */

/* ###########################################################################
   	Begin ENWS Configuration schema
########################################################################### */

-- Add column(s) to table MapSizes; these define the boundaries and default for the Natural Wonders slider(s)
ALTER TABLE MapSizes ADD MinNaturalWonders INTEGER NOT NULL DEFAULT 0;
ALTER TABLE MapSizes ADD MaxNaturalWonders INTEGER NOT NULL DEFAULT 0;
ALTER TABLE MapSizes ADD DefaultNaturalWonders INTEGER NOT NULL DEFAULT 0;

-- Define table for flagging the presence of available additional content
CREATE TABLE IF NOT EXISTS 'ContentFlags' (
    'Name' TEXT NOT NULL,
	'Enabled' INTEGER NOT NULL DEFAULT 0,
	'CityStates' INTEGER NOT NULL DEFAULT 0,
	'Civilizations' INTEGER NOT NULL DEFAULT 0,
	'NaturalWonders' INTEGER NOT NULL DEFAULT 0,
	'TooltipString' TEXT NOT NULL,
	PRIMARY KEY('Name')
);

-- Define official content flags here; doing so greatly simplifies lua implementation
INSERT INTO ContentFlags (Name, CityStates, Civilizations, NaturalWonders, TooltipString) VALUES 
	('DLC_AZTEC', 0, 1, 0, '[NEWLINE]  DLC: Aztec Civilization Pack'),
	('DLC_POLAND', 0, 1, 0, '[NEWLINE]  DLC: Poland Civilization & Scenario Pack'),
	('DLC_VIKINGS', 1, 1, 1, '[NEWLINE]  DLC: Vikings Scenario Pack'),
	('DLC_AUSTRALIA', 0, 1, 1, '[NEWLINE]  DLC: Australia Civilization & Scenario Pack'),
	('DLC_PERSIA_MACEDON', 0, 1, 0, '[NEWLINE]  DLC: Persia and Macedon Civilization & Scenario Pack'),
	('DLC_NUBIA', 0, 1, 0, '[NEWLINE]  DLC: Nubia Civilization & Scenario Pack'),
	('DLC_KHMER_INDONESIA', 0, 1, 1, '[NEWLINE]  DLC: Khmer and Indonesia Civilization & Scenario Pack'),
	('EXPANSION_1', 0, 1, 1, '[NEWLINE]  Expansion: Rise and Fall'),
	('EXPANSION_2', 1, 1, 1, '[NEWLINE]  Expansion: Gathering Storm'),
	('DLC_GRANCOLOMBIA_MAYA', 1, 1, 1, '[NEWLINE]  DLC: Gran Colombia and Maya Pack'),
	('DLC_ETHIOPIA', 0, 1, 0, '[NEWLINE]  DLC: Ethiopia Pack'),
	('DLC_BYZANTIUM_GAUL', 0, 1, 0, '[NEWLINE]  DLC: Byzantium & Gaul Pack'),
	('DLC_BABYLON', 1, 1, 0, '[NEWLINE]  DLC: Babylon Pack'),
	('DLC_VIETNAM_KUBLAI_KHAN', 0, 1, 0, '[NEWLINE]  DLC: Vietnam & Kublai Khan Pack'),
	('DLC_PORTUGAL', 0, 1, 0, '[NEWLINE]  DLC: Portugal Pack');

-- Define trigger to detect the presence of installed and enabled content : Aztec DLC
CREATE TRIGGER IF NOT EXISTS AztecDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_AZTEC' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_AZTEC';
END;

-- Define trigger to detect the presence of installed and enabled content : Poland DLC
CREATE TRIGGER IF NOT EXISTS PolandDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_POLAND' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_POLAND';
END;

-- Define trigger to detect the presence of installed and enabled content : Vikings DLC
CREATE TRIGGER IF NOT EXISTS VikingsDLC_Enabled AFTER INSERT ON NaturalWonders WHEN NEW.FeatureType = 'FEATURE_EYJAFJALLAJOKULL' AND NEW.Domain = 'StandardNaturalWonders'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_VIKINGS';
END;

-- Define trigger to detect the presence of installed and enabled content : Australia DLC
CREATE TRIGGER IF NOT EXISTS AustraliaDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_AUSTRALIA' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_AUSTRALIA';
END;

-- Define trigger to detect the presence of installed and enabled content : Persia and Macedon DLC
CREATE TRIGGER IF NOT EXISTS PersiaMacedonDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_PERSIA' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_PERSIA_MACEDON';
END;

-- Define trigger to detect the presence of installed and enabled content : Nubia DLC
CREATE TRIGGER IF NOT EXISTS NubiaDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_NUBIA' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_NUBIA';
END;

-- Define trigger to detect the presence of installed and enabled content : Khmer and Indonesia DLC
CREATE TRIGGER IF NOT EXISTS KhmerIndonesiaDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_KHMER' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_KHMER_INDONESIA';
END;

-- Define trigger to detect the presence of installed and enabled content : Expansion 1
CREATE TRIGGER IF NOT EXISTS XP1_Enabled AFTER INSERT ON NaturalWonders WHEN NEW.FeatureType = 'FEATURE_DELICATE_ARCH' AND NEW.Domain = 'Expansion1NaturalWonders'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'EXPANSION_1';
END;

-- Define trigger to detect the presence of installed and enabled content : Expansion 2
CREATE TRIGGER IF NOT EXISTS XP2_Enabled AFTER INSERT ON NaturalWonders WHEN NEW.FeatureType = 'FEATURE_CHOCOLATEHILLS' AND NEW.Domain = 'Expansion2NaturalWonders'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'EXPANSION_2';
END;

-- Define trigger to detect the presence of installed and enabled content : Gran Colombia and Maya DLC
CREATE TRIGGER IF NOT EXISTS GranColombiaMayaDLC_Enabled AFTER INSERT ON NaturalWonders WHEN NEW.FeatureType = 'FEATURE_BERMUDA_TRIANGLE' AND NEW.Domain = 'StandardNaturalWonders'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_GRANCOLOMBIA_MAYA';
END;

-- Define trigger to detect the presence of installed and enabled content : Ethiopia DLC
CREATE TRIGGER IF NOT EXISTS EthiopiaDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_ETHIOPIA' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_ETHIOPIA';
END;

-- Define trigger to detect the presence of installed and enabled content : Byzantium & Gaul DLC
CREATE TRIGGER IF NOT EXISTS ByzantiumGaulDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_BYZANTIUM' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_BYZANTIUM_GAUL';
END;

-- Define trigger to detect the presence of installed and enabled content : Babylon DLC
CREATE TRIGGER IF NOT EXISTS BabylonDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_BABYLON_STK' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_BABYLON';
END;

-- Define trigger to detect the presence of installed and enabled content : Vietnam & Kublai Khan DLC
CREATE TRIGGER IF NOT EXISTS VietnamKublaiKhanDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_VIETNAM' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_VIETNAM_KUBLAI_KHAN';
END;

-- Define trigger to detect the presence of installed and enabled content : Portugal DLC
CREATE TRIGGER IF NOT EXISTS PortugalDLC_Enabled AFTER INSERT ON Players WHEN NEW.CivilizationType = 'CIVILIZATION_PORTUGAL' AND NEW.Domain = 'Players:StandardPlayers'
BEGIN
	UPDATE ContentFlags SET Enabled = 1 WHERE Name = 'DLC_PORTUGAL';
END;

/* ###########################################################################
   	End ENWS Configuration schema
########################################################################### */

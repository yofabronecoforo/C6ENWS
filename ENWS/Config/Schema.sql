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

-- Define trigger to detect the presence of installed and enabled content : Vikings Content DLC
CREATE TRIGGER IF NOT EXISTS VikingsDLC_Enabled AFTER INSERT ON NaturalWonders WHEN NEW.FeatureType = 'FEATURE_EYJAFJALLAJOKULL' AND NEW.Domain = 'StandardNaturalWonders'
BEGIN
	INSERT INTO ContentFlags (Name, Value) VALUES ('DLC_VIKINGSCONTENT_ENABLED', 1);
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

/* ###########################################################################
   	End ENWS Configuration schema
########################################################################### */

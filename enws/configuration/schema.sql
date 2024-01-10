/* ###########################################################################
    C6ENWS : Enhanced Natural Wonders Selection for Civilization VI
    Copyright (c) 2020-2024 zzragnar0kzz
    All rights reserved.
########################################################################### */

/* ###########################################################################
   	begin C6ENWS configuration schema
########################################################################### */

-- Add column(s) to table MapSizes; these define the boundaries and default for the Natural Wonders slider(s)
ALTER TABLE MapSizes ADD MinNaturalWonders INTEGER NOT NULL DEFAULT 0;
ALTER TABLE MapSizes ADD MaxNaturalWonders INTEGER NOT NULL DEFAULT 0;
ALTER TABLE MapSizes ADD DefaultNaturalWonders INTEGER NOT NULL DEFAULT 0;

/* ###########################################################################
   	end C6ENWS configuration schema
########################################################################### */

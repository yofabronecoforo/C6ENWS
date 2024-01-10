--[[ =========================================================================
	C6ENWS : Enhanced Natural Wonders Selection for Civilization VI
	Copyright (C) 2020-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin GameSetupLogic_ENWS.lua frontend script
=========================================================================== ]]
print("[+]: Loading GameSetupLogic_ENWS.lua . . .");

--[[ =========================================================================
	OVERRIDE: replace MapSize_ValueNeedsChanging() wholesale to include necessary changes and avoid multiple DB queries
=========================================================================== ]]
function MapSize_ValueNeedsChanging(p)
	local results = CachedQuery("SELECT * from MapSizes where Domain = ? and MapSizeType = ? LIMIT 1", p.Value.Domain, p.Value.Value);

	-- define min/max/default values for Players, City States, and Natural Wonders; NW values will be used for the slider(s) if ENWS is present
	local minPlayers = 2;
	local maxPlayers = 2;
	local defPlayers = 2;
	local minCityStates = 0;
	local maxCityStates = 0;
	local defCityStates = 0;
	local minNaturalWonders = 0;
	local maxNaturalWonders = 0;
	local defNaturalWonders = 0;

	-- results should only contain one table, so iterating over it is kinda stupid; access values in results[1] directly here instead
	if(results) then
		minPlayers = results[1].MinPlayers;
		maxPlayers = results[1].MaxPlayers;
		defPlayers = results[1].DefaultPlayers;
		minCityStates = results[1].MinCityStates;
		maxCityStates = results[1].MaxCityStates;
		defCityStates = results[1].DefaultCityStates;
		if (results[1].MinNaturalWonders ~= nil) then minNaturalWonders = results[1].MinNaturalWonders; end
		if (results[1].MaxNaturalWonders ~= nil) then maxNaturalWonders = results[1].MaxNaturalWonders; end
		if (results[1].DefaultNaturalWonders ~= nil) then defNaturalWonders = results[1].DefaultNaturalWonders; end
	end

	-- TODO: Add Min/Max city states, set defaults.
	if(MapConfiguration.GetMinMajorPlayers() ~= minPlayers) then
		SetupParameters_Log("Min Major Players: " .. MapConfiguration.GetMinMajorPlayers() .. " should be " .. minPlayers);
		return true;
	elseif(MapConfiguration.GetMaxMajorPlayers() ~= maxPlayers) then
		SetupParameters_Log("Max Major Players: " .. MapConfiguration.GetMaxMajorPlayers() .. " should be " .. maxPlayers);
		return true;
	elseif(MapConfiguration.GetMinMinorPlayers() ~= minCityStates) then
		SetupParameters_Log("Min Minor Players: " .. MapConfiguration.GetMinMinorPlayers() .. " should be " .. minCityStates);
		return true;
	elseif(MapConfiguration.GetMaxMinorPlayers() ~= maxCityStates) then
		SetupParameters_Log("Max Minor Players: " .. MapConfiguration.GetMaxMinorPlayers() .. " should be " .. maxCityStates);
		return true;
	elseif(MapConfiguration.GetValue("MAP_MIN_NATURAL_WONDERS") ~= minNaturalWonders) then
		if (MapConfiguration.GetValue("MAP_MIN_NATURAL_WONDERS") == nil) then
			MapConfiguration.SetValue("MAP_MIN_NATURAL_WONDERS", minNaturalWonders);
		end
		SetupParameters_Log("Min Natural Wonders: ", MapConfiguration.GetValue("MAP_MIN_NATURAL_WONDERS"), " should be ", minNaturalWonders);
		return true;
	elseif(MapConfiguration.GetValue("MAP_MAX_NATURAL_WONDERS") ~= maxNaturalWonders) then
		if (MapConfiguration.GetValue("MAP_MAX_NATURAL_WONDERS") == nil) then
			MapConfiguration.SetValue("MAP_MAX_NATURAL_WONDERS", maxNaturalWonders);
		end
		SetupParameters_Log("Max Natural Wonders: ", MapConfiguration.GetValue("MAP_MAX_NATURAL_WONDERS"), " should be ", maxNaturalWonders);
		return true;
	end

	return false;
end

--[[ =========================================================================
	OVERRIDE: replace MapSize_ValueChanged() wholesale to include necessary changes and avoid multiple DB queries
=========================================================================== ]]
function MapSize_ValueChanged(p)
	SetupParameters_Log("MAP SIZE CHANGED");

	-- The map size has changed!
	-- Adjust the number of players to match the default players of the map size.
	local results = CachedQuery("SELECT * from MapSizes where Domain = ? and MapSizeType = ? LIMIT 1", p.Value.Domain, p.Value.Value);

	-- initialize min/max/default values for Players, City States, and Natural Wonders; NW values will be used for the slider(s) if ENWS is present
	local minPlayers = 2;
	local maxPlayers = 2;
	local defPlayers = 2;
	local minCityStates = 0;
	local maxCityStates = 0;
	local defCityStates = 0;
	local minNaturalWonders = 0;
	local maxNaturalWonders = 0;
	local defNaturalWonders = 0;

	-- results should only contain one table, so iterating over it is kinda stupid; access values in results[1] directly here instead and change the above values as needed
	if(results) then
		minPlayers = results[1].MinPlayers;
		maxPlayers = results[1].MaxPlayers;
		defPlayers = results[1].DefaultPlayers;
		minCityStates = results[1].MinCityStates;
		maxCityStates = results[1].MaxCityStates;
		defCityStates = results[1].DefaultCityStates;
		if (results[1].MinNaturalWonders ~= nil) then minNaturalWonders = results[1].MinNaturalWonders; end
		if (results[1].MaxNaturalWonders ~= nil) then maxNaturalWonders = results[1].MaxNaturalWonders; end
		if (results[1].DefaultNaturalWonders ~= nil) then defNaturalWonders = results[1].DefaultNaturalWonders; end
	end

	-- set min/max/default values for Players, City States, and Natural Wonders
	MapConfiguration.SetMinMajorPlayers(minPlayers);
	MapConfiguration.SetMaxMajorPlayers(maxPlayers);
	MapConfiguration.SetMinMinorPlayers(minCityStates);
	MapConfiguration.SetMaxMinorPlayers(maxCityStates);
	GameConfiguration.SetValue("CITY_STATE_COUNT", defCityStates);
	MapConfiguration.SetValue("MAP_MIN_NATURAL_WONDERS", minNaturalWonders);
	MapConfiguration.SetValue("MAP_MAX_NATURAL_WONDERS", maxNaturalWonders);
	GameConfiguration.SetValue("NATURAL_WONDER_COUNT", defNaturalWonders);

	-- Clamp participating player count in network multiplayer so we only ever auto-spawn players up to the supported limit. 
	local mpMaxSupportedPlayers = 8; -- The officially supported number of players in network multiplayer games.
	local participatingCount = defPlayers + GameConfiguration.GetHiddenPlayerCount();
	if GameConfiguration.IsNetworkMultiplayer() or GameConfiguration.IsPlayByCloud() then
		participatingCount = math.clamp(participatingCount, 0, mpMaxSupportedPlayers);
	end

	SetupParameters_Log("Setting participating player count to " .. tonumber(participatingCount));
	local playerCountChange = GameConfiguration.SetParticipatingPlayerCount(participatingCount);
	Network.BroadcastGameConfig(true);

	-- NOTE: This used to only be called if playerCountChange was non-zero.
	-- This needs to be called more frequently than that because each player slot entry's add/remove button
	-- needs to be potentially updated to reflect the min/max player constraints.
	if(GameSetup_PlayerCountChanged) then
		GameSetup_PlayerCountChanged();
	end
end

--[[ =========================================================================
	log successful loading of this component
=========================================================================== ]]
print("[i]: Finished loading GameSetupLogic_ENWS.lua, proceeding . . .");

--[[ =========================================================================
	end GameSetupLogic_ENWS.lua frontend script
=========================================================================== ]]

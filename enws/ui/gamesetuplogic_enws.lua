--[[ =========================================================================
	C6ENWS : Enhanced Natural Wonders Selection for Civilization VI
	Copyright (C) 2020-2024 yofabronecoforo
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin GameSetupLogic_ENWS.lua frontend script
=========================================================================== ]]
print("[+]: Loading GameSetupLogic_ENWS.lua UI script . . .");

--[[ =========================================================================
	OVERRIDE: pass arguments to pre-ENWS CreatePickerDriverByParameter() if parameter is not the Natural Wonder picker
	otherwise create and return a driver for the Natural Wonder picker
=========================================================================== ]]
Pre_ENWS_CreatePickerDriverByParameter = CreatePickerDriverByParameter;
function CreatePickerDriverByParameter(o, parameter, parent) 
	if parameter.ParameterId ~= "NaturalWonders" then 
		return Pre_ENWS_CreatePickerDriverByParameter(o, parameter, parent);
	end

	if(parent == nil) then
		parent = GetControlStack(parameter.GroupId);
	end
			
	-- Get the UI instance
	local c :object = g_ButtonParameterManager:GetInstance();	

	local parameterId = parameter.ParameterId;
	local button = c.Button;

	-- print(string.format("[+]: Creating driver for %s picker . . .", parameterId));

	button:RegisterCallback( Mouse.eLClick, function()
		LuaEvents.NaturalWonderPicker_Initialize(o.Parameters[parameterId], g_GameParameters);
		Controls.NaturalWonderPicker:SetHide(false);
	end);
	button:SetToolTipString(parameter.Description .. ECFE.Content.Tooltips[GameConfiguration.GetValue("RULESET")][parameterId]);    -- show content sources in tooltip text

	-- Store the root control, NOT the instance table.
	g_SortingMap[tostring(c.ButtonRoot)] = parameter;

	c.ButtonRoot:ChangeParent(parent);
	if c.StringName ~= nil then
		c.StringName:SetText(parameter.Name);
	end

	local cache = {};

	local kDriver :table = {
		Control = c,
		Cache = cache,
		UpdateValue = function(value, p)
			local valueText = value and value.Name or nil;
			local valueAmount :number = 0;
			local priorityAmount :number = GameConfiguration.GetValue("PRIORITY_NATURAL_WONDERS_COUNT") or 0;

			-- only amounts displayed by valueText change now so updates to it have been removed here; can this be further simplified?
			if (valueText == nil) then 
				if (value == nil) then 
					if (parameter.UxHint ~= nil and parameter.UxHint == "InvertSelection") then 
						valueAmount = #p.Values;  -- all available items
					end
				elseif (type(value) == "table") then 
					local count = #value;
					if (parameter.UxHint ~= nil and parameter.UxHint == "InvertSelection") then 
						if (count == 0) then 
							valueAmount = #p.Values;    -- all available items
						else 
							valueAmount = #p.Values - count;    -- custom non-zero selection
						end
					else 
						if (count == #p.Values) then 
							valueAmount = #p.Values;    -- all available items
						else 
							valueAmount = count;    -- custom non-zero selection
						end
					end
				end
			end

			-- update valueText here and append priorityText
			local priorityText = (priorityAmount > 0) and string.format(", %s %d", Locale.Lookup("LOC_PICKER_PRIORITIZED_TEXT"), priorityAmount) or "";
			valueText = string.format("%s %d of %d%s", Locale.Lookup("LOC_PICKER_SELECTED_TEXT"), valueAmount, #p.Values, priorityText);

			-- add update to tooltip text and update to cached PriorityAmount here
			if(cache.ValueText ~= valueText) or (cache.ValueAmount ~= valueAmount) or (cache.PriorityAmount ~= priorityAmount) then 
				local button = c.Button;
				button:LocalizeAndSetText(valueText);
				cache.ValueText = valueText;
				cache.ValueAmount = valueAmount;
				cache.PriorityAmount = priorityAmount;
				button:SetToolTipString(parameter.Description .. ECFE.Content.Tooltips[GameConfiguration.GetValue("RULESET")][parameterId]);    -- show content sources in tooltip text
			end
		end,
		UpdateValues = function(values, p) 
			-- Values are refreshed when the window is open.
		end,
		SetEnabled = function(enabled, p)
			c.Button:SetDisabled(not enabled or #p.Values <= 1);
		end,
		SetVisible = function(visible)
			c.ButtonRoot:SetHide(not visible);
		end,
		Destroy = function()
			g_ButtonParameterManager:ReleaseInstance(c);
		end,
	};	

	return kDriver;
end

--[[ =========================================================================
	OVERRIDE: call pre-ENWS OnShutdown() and remove LuaEvent listeners for the Natural Wonder picker
=========================================================================== ]]
Pre_ENWS_OnShutdown = OnShutdown;
function OnShutdown()
    Pre_ENWS_OnShutdown();
	LuaEvents.NaturalWonderPicker_SetParameterValues.Remove(OnSetParameterValues);
	LuaEvents.NaturalWonderPicker_SetParameterValue.Remove(OnSetParameterValue);
end

--[[ =========================================================================
	reset SetShutdown handler for this context with updated OnShutdown()
=========================================================================== ]]
ContextPtr:SetShutdown( OnShutdown );

--[[ =========================================================================
	add new LuaEvent listeners for the Natural Wonder picker
=========================================================================== ]]
LuaEvents.NaturalWonderPicker_SetParameterValues.Add(OnSetParameterValues);
LuaEvents.NaturalWonderPicker_SetParameterValue.Add(OnSetParameterValue);

--[[ =========================================================================
	OVERRIDE: replace MapSize_ValueNeedsChanging() wholesale to include necessary changes and avoid multiple DB queries
=========================================================================== ]]
-- Pre_ENWS_MapSize_ValueNeedsChanging = MapSize_ValueNeedsChanging;
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
-- Pre_ENWS_MapSize_ValueChanged = MapSize_ValueChanged;
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
	end GameSetupLogic_ENWS.lua frontend script
=========================================================================== ]]

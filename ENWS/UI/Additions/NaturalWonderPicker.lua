-- ###########################################################################
--	ENWS : Enhanced Natural Wonders Selection for Civilization VI
--	Copyright (c) 2020-2023 zzragnar0kzz
--	All rights reserved.
-- ###########################################################################

-- ===========================================================================
-- Multi-Select window
-- currently only (officially) used by the Natural Wonder picker
-- shit will probably break if other mods rely on this logic
-- ===========================================================================

include("InstanceManager");

print("Loading NaturalWonderPicker.lua . . .");

-- ===========================================================================
-- Members
-- ===========================================================================
m_ItemIM = InstanceManager:new("ItemInstance",	"Button", Controls.ItemsPanel);

m_Parameter = nil		-- Reference to the parameter being used. 
m_SelectedValues = nil	-- Table of string->boolean that represents checked off items.
m_PriorityValues = nil  -- ENWS: priority selections table
m_ItemList = nil;		-- Table of controls for select all/none

local m_bInvertSelection:boolean = false;
local m_bInvertPrioritization:boolean = false;    -- ENWS: invert prioritization; this probably isn't necessary, and should remain unchanged
local m_iNumPrioritySelections:number = nil;      -- ENWS: priority selections counter; this is a hack to properly update the priority display in the AS/HG UI

-- ===========================================================================
function Close()	
	-- Clear any temporary global variables.
	m_Parameter = nil;
	m_SelectedValues = nil;
	m_PriorityValues = nil  -- ENWS

	ContextPtr:SetHide(true);
end

-- ===========================================================================
-- ENWS: validate priority selections
-- ===========================================================================
function IsItemPrioritized(item: table) 
	return m_PriorityValues[item.Value] == true;
end

-- ===========================================================================
function IsItemSelected(item: table) 
	return m_SelectedValues[item.Value] == true;
end

-- ===========================================================================
function OnBackButton()
	Close();
end

-- ===========================================================================
function OnConfirmChanges()
	-- Generate sorted list from selected values.
	local values = {}
	for k,v in pairs(m_SelectedValues) do
		if(v) then
			table.insert(values, k);
		end
	end

	--ENWS: generate sorted priority list
	local priority = {};
	for k, v in pairs(m_PriorityValues) do 
		if (v) then 
			table.insert(priority, k);
		end
	end

	print(string.format("[i]: Confirming %d %s and %d priority %s", #values, (#values ~= 1) and "exclusions" or "exclusion", #priority, (#priority ~= 1) and "selections" or "selection"));
	LuaEvents.NaturalWonderPicker_SetParameterValues(m_Parameter.ParameterId, values);
	GameConfiguration.SetValue("PRIORITY_NATURAL_WONDERS", priority);           -- ENWS: store sorted priority list as a game configuration setting
	GameConfiguration.SetValue("PRIORITY_NATURAL_WONDERS_COUNT", #priority);    -- ENWS: update the global priority selections counter
	Close();
end

-- ===========================================================================
-- ENWS: (de)prioritize an item
-- ===========================================================================
function OnItemPrioritize(item :table, checkBox :table, priority :table)
	local value = item.Value;
	local prioritized = not m_PriorityValues[value];

	-- ensure this item's selection box is checked when it is prioritized
	if (prioritized == true) and m_SelectedValues[item.Value] then 
		m_SelectedValues[item.Value] = false;
		checkBox:SetCheck(true);
	end

	m_PriorityValues[item.Value] = prioritized;
	if m_bInvertPrioritization then
		priority:SetCheck(not prioritized);
	else
		priority:SetCheck(prioritized);
	end

	m_iNumPrioritySelections = prioritized and (m_iNumPrioritySelections + 1) or (m_iNumPrioritySelections - 1);    -- ENWS: update the local priority selections counter
	GameConfiguration.SetValue("PRIORITY_NATURAL_WONDERS_COUNT", m_iNumPrioritySelections);                         -- ENWS: update the global priority selections counter
end

-- ===========================================================================
function OnItemSelect(item :table, checkBox :table, priority :table)
	local value = item.Value;
	local selected = not m_SelectedValues[value];

	-- ENWS: ensure this item is not prioritized when its selection box is unchecked >>>
	if (selected == true) and m_PriorityValues[item.Value] then 
		m_PriorityValues[item.Value] = false;
		priority:SetCheck(false);
		m_iNumPrioritySelections = (m_iNumPrioritySelections - 1);                                 -- ENWS: update the local priority selections counter
		GameConfiguration.SetValue("PRIORITY_NATURAL_WONDERS_COUNT", m_iNumPrioritySelections);    -- ENWS: update the global priority selections counter
	end
	-- <<< ENWS

	m_SelectedValues[item.Value] = selected;
	if m_bInvertSelection then
		checkBox:SetCheck(not selected);
	else
		checkBox:SetCheck(selected);
	end
end

-- ===========================================================================
-- ENWS: 
-- ===========================================================================
function CycleCheckboxes(item :table, checkBox :table, priority :table) 
	local value = item.Value;
	if m_SelectedValues[value] and not m_PriorityValues[value] then 
		OnItemSelect(item, checkBox, priority);
	elseif not m_SelectedValues[value] and not m_PriorityValues[value] then 
		OnItemPrioritize(item, checkBox, priority);
	elseif not m_SelectedValues[value] and m_PriorityValues[value] then 
		OnItemSelect(item, checkBox, priority);
	end
end

-- ===========================================================================
function OnItemFocus(item :table)
	if(item) then
		Controls.FocusedItemName:SetText(item.Name);
		Controls.FocusedItemDescription:LocalizeAndSetText(item.RawDescription);

		if((item.Icon and Controls.FocusedItemIcon:SetIcon(item.Icon)) or Controls.FocusedItemIcon:SetIcon("ICON_" .. item.Value)) then
			Controls.FocusedItemIcon:SetHide(false);
		else
			Controls.FocusedItemIcon:SetHide(true);
		end
	end
end

-- ===========================================================================
-- ENWS: (de)prioritize all items
-- ===========================================================================
function PrioritizeAllItems(bState: boolean)
	m_iNumPrioritySelections = bState and 0 or m_iNumPrioritySelections;
	for _, node in ipairs(m_ItemList) do
		local item:table = node["item"];
		local priority:table = node["priority"];

		priority:SetCheck(bState);
		if m_bInvertPrioritization then
			m_PriorityValues[item.Value] = not bState;
		else
			m_PriorityValues[item.Value] = bState;
		end
		m_iNumPrioritySelections = bState and (m_iNumPrioritySelections + 1) or (m_iNumPrioritySelections - 1);
	end
	m_iNumPrioritySelections = (m_iNumPrioritySelections < 0) and 0 or m_iNumPrioritySelections;    -- ENWS: update the local priority selections counter
	GameConfiguration.SetValue("PRIORITY_NATURAL_WONDERS_COUNT", m_iNumPrioritySelections);         -- ENWS: update the global priority selections counter
end

-- ===========================================================================
function SetAllItems(bState: boolean)
	for _, node in ipairs(m_ItemList) do
		local item:table = node["item"];
		local checkBox:table = node["checkbox"];

		checkBox:SetCheck(bState);
		if m_bInvertSelection then
			m_SelectedValues[item.Value] = not bState;
		else
			m_SelectedValues[item.Value] = bState;
		end
	end
end

-- ===========================================================================
-- ENWS: prioritize all items; ensure all items are selected first
-- ===========================================================================
function OnPrioritizeAll()
	SetAllItems(true);           -- ENWS: select all items before prioritizing them
	PrioritizeAllItems(true);
end

-- ===========================================================================
function OnSelectAll()
	SetAllItems(true);
end

-- ===========================================================================
-- ENWS: deprioritize all items
-- ===========================================================================
function OnPrioritizeNone()
	PrioritizeAllItems(false);
end

-- ===========================================================================
function OnSelectNone()
	PrioritizeAllItems(false);    -- ENWS: deprioritize all items before deselecting them
	SetAllItems(false);
end

-- ===========================================================================
function ParameterInitialize(parameter : table)
	m_Parameter = parameter;
	m_SelectedValues = {};
	m_PriorityValues = {};    -- ENWS: track priority selections
	m_iNumPrioritySelections = GameConfiguration.GetValue("PRIORITY_NATURAL_WONDERS_COUNT") or 0;    -- ENWS: (re)initialize the local priority selections counter

	if (parameter.UxHint ~= nil and parameter.UxHint == "InvertSelection") then
		m_bInvertSelection = true;
	else
		m_bInvertSelection = false;
	end

	if(parameter.Value) then
		for i,v in ipairs(parameter.Value) do
			m_SelectedValues[v.Value] = true;
			m_PriorityValues[v.Value] = false;    -- ENWS: initialize priority selections
		end
	end

	-- ENWS: reinitialize priority selections from the game configuration setting when reentering the picker window >>>
	local priorityWondersConfig = GameConfiguration.GetValue("PRIORITY_NATURAL_WONDERS");
	if (priorityWondersConfig and #priorityWondersConfig > 0) then 
		for i,v in ipairs(priorityWondersConfig) do 
			m_PriorityValues[v] = true;
		end
		m_iNumPrioritySelections = #priorityWondersConfig;                                         -- ENWS: reset the local priority selections counter
		GameConfiguration.SetValue("PRIORITY_NATURAL_WONDERS_COUNT", m_iNumPrioritySelections);    -- ENWS: update the global priority selections counter
	end
	-- <<< ENWS

	-- Controls.TopDescription:SetText(parameter.Description);
	Controls.TopDescription:SetText(Locale.Lookup("LOC_EXCLUDE_NATURAL_WONDER_PICKER_DESC"));    -- ENWS: set extended top description
	Controls.WindowTitle:SetText(parameter.Name);
	m_ItemIM:ResetInstances();

	m_ItemList = {};
	for i, v in ipairs(parameter.Values) do
		InitializeItem(v);
	end

	InitNaturalWonderCountSlider();    -- ENWS: initialize the Natural Wonders slider within the picker window

	OnItemFocus(parameter.Values[1]);
end

-- ===========================================================================
-- ENWS: initialize the Natural Wonders slider within the picker window
-- ===========================================================================
function InitNaturalWonderCountSlider()
	-- Retrieve the min, max, and current values of the "actual" Natural Wonders slider; see modified GameSetupLogic.lua
	local minimumNW = MapConfiguration.GetValue("MAP_MIN_NATURAL_WONDERS");
	local maximumNW = MapConfiguration.GetValue("MAP_MAX_NATURAL_WONDERS");
	local currentNW = GameConfiguration.GetValue("NATURAL_WONDER_COUNT");

	-- Set the current value of, and define the controls for, the slider in this window
	Controls.NaturalWonderCountNumber:SetText(currentNW);
	Controls.NaturalWonderCountSlider:SetNumSteps(maximumNW - minimumNW);
	Controls.NaturalWonderCountSlider:SetStep(currentNW - minimumNW);

	Controls.NaturalWonderCountSlider:RegisterSliderCallback(function()
		local stepNum:number = Controls.NaturalWonderCountSlider:GetStep();
		local value:number = minimumNW + stepNum;
			
		-- This method can get called pretty frequently, try and throttle it.
		if(currentNW ~= value) then
			-- Update the current value of the "actual" Natural Wonders slider
			GameConfiguration.SetValue("NATURAL_WONDER_COUNT", value);
			-- Update the current value of the slider in this window
			Controls.NaturalWonderCountNumber:SetText(value);
			Network.BroadcastGameConfig();
		end
	end);
end

-- ===========================================================================
function InitializeItem(item:table)
	local c: table = m_ItemIM:GetInstance();
	c.Name:SetText(item.Name);
	if not item.Icon or not c.Icon:SetIcon(item.Icon) then
		c.Icon:SetIcon("ICON_" .. item.Value);
	end
	c.Button:RegisterCallback( Mouse.eMouseEnter, function() OnItemFocus(item); end );
	-- c.Button:RegisterCallback( Mouse.eLClick, function() OnItemSelect(item, c.Selected, c.Priority); end );
	c.Button:RegisterCallback( Mouse.eLClick, function() CycleCheckboxes(item, c.Selected, c.Priority); end );       -- ENWS: cycle selected --> prioritized --> deselected
	c.Button:SetToolTipString(Locale.Lookup("LOC_NW_BUTTON_TT_TEXT"));                                               -- ENWS: update button tooltip text
	c.Selected:RegisterCallback( Mouse.eLClick, function() OnItemSelect(item, c.Selected, c.Priority); end );        -- ENWS: (un)check the selection box
	c.Selected:SetToolTipString(Locale.Lookup("LOC_NW_SELECTED_TT_TEXT"));                                           -- ENWS: update selected checkbox tooltip text
	c.Priority:RegisterCallback( Mouse.eLClick, function() OnItemPrioritize(item, c.Selected, c.Priority); end );    -- ENWS: (un)check the priority box
	c.Priority:SetToolTipString(Locale.Lookup("LOC_NW_PRIORITY_TT_TEXT"));                                           -- ENWS: update priority checkbox tooltip text
	if m_bInvertSelection then
		c.Selected:SetCheck(not IsItemSelected(item));
	else
		c.Selected:SetCheck(IsItemSelected(item));
	end
	-- ENWS: m_bInvertPrioritization should always be false, so this can probably be shortened >>>
	if m_bInvertPrioritization then 
		c.Priority:SetCheck(not IsItemPrioritized(item));
	else 
		c.Priority:SetCheck(IsItemPrioritized(item));
	end
	-- <<< ENWS

	local listItem:table = {};
	listItem["item"] = item;
	listItem["checkbox"] = c.Selected;
	listItem["priority"] = c.Priority;    -- ENWS: add the priority box to listItem
	table.insert(m_ItemList, listItem);
end

-- ===========================================================================
function OnShutdown()
	Close();
	m_ItemIM:DestroyInstances();
	LuaEvents.NaturalWonderPicker_Initialize.Remove( ParameterInitialize );
end

-- ===========================================================================
function OnInputHandler( pInputStruct:table )
	local uiMsg = pInputStruct:GetMessageType();
	if uiMsg == KeyEvents.KeyUp then
		local key:number = pInputStruct:GetKey();
		if key == Keys.VK_ESCAPE then
			Close();
		end
	end
	return true;
end

-- ===========================================================================
function Initialize()
	ContextPtr:SetShutdown( OnShutdown );
	ContextPtr:SetInputHandler( OnInputHandler, true );

	local OnMouseEnter = function() UI.PlaySound("Main_Menu_Mouse_Over"); end;

	Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnBackButton );
	Controls.CloseButton:RegisterCallback( Mouse.eMouseEnter, OnMouseEnter);
	Controls.ConfirmButton:RegisterCallback( Mouse.eLClick, OnConfirmChanges );
	Controls.ConfirmButton:RegisterCallback( Mouse.eMouseEnter, OnMouseEnter);
	Controls.SelectAllButton:RegisterCallback( Mouse.eLClick, OnSelectAll);
	Controls.SelectAllButton:RegisterCallback( Mouse.eMouseEnter, OnMouseEnter);
	Controls.SelectNoneButton:RegisterCallback( Mouse.eLClick, OnSelectNone);
	Controls.SelectNoneButton:RegisterCallback( Mouse.eMouseEnter, OnMouseEnter);
	-- ENWS: prioritize all and none controls >>>
	-- Controls.PrioritizeAllButton:RegisterCallback( Mouse.eLClick, OnPrioritizeAll);
	-- Controls.PrioritizeAllButton:RegisterCallback( Mouse.eMouseEnter, OnMouseEnter);    -- ENWS: prioritizing all would essentially turn the priority list into the selection list
	Controls.PrioritizeNoneButton:RegisterCallback( Mouse.eLClick, OnPrioritizeNone);
	Controls.PrioritizeNoneButton:RegisterCallback( Mouse.eMouseEnter, OnMouseEnter);
	-- <<< ENWS

	LuaEvents.NaturalWonderPicker_Initialize.Add( ParameterInitialize );
end
Initialize();

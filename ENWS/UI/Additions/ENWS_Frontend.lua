-- ###########################################################################
--	ENWS : Enhanced Natural Wonders Selection for Civilization VI
--	Copyright (c) 2020-2021 zzragnar0kzz
--	All rights reserved.
-- ###########################################################################

-- ===========================================================================
--	Common LUA Frontend components for ENWS
-- ===========================================================================

-- ===========================================================================
--  include ENWS common LUA components
-- ===========================================================================
include("ENWS_Common.lua");

-- ===========================================================================
--	Function for querying the config DB for custom content flags
-- ===========================================================================
function CheckContentFlags()
    print(msgHeader .. "Validating contents of configuration database table ContentFlags . . .");
    local t = {};
    local query = "SELECT * from ContentFlags";
	local result = DB.ConfigurationQuery(query);
    if result and #result > 0 then
        print(msgHeader .. "PASS: table ContentFlags exists and is not empty; parsing defined content flag(s) . . .");
        local definedFlags = 0;
        local enabledFlags = 0;
        for i,v in ipairs(result) do
            definedFlags = definedFlags + 1;
            t[i] = {Name = v.Name, Enabled = v.Enabled, CityStates = v.CityStates, Civilizations = v.Civilizations, NaturalWonders = v.NaturalWonders, TooltipString = v.TooltipString};
            if t[i].Enabled > 0 then
                enabledFlags = enabledFlags + 1;
                local providesCityStates = " Provides City-States: " .. t[i].CityStates;
                local providesCivilizations = " Provides Civilizations: " .. t[i].Civilizations;
                local providesNaturalWonders = " Provides Natural Wonders: " .. t[i].NaturalWonders;
                local isEnabled = " Enabled: " .. t[i].Enabled;
                local addedContent = ":" .. providesCityStates .. " |" .. providesCivilizations .. " |" .. providesNaturalWonders .. " |" .. isEnabled;
                print(msgHeader .. v.Name .. addedContent);
            end
        end
        print(msgHeader .. "Finished parsing table ContentFlags; " .. enabledFlags .. " of " .. definedFlags .. " defined content flag(s) are enabled.");
        return t;
	else
        print(msgHeader .. "FAIL: table ContentFlags is empty or undefined; unable to parse content flag(s).");
        return nil;
	end
end

-- ===========================================================================
--	Function for updating button tooltips to reflect available content
-- ===========================================================================
function UpdateButtonToolTip(parameterId, selectedRuleset)
    local availableContent = "[NEWLINE]Available content:[NEWLINE]  Standard";
    print(msgHeader .. parameterId .. ": Updating button tooltip(s); selected ruleset: " .. selectedRuleset .. " . . .");
    for k,v in ipairs(ContentFlags) do
        if (ContentFlags[k].Name ~= "EXPANSION_1" and ContentFlags[k].Name ~= "EXPANSION_2") then
            if ContentFlags[k].Enabled > 0 then
                if (parameterId == "NaturalWonders" and ContentFlags[k].NaturalWonders > 0)
                or (parameterId == "CityStates" and ContentFlags[k].CityStates > 0) 
                or (parameterId == "LeaderPool1" or parameterId == "LeaderPool2" and ContentFlags[k].Civilizations > 0) then
                    availableContent = availableContent .. ContentFlags[k].TooltipString;
                end
            end
        else
            if ContentFlags[k].Enabled > 0 then
                if (ContentFlags[k].Name == "EXPANSION_1" and selectedRuleset ~= "RULESET_STANDARD") 
                or (ContentFlags[k].Name == "EXPANSION_2" and selectedRuleset ~= "RULESET_STANDARD" and selectedRuleset ~= "RULESET_EXPANSION_1") then
                    availableContent = availableContent .. ContentFlags[k].TooltipString;
                end
            end
        end
    end
    return availableContent;
end

-- ===========================================================================
--	Query the config DB for the presence of official additional content
-- ===========================================================================
ContentFlags = CheckContentFlags();

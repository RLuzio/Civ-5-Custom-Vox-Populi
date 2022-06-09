-- Dreams of Fantasy
-- Author: Wifi_LC
-- DateCreated: 2021-05-21 03:26:00 PM
--------------------------------------------------------------
print("[Dreams of Fantasy Loaded]");

local kCiv = GameInfoTypes.CIVILIZATION_SSC_MARIBEL_HEARN
local kBuilding = GameInfoTypes.BUILDING_DREAMS_OF_FANTASY_DUMMY

-- Assigns happiness when forming/breaking city connections
function UpdateBuildingOnWLTKD(iPlayer, iCity, isActive)
	
	local pPlayer = Players[iPlayer];
	local pCity   = pPlayer:GetCityByID(iCity);

	-- Create or destroy the dummy building based on whether or not WLTKD started or stopped
	if pPlayer:GetCivilizationType() == kCiv then
		if isActive then
			pCity:SetNumRealBuilding(kBuilding, 1)
		else
			pCity:SetNumRealBuilding(kBuilding, 0)
		end
	end
end

LuaEvents.WeLoveTheKingDayChanged.Add(UpdateBuildingOnWLTKD);
		
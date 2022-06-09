-- HappinessFromCityConnections
-- Author: Wifi_LC
-- DateCreated: 2021-05-17 03:26:00 PM
--------------------------------------------------------------
print("[Neo Super Express]");

local kCiv      = GameInfoTypes.CIVILIZATION_SSC_USAMI_RENKO
local kBuilding = GameInfoTypes.BUILDING_NEO_SUPER_EXPRESS_DUMMY

-- Assigns happiness when forming/breaking city connections
function UpdateBuilding(iPlayer, iCity, isConnected)
	
	local pPlayer = Players[iPlayer];
	local pCity   = pPlayer:GetCityByID(iCity);

	-- Create or destroy the dummy building based on whether or not the connnection was created or broken
	if pPlayer:GetCivilizationType() == kCiv and not pCity:IsCapital() then
		if isConnected then
			pCity:SetNumRealBuilding(kBuilding, 1)
			print("Building dummy added")
		else
			pCity:SetNumRealBuilding(kBuilding, 0)
			print("Building dummy removed")
		end
	end
end

LuaEvents.CityConnectionChanged.Add(UpdateBuilding);
		
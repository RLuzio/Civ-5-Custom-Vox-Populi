-- CityConnectionEvents
-- Author: Troller0001
-- DateCreated: 2019-03-04
--------------------------------------------------------------
--per player, stores whether each of their cities is connected to the capital
local tConnections = {};

function initCityConnectionTable()
    for iPlayer = 0, GameDefines.MAX_PLAYERS-1,1 do
        local pPlayer = Players[iPlayer];
        if pPlayer:IsEverAlive() then
            tConnections[iPlayer] = {};
        end
    end
	print("[Init City Connections table for Neo Super Express]");
end
initCityConnectionTable();


function findNewCityConnections(iPlayer)
    local pPlayer = Players[iPlayer];
    for pCity in pPlayer:Cities() do
        local iCity = pCity:GetID();
        if tConnections[iPlayer][iCity] == nil and pPlayer:IsCapitalConnectedToCity(pCity) then
            --new city connection established
            tConnections[iPlayer][iCity] = true;
			print("[City Connection Established]");
            LuaEvents.CityConnectionChanged(iPlayer, iCity, true);
        elseif tConnections[iPlayer][iCity] == true and not pPlayer:IsCapitalConnectedToCity(pCity) then
            --city connection broken
            tConnections[iPlayer][iCity] = nil;
			print("[City Connection Broken]");
            LuaEvents.CityConnectionChanged(iPlayer, iCity, false);
        end
    end
end
GameEvents.PlayerDoTurn.Add(findNewCityConnections);
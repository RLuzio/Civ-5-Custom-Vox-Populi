-- WLTKDEvents
-- Author: Wifi_LC
-- DateCreated: 2021-05-21
--------------------------------------------------------------
--per player, stores whether each of their cities was previously in WLTKD
local tWLTKD      = {}

function initWLTKDTable()
    
	for iPlayer = 0, GameDefines.MAX_PLAYERS-1,1 do
        
		local pPlayer = Players[iPlayer]
        
		if pPlayer:IsEverAlive() then
            tWLTKD[iPlayer] = {};
        end
    end
	print("[Init tables for Dreams of Fantasy]");
end
initWLTKDTable();

function TrackWLTKD(iPlayer)
    
	local pPlayer = Players[iPlayer];
	local tCities = tWLTKD[iPlayer];

    for pCity in pPlayer:Cities() do

        local iCity = pCity:GetID();

        if tWLTKD[iPlayer][iCity] == nil and pCity:GetWeLoveTheKingDayCounter() > 0 then
            -- WLTKD Started
            tWLTKD[iPlayer][iCity] = true;
			print("[WLTKD Started]");
            LuaEvents.WeLoveTheKingDayChanged(iPlayer, iCity, true);
        elseif tWLTKD[iPlayer][iCity] == true and pCity:GetWeLoveTheKingDayCounter() <= 0 then
            -- WLTKD Ended
            tWLTKD[iPlayer][iCity] = nil;
			print("[WLTKD Ended]");
            LuaEvents.WeLoveTheKingDayChanged(iPlayer, iCity, false);
        end
    end
end
GameEvents.PlayerDoTurn.Add(TrackWLTKD)
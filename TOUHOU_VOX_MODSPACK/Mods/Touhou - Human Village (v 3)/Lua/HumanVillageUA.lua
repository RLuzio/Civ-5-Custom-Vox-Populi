print ("loaded Human Village UA Lua") 

include( "SaveUtils" ); MY_MOD_NAME = "HumanVillage";

local iWaterMill = GameInfoTypes.BUILDING_WATERMILL

function HVUA (iPlayer)
	local pPlayer = Players[iPlayer];

	if (pPlayer:IsMinorCiv() or pPlayer:IsBarbarian() or (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_TOUHOU_HV"])) then
		return;
	end
	
	for pCity in pPlayer:Cities() do
		strCityName = pCity:GetName()
		--print("Checking " .. strCityName);
		if load( pPlayer, iPlayer .. "and" .. strCityName .. "hasSpawnedWorker") ~= true then
			--print("Previously no Watermill or Aqueduct in " .. strCityName)
			if pCity:IsHasBuilding(iWaterMill) then
				--print("Now has Watermill or Aqueduct")
				save( pPlayer, iPlayer .. "and" .. strCityName .. "hasSpawnedWorker", true );
				local pPlot = pCity:Plot()
				local iUnitID = GameInfo.Units.UNIT_WORKER.ID
				pPlayer:InitUnit (iUnitID, pCity:GetX(), pCity:GetY() );
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(HVUA)
GameEvents.PlayerAdoptPolicy.Add(HVUA)

function CityScreenHVUA()
	local iPlayer = Game.GetActivePlayer()
	HVUA(iPlayer)
end
Events.SerialEventExitCityScreen.Add(CityScreenHVUA)
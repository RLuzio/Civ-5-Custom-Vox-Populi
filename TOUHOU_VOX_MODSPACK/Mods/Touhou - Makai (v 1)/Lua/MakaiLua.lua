-- MakaiLua
-- Author: user
-- DateCreated: 1/15/2014 9:58:37 AM
--------------------------------------------------------------

print("Demonic Tourism lua loaded")

local RenFactor = 0.5
local IndFactor = 0.33
local ModFactor = 0.1
local MaxChance = 20


function DemonicGateway(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_TH_MAKAI) then
			local pCity = pPlayer:GetCapitalCity();
			local iRandom = Game.Rand(100, "Rolling for demons");
			local eraValue = pPlayer:GetCurrentEra();
			local iTourism = pPlayer:GetTourism();

			local iRenChance = math.floor(iTourism * RenFactor);
			if iRenChance > MaxChance then
				iRenChance = MaxChance;
			end
			print("Ren Chance = " .. iRenChance)
			local iIndChance = math.floor(iTourism * IndFactor);
			if iIndChance > MaxChance then
				iIndChance = MaxChance;
			end
			print("Ind Chance = " .. iIndChance)
			local iModChance = math.floor(iTourism * ModFactor);
			if iModChance > MaxChance then
				iModChance = MaxChance;
			end
			print("Mod Chance = " .. iModChance)

			print("Number rolled: " .. iRandom)
			if (eraValue == GameInfo.Eras["ERA_RENAISSANCE"].ID) then
				if (iRandom < iRenChance) then
					local iUnitID = GameInfo.Units.UNIT_MAKAI_DEMON_1.ID
					pPlayer:InitUnit (iUnitID, pCity:GetX(), pCity:GetY() );
					if pPlayer:IsHuman() then
						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Demons!" ,"A group of lesser demons has arrived from Makai!", -1, -1);
					end
				end
			end
			if (eraValue == GameInfo.Eras["ERA_INDUSTRIAL"].ID) then
				if (iRandom < iIndChance) then
					local iUnitID = GameInfo.Units.UNIT_MAKAI_DEMON_2.ID
					pPlayer:InitUnit (iUnitID, pCity:GetX(), pCity:GetY() );
					if pPlayer:IsHuman() then
						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Demons!" ,"A group of demons has arrived from Makai!", -1, -1);
					end
				elseif (iRandom < iRenChance) then
					local iUnitID = GameInfo.Units.UNIT_MAKAI_DEMON_1.ID
					pPlayer:InitUnit (iUnitID, pCity:GetX(), pCity:GetY() );
					if pPlayer:IsHuman() then
						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Demons!" ,"A group of lesser demons has arrived from Makai!", -1, -1);
					end
				end
			end
			if (eraValue > GameInfo.Eras["ERA_INDUSTRIAL"].ID) then
				if (iRandom < iModChance) then
					local iUnitID = GameInfo.Units.UNIT_MAKAI_DEMON_3.ID
					pPlayer:InitUnit (iUnitID, pCity:GetX(), pCity:GetY() );
					if pPlayer:IsHuman() then
						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Demons!" ,"A group of greater demons has arrived from Makai!", -1, -1);
					end
				elseif (iRandom < iIndChance) then
					local iUnitID = GameInfo.Units.UNIT_MAKAI_DEMON_2.ID
					pPlayer:InitUnit (iUnitID, pCity:GetX(), pCity:GetY() );
					if pPlayer:IsHuman() then
						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Demons!" ,"A group of demons has arrived from Makai!", -1, -1);
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(DemonicGateway)
-- Lua Script1
-- Author: user
-- DateCreated: 12/22/2013 11:39:38 AM
--------------------------------------------------------------

print("Moriya Shrine lua loaded")

local PowerOfFaith = GameInfo.UnitPromotions["PROMOTION_POWER_OF_FAITH"].ID
local iCiv = GameInfoTypes.CIVILIZATION_MORIYA
local iTraitDummy = GameInfoTypes.BUILDING_MORIYA_UA
local iFeature = GameInfoTypes.TERRAIN_MOUNTAIN

function MoriyaYieldFromFeature(iPlayer)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		local pPlayer = Players[iPlayer]
		if pPlayer:GetCivilizationType() == iCiv then
			for pCity in pPlayer:Cities() do
				local iNumPlots = pCity:GetNumCityPlots();
				local iNumBuildings = 0;
				local strCityName = pCity:GetName();
				--print("Checking " .. strCityName)
				for iPlot = 0, iNumPlots - 1 do
					local pPlot = pCity:GetCityIndexPlot(iPlot)
					if pPlot and pPlot:GetOwner() == iPlayer and pPlot:IsMountain() then
						--print("Found a mountain")
						iNumBuildings = iNumBuildings + 1
					end
				end
				--print("Total mountains found: " .. iNumBuildings)
				pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_MORIYA_UA"], iNumBuildings)
				--print(strCityName .. " now has " .. pCity:GetNumRealBuilding(iTraitDummy) )
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(MoriyaYieldFromFeature)

function PowerOfFaithCalc(iPlayer)
	local pPlayer = Players[iPlayer];
	for unit in pPlayer:Units() do
		if unit:IsHasPromotion(PowerOfFaith) then
			local iStrength = GameInfo.Units[unit:GetUnitType()].Combat
			local iDeltaS = math.floor((pPlayer:GetTotalFaithPerTurn() * 0.25 ))
			--print("Combat bonus from faith: " .. iDeltaS)
			if iDeltaS < 0 then
				return
			elseif iDeltaS > 6 then
				unit:SetBaseCombatStrength(iStrength + 6)
			else
				unit:SetBaseCombatStrength(iStrength + iDeltaS)
			end
		else
		end
	end
end
GameEvents.PlayerDoTurn.Add(PowerOfFaithCalc)

function MoriyaTaishaFaith(playerID)
	local player = Players[playerID];
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MORIYA"] then
		for city in player:Cities() do
			if city:IsHasBuilding(GameInfoTypes["BUILDING_TAISHA"]) then
				if player:GetCapitalCity():GetReligiousMajority() > 0 then
					local numFollowers = math.floor(city:GetNumFollowers(player:GetCapitalCity():GetReligiousMajority()) / 2)
					local strCityName = city:GetName();
					--print(strCityName .. " NumFollowers: " .. numFollowers)
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_TAISHA_DUMMY"], numFollowers)
				else
					if city:IsHasBuilding(GameInfoTypes["BUILDING_TAISHA_DUMMY"]) then
						city:SetNumRealBuilding(GameInfoTypes["BUILDING_TAISHA_DUMMY"], 0)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(MoriyaTaishaFaith)

function MoriyaUAScience(playerID)
	local player = Players[playerID];
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MORIYA"] then
		for city in player:Cities() do
			local iFaithPerTurn = math.floor(city:GetFaithPerTurn())/2;
			local strCityName = city:GetName();
			--print(strCityName .. " SciencePerTurn: " .. iFaithPerTurn)
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_MORIYA_UA_2"], iFaithPerTurn)
		end
	end
end
GameEvents.PlayerDoTurn.Add(MoriyaUAScience)

function MoriyaUAFaithFromTech(iTeam, iTech, iChange)
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do 
		if (Players[iPlayer] ~= nil) then
			local pPlayer = Players[iPlayer];
			if ((pPlayer:GetTeam() == iTeam) and (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MORIYA"])) then
				local strTechName = Locale.ConvertTextKey(GameInfo.Technologies[iTech].Description)
				local iEra = pPlayer:GetCurrentEra()
				local iTechFactor = 10 + (iEra * 5)
				local iFaithChange = math.floor((GameInfo.Technologies[iTech].Cost) / iTechFactor)
				pPlayer:ChangeFaith(iFaithChange);
				--print("Added " .. iFaithChange .. " Faith from discovering tech " .. strTechName)
				sNotificationString = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_MORIYA_FAITH_FROM_TECH_UPDATE_TEXT", iFaithChange, strTechName)
				sNotificationTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_MORIYA_FAITH_FROM_TECH_UPDATE_TITLE")
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sNotificationString, sNotificationTitle, -1, -1)
			end
		end
	end
end
GameEvents.TeamTechResearched.Add(MoriyaUAFaithFromTech)


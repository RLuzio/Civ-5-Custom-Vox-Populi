-- OniClansLua
-- Author: user
-- DateCreated: 5/14/2014 6:03:30 PM
--------------------------------------------------------------

print("Oni Clans Lua loaded")
include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "TouhouOni";

local iTouhouOniCiv = GameInfoTypes.CIVILIZATION_TOUHOU_ONI
local iBrewery = GameInfoTypes.BUILDING_ONI_BREWERY
local iGoldenAgeBrewery = GameInfoTypes.BUILDING_ONI_GOLDEN_AGE_BREWERY
local KishinStrength = GameInfo.UnitPromotions["PROMOTION_KISHIN_STRENGTH"].ID

function SuikaTurnFunction(iPlayer)
	local pPlayer = Players[iPlayer];
	--print("Calling Suika's Turn Function")
	if pPlayer:GetCivilizationType() == iTouhouOniCiv then
		for pCity in pPlayer:Cities() do
			if (pPlayer:IsGoldenAge() and (pCity:GetNumBuilding(iBrewery) > 0)) then
				local strCityName = pCity:GetName();	
				--print("Spawning Golden Age Brewery in " .. strCityName)
				pCity:SetNumRealBuilding(iGoldenAgeBrewery, 1)
			else
				pCity:SetNumRealBuilding(iGoldenAgeBrewery, 0)
			end	
		end
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_KISHIN_STRENGTH) then
				local iDeltaS = 12
				local eraValue = pPlayer:GetCurrentEra();
				--print("Kishin Strength: Current Era = " .. eraValue)
				if (eraValue == GameInfo.Eras["ERA_CLASSICAL"].ID) then
					iDeltaS = 18;
				end
				if (eraValue == GameInfo.Eras["ERA_MEDIEVAL"].ID) then
					iDeltaS = 27;
				end
				if (eraValue == GameInfo.Eras["ERA_RENAISSANCE"].ID) then
					iDeltaS = 36;
				end
				if (eraValue == GameInfo.Eras["ERA_INDUSTRIAL"].ID) then
					iDeltaS = 50;
				end
				if (eraValue > GameInfo.Eras["ERA_INDUSTRIAL"].ID) then
					iDeltaS = 75;
				end
				pUnit:SetBaseCombatStrength(iDeltaS)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(SuikaTurnFunction)

function Onikakushi(iLoser, bCapital, iX, iY, iVictor)
	local pLoser = Players[iLoser]
	local sLoserName = pLoser:GetName()
	local iLoserCiv = pLoser:GetCivilizationType()
	local sLoserCivName = GameInfo.Civilizations[iLoserCiv].Type
	local pVictor = Players[iVictor]
	local sVictorName = pVictor:GetName()
	local iVictorCiv = pVictor:GetCivilizationType()
	local sVictorCivName = GameInfo.Civilizations[iVictorCiv].Type
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	local sCityName = pCity:GetName()
	local pVictorCapital = pVictor:GetCapitalCity()
	WasCapturedBefore = load ( pPlayer, "OnikakushiCapture" .. iX .. iY .. "")

	--print("Onikakushi: Detected a city being captured. City is Capital: " .. tostring(bCapital))
	--print("Onikakushi: The city of " .. sCityName .. " at coordinates " .. iX .. " / " .. iY .. " has been taken.")
	--print("Onikakushi: Victorious player " .. iVictor .. " (" .. sVictorName .. ") of civilization " .. iVictorCiv .. " (" .. sVictorCivName .. ") claimed " .. sCityName .. " from defeated player " .. iLoser .. " (" .. sLoserName .. ") of civilization " .. iLoserCiv .. " (" .. sLoserCivName .. ")")
	if ((iVictorCiv == iTouhouOniCiv) and (pCity:GetOriginalOwner() ~= iTouhouOniCiv) and (WasCapturedBefore ~= true)) then
		--pCity:ChangePopulation(-1, true)
		save ( pPlayer, "OnikakushiCapture" .. iX .. iY .. "", true)
		pVictorCapital:ChangePopulation(1, true)
	end
	--print("Onikakushi: Function Onikakushi ended.")
end
GameEvents.CityCaptureComplete.Add(Onikakushi)


function KishinStrength(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
        if (pPlayer:GetCivilizationType() == iTouhouOniCiv) then
		if pPlayer:GetUnitByID(iUnit) ~= nil then
			pUnit = pPlayer:GetUnitByID(iUnit);
			if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_KISHIN_STRENGTH) then
				local iDeltaS = 12
				local eraValue = pPlayer:GetCurrentEra();
				if (eraValue == GameInfo.Eras["ERA_CLASSICAL"].ID) then
					iDeltaS = 18;
				end
				if (eraValue == GameInfo.Eras["ERA_MEDIEVAL"].ID) then
					iDeltaS = 27;
				end
				if (eraValue == GameInfo.Eras["ERA_RENAISSANCE"].ID) then
					iDeltaS = 36;
				end
				if (eraValue == GameInfo.Eras["ERA_INDUSTRIAL"].ID) then
					iDeltaS = 50;
				end
				if (eraValue > GameInfo.Eras["ERA_INDUSTRIAL"].ID) then
					iDeltaS = 75;
				end
				pUnit:SetBaseCombatStrength(iDeltaS)
			end
           	 end
        end
    end
end

Events.SerialEventUnitCreated.Add(KishinStrength)


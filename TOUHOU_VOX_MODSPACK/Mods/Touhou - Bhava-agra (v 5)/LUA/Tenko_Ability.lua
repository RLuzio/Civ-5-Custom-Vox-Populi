-- Tenko_Ability
-- Author: Mathetes tou Megalou Alexandrou
-- DateCreated: 6/4/2016 9:29:09 PM
--------------------------------------------------------------
include("PlotIterators.lua")

local TenkoCiv = GameInfoTypes["CIVILIZATION_MATHALX_CELESTIAL"]
local HappinessDummy = GameInfoTypes["BUILDING_MATHALX_CELESTIAL_HAPPINESS_BONUS_DUMMY"]
local GABDummy = GameInfoTypes["BUILDING_MATHALX_CELESTIAL_GOLDEN_AGE_BONUS_DUMMY"]
local GADummy = GameInfoTypes["BUILDING_MATHALX_CELESTIAL_GOLDEN_AGE_DUMMY"]
local iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100)

local iPleasantWeather = GameInfoTypes["BUILDING_MATHALX_PLEASANT_WEATHER"]
local iDrizzle = GameInfoTypes["BUILDING_MATHALX_DRIZZLE"]
local iCloudy = GameInfoTypes["BUILDING_MATHALX_CLOUDY"]
local iMisty = GameInfoTypes["BUILDING_MATHALX_MISTY"]
local iSnow = GameInfoTypes["BUILDING_MATHALX_SNOW"]
local iAzureSky = GameInfoTypes["BUILDING_MATHALX_AZURE_SKY"]
local iSunshower = GameInfoTypes["BUILDING_MATHALX_SUNSHOWER"]
local iBorealis = GameInfoTypes["BUILDING_MATHALX_BOREALIS"]

local iDPleasantWeather = GameInfoTypes["BUILDING_MATHALX_PLEASANT_WEATHER_DUMMY"]
local iDDrizzle = GameInfoTypes["BUILDING_MATHALX_DRIZZLE_DUMMY"]
local iDCloudy = GameInfoTypes["BUILDING_MATHALX_CLOUDY_DUMMY"]
local iDMisty = GameInfoTypes["BUILDING_MATHALX_MISTY_DUMMY"]
local iDSnow = GameInfoTypes["BUILDING_MATHALX_SNOW_DUMMY"]
local iDAzureSky = GameInfoTypes["BUILDING_MATHALX_AZURE_SKY_DUMMY"]
local iDSunshower = GameInfoTypes["BUILDING_MATHALX_SUNSHOWER_DUMMY"]
local iDBorealis = GameInfoTypes["BUILDING_MATHALX_BOREALIS_DUMMY"]

local iPPleasantWeather = GameInfoTypes["PROMOTION_MATHALX_PLEASANT_WEATHER"]
local iPDrizzle = GameInfoTypes["PROMOTION_MATHALX_DRIZZLE"]
local iPCloudy = GameInfoTypes["PROMOTION_MATHALX_CLOUDY"]
local iPMisty = GameInfoTypes["PROMOTION_MATHALX_MISTY"]
local iPSnow = GameInfoTypes["PROMOTION_MATHALX_SNOW"]
local iPAzureSky = GameInfoTypes["PROMOTION_MATHALX_AZURE_SKY"]
local iPSunshower = GameInfoTypes["PROMOTION_MATHALX_SUNSHOWER"]

local iKeystone = GameInfoTypes["IMPROVEMENT_MATHALX_CELESTIAL_KEYSTONE"]

local poleis = {}
local string

function GoldenAgeGlobal(agonistes)
	local proteuousa = agonistes:GetCapitalCity()
	proteuousa:SetNumRealBuilding(HappinessDummy, 0)

	local happiness = agonistes:GetExcessHappiness()
	if happiness < 0 then
		local ang = -happiness
		proteuousa:SetNumRealBuilding(HappinessDummy, math.ceil(ang))
	end
	if agonistes:GetAnarchyNumTurns() > 0 then
		agonistes:ChangeAnarchyNumTurns(-(agonistes:GetAnarchyNumTurns()))
	end
	for asty in agonistes:Cities() do
		if asty:GetResistanceTurns() > 0 then
			asty:ChangeResistanceTurns(-(asty:GetResistanceTurns()))
		end
	end
	if proteuousa:GetNumBuilding(GADummy) <= 0 then
		proteuousa:SetNumRealBuilding(GADummy, 1)
	end
end

function getAstyErgaste(agonistes, kleros)
	local asty = nil
	local ergasia = false
	local diastasis = 9001
	for astyEpilekte in agonistes:Cities() do
		if astyEpilekte:IsWorkingPlot(kleros) then
			ergasia = true
			asty = astyEpilekte
		elseif diastasis > Map.PlotDistance(kleros:GetX(), kleros:GetY(), astyEpilekte:Plot():GetX(), astyEpilekte:Plot():GetY()) and not ergasia then
			diastasis = Map.PlotDistance(kleros:GetX(), kleros:GetY(), astyEpilekte:Plot():GetX(), astyEpilekte:Plot():GetY())
			asty = astyEpilekte
		end
	end
	return asty
end

function canHasWeatherPromotion(taxeis)
	if taxeis:IsHasPromotion(iPPleasantWeather) then
		return false
	end
	if taxeis:IsHasPromotion(iPDrizzle) then
		return false
	end
	if taxeis:IsHasPromotion(iPCloudy) then
		return false
	end
	if taxeis:IsHasPromotion(iPMisty) then
		return false
	end
	if taxeis:IsHasPromotion(iPSnow) then
		return false
	end
	if taxeis:IsHasPromotion(iPAzureSky) then
		return false
	end
	if taxeis:IsHasPromotion(iPSunshower) then
		return false
	end

	return true
end

function CallTenko()
	local agonistes = Players[Game.GetActivePlayer()]
	if (agonistes:IsAlive() and agonistes:GetCivilizationType() == TenkoCiv) and agonistes:GetGoldenAgeTurns() > 0 then
		GoldenAgeGlobal(agonistes)
	end
end

function lockTenkoGABuildings(iPlayer, iCity, eBuilding, gold, FoC)
	local agonistes = Players[iPlayer]
	local asty = agonistes:GetCityByID(iCity)
	if eBuilding == iPleasantWeather then
		if agonistes:GetCivilizationType() ~= TenkoCiv or agonistes:GetGoldenAgeTurns() <= 0 then
			return false
		end
	elseif eBuilding == iDrizzle then
		if agonistes:GetCivilizationType() ~= TenkoCiv or agonistes:GetGoldenAgeTurns() <= 0 then
			return false
		end
	elseif eBuilding == iCloudy then
		if agonistes:GetCivilizationType() ~= TenkoCiv or agonistes:GetGoldenAgeTurns() <= 0 then
			return false
		end
	elseif eBuilding == iMisty then
		if agonistes:GetCivilizationType() ~= TenkoCiv or agonistes:GetGoldenAgeTurns() <= 0 then
			return false
		end
	elseif eBuilding == iSnow then
		if agonistes:GetCivilizationType() ~= TenkoCiv or agonistes:GetGoldenAgeTurns() <= 0 then
			return false
		end
	elseif eBuilding == iAzureSky then
		if agonistes:GetCivilizationType() ~= TenkoCiv or agonistes:GetGoldenAgeTurns() <= 0 then
			return false
		end
	elseif eBuilding == iSunshower then
		if agonistes:GetCivilizationType() ~= TenkoCiv or agonistes:GetGoldenAgeTurns() <= 0 then
			return false
		end
	elseif eBuilding == iBorealis then
		if agonistes:GetCivilizationType() ~= TenkoCiv or agonistes:GetGoldenAgeTurns() <= 0 then
			return false
		end
	end
	return true
end

GameEvents.CityCanConstruct.Add(lockTenkoGABuildings)

function TenkoGoldenAge(playerID)
	local player = Players[playerID]
	if (player:IsAlive() and player:GetCivilizationType() == TenkoCiv) then
		local proteuousa = player:GetCapitalCity()
		if player:GetGoldenAgeTurns() > 0 then
			GoldenAgeGlobal(player)
			poleis = {}
			local size = 0
			string = Locale.ConvertTextKey("TXT_KEY_MATHALX_TENKO_GOLDEN_AGE_BONUS_IMMINENT") .. "\n\n"
			for asty in player:Cities() do
				asty:SetNumRealBuilding(GABDummy, asty:GetNumBuilding(GABDummy) + 1)

				local plethos = 0

				asty:SetNumRealBuilding(iDPleasantWeather, 0)
				asty:SetNumRealBuilding(iDDrizzle, 0)
				asty:SetNumRealBuilding(iDCloudy, 0)
				asty:SetNumRealBuilding(iDMisty, 0)
				asty:SetNumRealBuilding(iDSnow, 0)
				asty:SetNumRealBuilding(iDAzureSky, 0)
				asty:SetNumRealBuilding(iDSunshower, 0)
				asty:SetNumRealBuilding(iDBorealis, 0)

				for kleros in PlotAreaSweepIterator(asty, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if	kleros:GetImprovementType() == iKeystone and asty:IsWorkingPlot(kleros) then
						plethos = plethos + 1
					end
				end

				--print(plethos)

				if asty:GetNumBuilding(iPleasantWeather) > 0 then
					asty:SetNumRealBuilding(iDPleasantWeather, plethos)
				end
				if asty:GetNumBuilding(iDrizzle) > 0 then
					asty:SetNumRealBuilding(iDDrizzle, plethos)
				end
				if asty:GetNumBuilding(iCloudy) > 0 then
					asty:SetNumRealBuilding(iDCloudy, plethos)
				end
				if asty:GetNumBuilding(iMisty) > 0 then
					asty:SetNumRealBuilding(iDMisty, plethos)
				end
				if asty:GetNumBuilding(iSnow) > 0 then
					asty:SetNumRealBuilding(iDSnow, plethos)
				end
				if asty:GetNumBuilding(iAzureSky) > 0 then
					asty:SetNumRealBuilding(iDAzureSky, plethos)
				end
				if asty:GetNumBuilding(iSunshower) > 0 then
					asty:SetNumRealBuilding(iDSunshower, plethos)
				end
				if asty:GetNumBuilding(iBorealis) > 0 then
					asty:SetNumRealBuilding(iDBorealis, plethos)
				end

				if asty:GetNumBuilding(GABDummy) == 10 then
					size = size + 1
					poleis[asty] = asty
				end

				if poleis[asty] ~= nil then
					string = string .. "[NEWLINE]" .. Locale.ConvertTextKey(asty:GetNameKey()) 
				end
			end

			if size > 0 and player:IsHuman() then
				Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, string,  Locale.ConvertTextKey("TXT_KEY_MATHALX_TENKO_GOLDEN_AGE_BONUS_SHORT"))
			end

			for taxeis in player:Units() do
				local kleros = taxeis:GetPlot()
				if kleros:GetImprovementType() == iKeystone and kleros:GetOwner() == taxeis:GetOwner() then
					local asty = getAstyErgaste(player, kleros)
					if asty ~= nil then
						if asty:GetNumBuilding(iBorealis) > 0 then
							taxeis:ChangeDamage(-100)
						end
						if canHasWeatherPromotion(taxeis) then
							if asty:GetNumBuilding(iPleasantWeather) > 0 then
								taxeis:SetHasPromotion(iPPleasantWeather, true)
							end
							if asty:GetNumBuilding(iDrizzle) > 0 then
								taxeis:SetHasPromotion(iPDrizzle, true)
							end
							if asty:GetNumBuilding(iCloudy) > 0 then
								taxeis:SetHasPromotion(iPCloudy, true)
							end
							if asty:GetNumBuilding(iMisty) > 0 then
								taxeis:SetHasPromotion(iPMisty, true)
							end
							if asty:GetNumBuilding(iSnow) > 0 then
								taxeis:SetHasPromotion(iPSnow, true)
							end
							if asty:GetNumBuilding(iAzureSky) > 0 then
								taxeis:SetHasPromotion(iPAzureSky, true)
							end
							if asty:GetNumBuilding(iSunshower) > 0 then
								taxeis:SetHasPromotion(iPSunshower, true)
							end
						end
					end
				end
			end
		else
			proteuousa:SetNumRealBuilding(HappinessDummy, 0)
			if proteuousa:GetNumBuilding(GADummy) > 0 then
				proteuousa:SetNumRealBuilding(GADummy, 0)
				--Remove comment mark to enable Anarchy penalty
				--local iTurns = math.floor(2 * iMod)
				--player:ChangeAnarchyNumTurns(iTurns)
			end

			for asty in player:Cities() do
				asty:SetNumRealBuilding(iDPleasantWeather, 0)
				asty:SetNumRealBuilding(iDDrizzle, 0)
				asty:SetNumRealBuilding(iDCloudy, 0)
				asty:SetNumRealBuilding(iDMisty, 0)
				asty:SetNumRealBuilding(iDSnow, 0)
				asty:SetNumRealBuilding(iDAzureSky, 0)
				asty:SetNumRealBuilding(iDSunshower, 0)
				asty:SetNumRealBuilding(iDBorealis, 0)

				asty:SetNumRealBuilding(iPleasantWeather, 0)
				asty:SetNumRealBuilding(iDrizzle, 0)
				asty:SetNumRealBuilding(iCloudy, 0)
				asty:SetNumRealBuilding(iMisty, 0)
				asty:SetNumRealBuilding(iSnow, 0)
				asty:SetNumRealBuilding(iAzureSky, 0)
				asty:SetNumRealBuilding(iSunshower, 0)
				asty:SetNumRealBuilding(iBorealis, 0)
			end

			for taxeis in player:Units() do
				if not canHasWeatherPromotion(taxeis) then
					taxeis:SetHasPromotion(iPPleasantWeather, false)
					taxeis:SetHasPromotion(iPDrizzle, false)
					taxeis:SetHasPromotion(iPCloudy, false)
					taxeis:SetHasPromotion(iPMisty, false)
					taxeis:SetHasPromotion(iPSnow, false)
					taxeis:SetHasPromotion(iPAzureSky, false)
					taxeis:SetHasPromotion(iPSunshower, false)
				end
			end
		end
	end
end

function TenkoCaptureCity(iPlayer, isCapital, cityX, cityY, iNewPlayer)
	local pPlayer = Players[iPlayer]
	local pNewPlayer = Players[iNewPlayer]

	if pPlayer:GetCivilizationType() == TenkoCiv and pPlayer:GetGoldenAgeTurns() > 0 then
		GoldenAgeGlobal(pPlayer)
	end
	if pNewPlayer:GetCivilizationType() == TenkoCiv and pNewPlayer:GetGoldenAgeTurns() > 0 then
		GoldenAgeGlobal(pNewPlayer)
	end
end

function TenkoAdoptPolicy(iPlayer, iPolicy)
	local agonistes = Players[iPlayer]
	if agonistes:GetCivilizationType() == TenkoCiv and agonistes:GetGoldenAgeTurns() > 0 then
		GoldenAgeGlobal(agonistes)
	end
end

--Once again special thanks to Typhlomence
for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local paichnides = Players[iPlayer]
	if paichnides:GetCivilizationType() == TenkoCiv then
		--Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "DETECTED", "MUH PLAYA")
		--GameEvents.PlayerDoTurn.Add(MathalxEienteiWonderBonus)
		--GameEvents.PlayerDoTurn.Add(MathalxEienteiNewEraBonuses)
		GameEvents.PlayerDoTurn.Add(TenkoGoldenAge)
		GameEvents.CityCaptureComplete.Add(TenkoCaptureCity)
		GameEvents.PlayerAdoptPolicy.Add(TenkoAdoptPolicy)
		if iPlayer == Game.GetActivePlayer() then
			Events.SerialEventCityInfoDirty.Add(CallTenko)
		end
	end
end
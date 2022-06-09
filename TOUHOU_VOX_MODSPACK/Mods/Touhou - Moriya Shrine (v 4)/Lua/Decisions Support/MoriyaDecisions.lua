-- OniDecisionsNew
-- Author: user
-- DateCreated: 8/31/2014 1:07:31 PM
--------------------------------------------------------------

print("Moriya Shrine Decisions: loaded")

--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Moriya Shrine: Move the Moriya Shrine to Gensokyo
-------------------------------------------------------------------------------------------------------------------------

local Decisions_MoriyaMoveShrine = {}
	Decisions_MoriyaMoveShrine.Name = "TXT_KEY_DECISIONS_MORIYAMOVESHRINE"
	Decisions_MoriyaMoveShrine.Desc = "TXT_KEY_DECISIONS_MORIYAMOVESHRINE_DESC"
	HookDecisionCivilizationIcon(Decisions_MoriyaMoveShrine, "CIVILIZATION_MORIYA")
	Decisions_MoriyaMoveShrine.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MORIYA) then
			return false, false
		end
		if load(pPlayer, "Decisions_MoriyaMoveShrine") == true then
			Decisions_MoriyaMoveShrine.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MORIYAMOVESHRINE_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(400 * iMod)
		Decisions_MoriyaMoveShrine.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MORIYAMOVESHRINE_DESC", iCost)
			
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local eReligion = pPlayer:GetReligionCreatedByPlayer();
		if not(eReligion) then return true, false end

		local pCity = Game.GetHolyCityForReligion(eReligion, -1);
		if not(pCity) then return true, false end
		if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_MORIYA_SHRINE)) then return false, false end
		
		if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_TAISHA)) and (pPlayer:GetFaith() >= iCost) then
			return true, true
		else 
			return true, false
		end
	end
	)
	
	Decisions_MoriyaMoveShrine.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(400 * iMod)
		local eReligion = pPlayer:GetReligionCreatedByPlayer();
		local pCity = Game.GetHolyCityForReligion(eReligion, -1);
		pPlayer:ChangeFaith(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_MORIYA_SHRINE, 1)
		save(pPlayer, "Decisions_MoriyaMoveShrine", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MORIYA, "Decisions_MoriyaMoveShrine", Decisions_MoriyaMoveShrine)

--------------------------------------------------------------------------------------------------------------------------
-- Moriya Shrine: Trade With The Kappa
--------------------------------------------------------------------------------------------------------------------------

local Decisions_MoriyaKappaTrade = {}
	Decisions_MoriyaKappaTrade.Name = "TXT_KEY_DECISIONS_MORIYAKAPPATRADE"
	Decisions_MoriyaKappaTrade.Desc = "TXT_KEY_DECISIONS_MORIYAKAPPATRADE_DESC"
	HookDecisionCivilizationIcon(Decisions_MoriyaKappaTrade, "CIVILIZATION_MORIYA")
	Decisions_MoriyaKappaTrade.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MORIYA) then
			return false, false
		end

		if load(pPlayer, "Decisions_MoriyaKappaTrade") == true then
			Decisions_MoriyaKappaTrade.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MORIYAKAPPATRADE_ENACTED_DESC")
			return false, false, true
		end

		local iNumCivs = 0
		for iCiv = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
			local pCiv = Players[iCiv]
			if (pCiv:IsAlive()) then
				iNumCivs = iNumCivs + 1
			end
		end
		local iCost = math.ceil((400 + (iNumCivs * 50)) * iMod)
		Decisions_MoriyaKappaTrade.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MORIYAKAPPATRADE_DESC", iCost)

		local bMoriyaShrine = false
		local bCities = false
		for pCity in pPlayer:Cities() do
			bCities = true
			if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_MORIYA_SHRINE)) then
				bMoriyaShrine = true
			end
		end
		
		if not(bCities) then return false, false end

		if not(bMoriyaShrine) then return true, false end

		if (pPlayer:GetFaith() < iCost) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		return true, true
	end
	)
	
	Decisions_MoriyaKappaTrade.DoFunc = (
	function(pPlayer)
		local iNumCivs = 0
		for iCiv = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
			local pCiv = Players[iCiv]
			if (pCiv:IsAlive()) then
				iNumCivs = iNumCivs + 1
			end
		end
		local iCost = math.ceil((400 + (iNumCivs * 50)) * iMod)
		pPlayer:ChangeFaith(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		save(pPlayer, "Decisions_MoriyaKappaTrade", true)
	end
	)

	Decisions_MoriyaKappaTrade.Monitors = {}
	Decisions_MoriyaKappaTrade.Monitors[GameEvents.PlayerDoTurn] =  (	
	function(iPlayer)
		pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_MoriyaKappaTrade") == true then
			local pCity = pPlayer:GetCapitalCity()
			local pTeam = Teams[pPlayer:GetTeam()]
			local iCity = pCity:GetID()
			local sKey = (iCity .. "Decisions_MoriyaKappaTrade")

			local iNumResearchAgreements = 0
			for iCiv = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
				local pCiv = Players[iCiv]
				if (pCiv:IsAlive() and pTeam:IsHasResearchAgreement(pCiv:GetTeam())) then
					iNumResearchAgreements = iNumResearchAgreements + 1
				end
			end
			print("Research agreements with Moriya Shrine: " .. iNumResearchAgreements)

			local iDelta = (iNumResearchAgreements * 4)
			local iOldDelta = load( pPlayer, sKey)
			save (pPlayer, sKey, iDelta)
			
			if iOldDelta == nil then
				pCity:ChangeBaseYieldRateFromBuildings(GameInfo.Yields.YIELD_GOLD.ID, iDelta)
			else
				pCity:ChangeBaseYieldRateFromBuildings(GameInfo.Yields.YIELD_GOLD.ID, iDelta - iOldDelta)
			end
		end
	end
	)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MORIYA, "Decisions_MoriyaKappaTrade", Decisions_MoriyaKappaTrade)


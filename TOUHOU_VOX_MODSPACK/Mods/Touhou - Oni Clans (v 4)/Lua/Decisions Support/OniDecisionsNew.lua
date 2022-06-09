-- OniDecisionsNew
-- Author: user
-- DateCreated: 8/31/2014 1:07:31 PM
--------------------------------------------------------------

print("Oni Clans Decisions: loaded")

--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Oni Clans: Create a Sake Bug
-------------------------------------------------------------------------------------------------------------------------

local Decisions_SakeBug = {}
	Decisions_SakeBug.Name = "TXT_KEY_DECISIONS_SAKEBUG"
	Decisions_SakeBug.Desc = "TXT_KEY_DECISIONS_SAKEBUG_DESC"
	HookDecisionCivilizationIcon(Decisions_SakeBug, "CIVILIZATION_TOUHOU_ONI")
	Decisions_SakeBug.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TOUHOU_ONI) then
			return false, false
		end
		if load(pPlayer, "Decisions_SakeBug") == true then
			Decisions_SakeBug.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SAKEBUG_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(450 * iMod)
		Decisions_SakeBug.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SAKEBUG_DESC", iCost)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local iBreweries = 0
		local bCities = false
		for pCity in pPlayer:Cities() do
			bCities = true
			if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_ONI_BREWERY)) then
				iBreweries = iBreweries + 1
			end
		end
		
		if (iBreweries >= 4) and bCities and (pPlayer:GetGold() >= iCost) then
			return true, true
		else 
			return true, false
		end
	end
	)
	
	Decisions_SakeBug.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(450) * iMod
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_ONI_SAKE_BUG, 1)
		save(pPlayer, "Decisions_SakeBug", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TOUHOU_ONI, "Decisions_SakeBug", Decisions_SakeBug)

--------------------------------------------------------------------------------------------------------------------------
-- Oni Clans: Drinking Party v2.0
--------------------------------------------------------------------------------------------------------------------------

local Decisions_OniDrinkingParty = {}
	Decisions_OniDrinkingParty.Name = "TXT_KEY_DECISIONS_ONIDRINKINGPARTY"
	Decisions_OniDrinkingParty.Desc = "TXT_KEY_DECISIONS_ONIDRINKINGPARTY_DESC"
	HookDecisionCivilizationIcon(Decisions_OniDrinkingParty, "CIVILIZATION_TOUHOU_ONI")
	Decisions_OniDrinkingParty.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TOUHOU_ONI) then
			return false, false
		end

		local iEra = load(pPlayer, "Decisions_OniDrinkingParty")
		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_OniDrinkingParty", nil)
			else
				Decisions_OniDrinkingParty.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ONIDRINKINGPARTY_ENACTED_DESC")
				return false, false, true
			end
		end

		local iNumCities = pPlayer:GetNumCities()
		local iCost = math.ceil((iNumCities * 100) * iMod)
		Decisions_OniDrinkingParty.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ONIDRINKINGPARTY_DESC", iCost)
		local bPopMinimum = true
		local iPlayer = pPlayer:GetID()
		for pCity in pPlayer:Cities() do
			if (pCity:GetPopulation() < 3) then bPopMinimum = false end
		end
		if not(bPopMinimum) then return true, false end 
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetGold() < iCost) then return true, false end

		return true, true
	end
	)
	
	Decisions_OniDrinkingParty.DoFunc = (
	function(pPlayer)
		local iNumCities = pPlayer:GetNumCities()
		local iCost = math.ceil((iNumCities * 100) * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		Decisions_OniDrinkingParty.tUnits = {}
		for row in GameInfo.Units("CombatClass = 'UNITCOMBAT_MELEE'") do
			Decisions_OniDrinkingParty.tUnits[row.Type] = row.Combat
		end

		for pCity in pPlayer:Cities() do
			pCity:ChangePopulation(-1, true)
			local iUnit = nil
			for sUnitType, iCombat in pairs(tDecisions.Decisions_OniDrinkingParty.tUnits) do
				if pPlayer:CanTrain(GameInfoTypes[sUnitType]) then
					if iUnit == nil then
						iUnit = GameInfoTypes[sUnitType]
					elseif iCombat > GameInfo.Units[iUnit].Combat then
						iUnit = GameInfoTypes[sUnitType]
					end
				end
			end
			if iUnit ~= nil then 
				local pUnit = pPlayer:InitUnit(iUnit, pCity:GetX(), pCity:GetY())
				pUnit:SetExperience(pCity:GetDomainFreeExperience(pUnit:GetDomainType()))
				for promotion in GameInfo.UnitPromotions() do
					iPromotion = promotion.ID
					if (pCity:GetFreePromotionCount(iPromotion) > 0 and pUnit:IsPromotionValid(iPromotion)) then
						pUnit:SetHasPromotion(iPromotion, true)
					end
				end
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_DRUNKEN_MASTER, true)
			end
			local iNumDrinkingParty = pCity:GetNumBuilding(GameInfoTypes.BUILDING_ONI_DRINKING_PARTY)
			--print(iNumDrinkingParty .. " buildings found.")
			iNumDrinkingParty = iNumDrinkingParty + 1
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_ONI_DRINKING_PARTY, iNumDrinkingParty)
		end
		save(pPlayer, "Decisions_OniDrinkingParty", pPlayer:GetCurrentEra())
	end
	)

	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TOUHOU_ONI, "Decisions_OniDrinkingParty", Decisions_OniDrinkingParty)


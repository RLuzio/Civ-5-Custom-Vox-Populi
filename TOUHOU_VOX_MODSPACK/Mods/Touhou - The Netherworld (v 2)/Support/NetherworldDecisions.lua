local Decisions_NetherworldTraining = {}
	Decisions_NetherworldTraining.Name = "TXT_KEY_DECISIONS_NETHERWORLD_TRAINING"
	Decisions_NetherworldTraining.Desc = "TXT_KEY_DECISIONS_NETHERWORLD_TRAINING_DESC"
	Decisions_NetherworldTraining.Data1 = {}
	for row in GameInfo.Units("CombatClass = 'UNITCOMBAT_MELEE' OR CombatClass = 'UNITCOMBAT_GUN'") do
		Decisions_NetherworldTraining.Data1[row.Type] = row.Combat
	end
	HookDecisionCivilizationIcon(Decisions_NetherworldTraining, "CIVILIZATION_NETHERWORLD")
	Decisions_NetherworldTraining.CanFunc = (
	function(pPlayer, tUnitTypes)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_NETHERWORLD) then return false, false end

		local iEra = load(pPlayer, "Decisions_NetherworldTraining")
		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_NetherworldTraining", nil)
			else
				Decisions_NetherworldTraining.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NETHERWORLD_TRAINING_ENACTED_DESC")
				return false, false, true
			end
		end
		
		local iCost = math.ceil(300 * iMod)
		Decisions_NetherworldTraining.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NETHERWORLD_TRAINING_DESC", iCost)
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		
		local pTargetCity = nil
		for pCity in pPlayer:Cities() do 
			if pCity:IsCapital() then  pTargetCity = pCity break end
		end
		if pTargetCity == nil then  return true, false end  
		
		Decisions_NetherworldTraining.Data2 = nil
		for sUnitType, iCombat in pairs(tUnitTypes) do
			if pPlayer:CanTrain(GameInfoTypes[sUnitType]) then
				if Decisions_NetherworldTraining.Data2 == nil then
					Decisions_NetherworldTraining.Data2 = GameInfoTypes[sUnitType]
				elseif iCombat > GameInfo.Units[Decisions_NetherworldTraining.Data2].Combat then
					Decisions_NetherworldTraining.Data2 = GameInfoTypes[sUnitType]
				end
			end
		end
		if Decisions_NetherworldTraining.Data2 == nil then return true, false end
		return true, true
	end
	)
	
	Decisions_NetherworldTraining.DoFunc = (
	function(pPlayer, tUnitTypes, iUnitType)
		local iCost = math.ceil(300 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		
		local pTargetCity = nil
		for pCity in pPlayer:Cities() do 
			if pCity:IsCapital() then  pTargetCity = pCity break end
		end

		InitUnitFromCity(pTargetCity, iUnitType, 3)
		save(pPlayer, "Decisions_NetherworldTraining", pPlayer:GetCurrentEra())
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_NETHERWORLD, "Decisions_NetherworldTraining", Decisions_NetherworldTraining)

local Decisions_NetherworldBloom = {}
	Decisions_NetherworldBloom.Name = "TXT_KEY_DECISIONS_NETHERWORLD_BLOOM"
	Decisions_NetherworldBloom.Desc = "TXT_KEY_DECISIONS_NETHERWORLD_BLOOM_DESC"
	HookDecisionCivilizationIcon(Decisions_NetherworldBloom, "CIVILIZATION_NETHERWORLD")
	Decisions_NetherworldBloom.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_NETHERWORLD) then return false, false end

		local iEra = load(pPlayer, "Decisions_NetherworldBloom")
		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_NetherworldBloom", nil)
			else
				Decisions_NetherworldBloom.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NETHERWORLD_BLOOM_ENACTED_DESC")
				return false, false, true
			end
		end
		
		local iCost = math.ceil(800 * iMod)
		Decisions_NetherworldBloom.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NETHERWORLD_BLOOM_DESC", iCost)
		if (pPlayer:GetGold() < iCost) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		return true, true
	end
	)
	
	Decisions_NetherworldBloom.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(800 * iMod)
		local iTurns = math.ceil(14 * iGAMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:ChangeGoldenAgeTurns(iTurns)

		save(pPlayer, "Decisions_NetherworldBloom", pPlayer:GetCurrentEra())
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_NETHERWORLD, "Decisions_NetherworldBloom", Decisions_NetherworldBloom)
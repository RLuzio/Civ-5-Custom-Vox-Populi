local Decisions_ThHellConscriptSinners = {}
	Decisions_ThHellConscriptSinners.Name = "TXT_KEY_DECISIONS_TH_HELL_CONSCRIPT_SINNERS"
	Decisions_ThHellConscriptSinners.Desc = "TXT_KEY_DECISIONS_TH_HELL_CONSCRIPT_SINNERS_DESC"
	Decisions_ThHellConscriptSinners.Data1 = {}
	for row in GameInfo.Units("CombatClass = 'UNITCOMBAT_ARCHER'") do
		Decisions_ThHellConscriptSinners.Data1[row.Type] = row.Combat
	end
	HookDecisionCivilizationIcon(Decisions_ThHellConscriptSinners, "CIVILIZATION_TH_HELL")
	Decisions_ThHellConscriptSinners.CanFunc = (
	function(pPlayer, tUnitTypes)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_HELL) then return false, false end
		if pPlayer:GetCurrentEra() > GameInfoTypes.ERA_MEDIEVAL then return true, false end
		local iCost = math.ceil(300 * iMod)
		Decisions_ThHellConscriptSinners.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TH_HELL_CONSCRIPT_SINNERS_DESC", iCost)
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		local pTargetCity = nil
		for pCity in pPlayer:Cities() do 
			if pCity:IsCapital() then  pTargetCity = pCity break end
		end
		if pTargetCity == nil then  return true, false end
		if load(pPlayer, "Decisions_ThHellConscriptSinners") == nil then
			save(pPlayer, "Decisions_ThHellConscriptSinners", 0)
		end
		if load(pPlayer, "Decisions_ThHellConscriptSinners") >= 2 then return true, false end
		Decisions_ThHellConscriptSinners.Data2 = nil
		for sUnitType, iCombat in pairs(tUnitTypes) do
			if pPlayer:CanTrain(GameInfoTypes[sUnitType]) then
				if Decisions_ThHellConscriptSinners.Data2 == nil then
					Decisions_ThHellConscriptSinners.Data2 = GameInfoTypes[sUnitType]
				elseif iCombat > GameInfo.Units[Decisions_ThHellConscriptSinners.Data2].Combat then
					Decisions_ThHellConscriptSinners.Data2 = GameInfoTypes[sUnitType]
				end
			end
		end
		if Decisions_ThHellConscriptSinners.Data2 == nil then return true, false end
		return true, true
	end
	)
	
	Decisions_ThHellConscriptSinners.DoFunc = (
	function(pPlayer, tUnitTypes, iUnitType)
		local iCost = math.ceil(300 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		
		local pTargetCity = nil
		for pCity in pPlayer:Cities() do 
			if pCity:IsCapital() then  pTargetCity = pCity break end
		end

		InitUnitFromCity(pTargetCity, GameInfo.Units.UNIT_GREAT_GENERAL.ID, 1)
		for city in pPlayer:Cities() do
			if city ~= pTargetCity then
				InitUnitFromCity(city, iUnitType, 1)
			end
		end
		local iTimes = load(pPlayer, "Decisions_ThHellConscriptSinners") + 1
		save(pPlayer, "Decisions_ThHellConscriptSinners", iTimes)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TH_HELL, "Decisions_ThHellConscriptSinners", Decisions_ThHellConscriptSinners)

local Decisions_ThHellConscriptKishin = {}
	Decisions_ThHellConscriptKishin.Name = "TXT_KEY_DECISIONS_TH_HELL_CONSCRIPT_KISHIN"
	Decisions_ThHellConscriptKishin.Desc = "TXT_KEY_DECISIONS_TH_HELL_CONSCRIPT_KISHIN_DESC"
	Decisions_ThHellConscriptKishin.Data1 = {}
	for row in GameInfo.Units("CombatClass = 'UNITCOMBAT_ARCHER'") do
		Decisions_ThHellConscriptKishin.Data1[row.Type] = row.Combat
	end
	HookDecisionCivilizationIcon(Decisions_ThHellConscriptKishin, "CIVILIZATION_TH_HELL")
	Decisions_ThHellConscriptKishin.CanFunc = (
	function(pPlayer, tUnitTypes)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_HELL) then return false, false end
		local otherLoaded = false
		for row in GameInfo.Units("Type = 'UNIT_ONI_GENERAL'") do
			otherLoaded = true
		end
		if otherLoaded == false then return false, false end
		if pPlayer:GetCurrentEra() > GameInfoTypes.ERA_MEDIEVAL then return true, false end
		
		local iCost = math.ceil(300 * iMod)
		Decisions_ThHellConscriptKishin.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TH_HELL_CONSCRIPT_KISHIN_DESC", iCost)
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		
		local pTargetCity = nil
		for pCity in pPlayer:Cities() do 
			if pCity:IsCapital() then  pTargetCity = pCity break end
		end
		if pTargetCity == nil then  return true, false end

		if load(pPlayer, "Decisions_ThHellConscriptSinners") == nil then
			save(pPlayer, "Decisions_ThHellConscriptSinners", 0)
		end
		if load(pPlayer, "Decisions_ThHellConscriptSinners") >= 2 then return true, false end
		
		Decisions_ThHellConscriptKishin.Data2 = nil
		for sUnitType, iCombat in pairs(tUnitTypes) do
			if pPlayer:CanTrain(GameInfoTypes[sUnitType]) then
				if Decisions_ThHellConscriptKishin.Data2 == nil then
					Decisions_ThHellConscriptKishin.Data2 = GameInfoTypes[sUnitType]
				elseif iCombat > GameInfo.Units[Decisions_ThHellConscriptKishin.Data2].Combat then
					Decisions_ThHellConscriptKishin.Data2 = GameInfoTypes[sUnitType]
				end
			end
		end
		if Decisions_ThHellConscriptKishin.Data2 == nil then return true, false end
		return true, true
	end
	)
	
	Decisions_ThHellConscriptKishin.DoFunc = (
	function(pPlayer, tUnitTypes, iUnitType)
		local iCost = math.ceil(300 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		
		local pTargetCity = nil
		for pCity in pPlayer:Cities() do 
			if pCity:IsCapital() then  pTargetCity = pCity break end
		end

		InitUnitFromCity(pTargetCity, GameInfo.Units.UNIT_ONI_GENERAL.ID, 1)
		for city in pPlayer:Cities() do
			if city ~= pTargetCity then
				InitUnitFromCity(city, iUnitType, 1)
			end
		end
		local iTimes = load(pPlayer, "Decisions_ThHellConscriptSinners") + 1
		save(pPlayer, "Decisions_ThHellConscriptSinners", iTimes)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TH_HELL, "Decisions_ThHellConscriptKishin", Decisions_ThHellConscriptKishin)

local Decisions_ThHellConscriptShinigami = {}
	Decisions_ThHellConscriptShinigami.Name = "TXT_KEY_DECISIONS_TH_HELL_CONSCRIPT_SHINIGAMI"
	Decisions_ThHellConscriptShinigami.Desc = "TXT_KEY_DECISIONS_TH_HELL_CONSCRIPT_SHINIGAMI_DESC"
	Decisions_ThHellConscriptShinigami.Data1 = {}
	for row in GameInfo.Units("CombatClass = 'UNITCOMBAT_ARCHER'") do
		Decisions_ThHellConscriptShinigami.Data1[row.Type] = row.Combat
	end
	HookDecisionCivilizationIcon(Decisions_ThHellConscriptShinigami, "CIVILIZATION_TH_HELL")
	Decisions_ThHellConscriptShinigami.CanFunc = (
	function(pPlayer, tUnitTypes)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_HELL) then return false, false end
		local otherLoaded = false
		for row in GameInfo.Units("Type = 'UNIT_SHINIGAMI'") do
			otherLoaded = true
		end
		if otherLoaded == false then return false, false end
		if pPlayer:GetCurrentEra() > GameInfoTypes.ERA_MEDIEVAL then return true, false end
		
		local iCost = math.ceil(300 * iMod)
		Decisions_ThHellConscriptShinigami.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TH_HELL_CONSCRIPT_SHINIGAMI_DESC", iCost)
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		
		local pTargetCity = nil
		for pCity in pPlayer:Cities() do 
			if pCity:IsCapital() then  pTargetCity = pCity break end
		end
		if pTargetCity == nil then  return true, false end

		if load(pPlayer, "Decisions_ThHellConscriptSinners") == nil then
			save(pPlayer, "Decisions_ThHellConscriptSinners", 0)
		end
		if load(pPlayer, "Decisions_ThHellConscriptSinners") >= 2 then return true, false end
		
		Decisions_ThHellConscriptShinigami.Data2 = nil
		for sUnitType, iCombat in pairs(tUnitTypes) do
			if pPlayer:CanTrain(GameInfoTypes[sUnitType]) then
				if Decisions_ThHellConscriptShinigami.Data2 == nil then
					Decisions_ThHellConscriptShinigami.Data2 = GameInfoTypes[sUnitType]
				elseif iCombat > GameInfo.Units[Decisions_ThHellConscriptShinigami.Data2].Combat then
					Decisions_ThHellConscriptShinigami.Data2 = GameInfoTypes[sUnitType]
				end
			end
		end
		if Decisions_ThHellConscriptShinigami.Data2 == nil then return true, false end
		return true, true
	end
	)
	
	Decisions_ThHellConscriptShinigami.DoFunc = (
	function(pPlayer, tUnitTypes, iUnitType)
		local iCost = math.ceil(300 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		
		local pTargetCity = nil
		for pCity in pPlayer:Cities() do 
			if pCity:IsCapital() then  pTargetCity = pCity break end
		end

		InitUnitFromCity(pTargetCity, GameInfo.Units.UNIT_SHINIGAMI.ID, 1)
		for city in pPlayer:Cities() do
			if city ~= pTargetCity then
				InitUnitFromCity(city, iUnitType, 1)
			end
		end
		local iTimes = load(pPlayer, "Decisions_ThHellConscriptSinners") + 1
		save(pPlayer, "Decisions_ThHellConscriptSinners", iTimes)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TH_HELL, "Decisions_ThHellConscriptShinigami", Decisions_ThHellConscriptShinigami)

local Decisions_ThHellStrikeFearIntoCityStates = {}
	Decisions_ThHellStrikeFearIntoCityStates.Name = "TXT_KEY_DECISIONS_TH_HELL_STRIKE_FEAR_INTO_CITY_STATES"
	Decisions_ThHellStrikeFearIntoCityStates.Desc = "TXT_KEY_DECISIONS_TH_HELL_STRIKE_FEAR_INTO_CITY_STATES_DESC"
	Decisions_ThHellStrikeFearIntoCityStates.Data1 = {}
	HookDecisionCivilizationIcon(Decisions_ThHellStrikeFearIntoCityStates, "CIVILIZATION_TH_HELL")
	Decisions_ThHellStrikeFearIntoCityStates.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_HELL) then
			return false, false
		end
		local iEra = load(pPlayer, "Decisions_ThHellStrikeFearIntoCityStates")
		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_ThHellStrikeFearIntoCityStates", nil)
			else
				Decisions_ThHellStrikeFearIntoCityStates.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TH_HELL_STRIKE_FEAR_INTO_CITY_STATES_ENACTED_DESC")
				return false, false, true
			end
		end
		Decisions_ThHellStrikeFearIntoCityStates.Data1 = {}
		for iCS, pCS in pairs(Players) do
			if (pCS:IsAlive() and pCS:IsMinorCiv() and Teams[pPlayer:GetTeam()]:IsHasMet(pCS:GetTeam())) then
				table.insert(Decisions_ThHellStrikeFearIntoCityStates.Data1, iCS)
			end
		end
		local iCost = math.ceil(300 * iMod)
		Decisions_ThHellStrikeFearIntoCityStates.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TH_HELL_STRIKE_FEAR_INTO_CITY_STATES_DESC", iCost)
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:GetJONSCulture() < iCost) then	return true, false end
		if not pPlayer:HasCreatedReligion() then return true, false end
		if #Decisions_ThHellStrikeFearIntoCityStates.Data1 < 3 then return true, false end
		return true, true
	end
	)
	
	Decisions_ThHellStrikeFearIntoCityStates.DoFunc = (
	function(pPlayer, tCSThHell)
		local iCost = math.ceil(300 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		local iPlayer = pPlayer:GetID()
		local eReligion = pPlayer:GetReligionCreatedByPlayer()
		for iKey, iCS in pairs(tCSThHell) do
			if Players[iCS]:HasReligionInMostCities(eReligion) then
				Players[iCS]:ChangeMinorCivFriendshipWithMajor(iPlayer, 10)
				pPlayer:ChangeFaith(9)
			else
				Players[iCS]:ChangeMinorCivFriendshipWithMajor(iPlayer, 5)
				pPlayer:ChangeFaith(3)
			end
		end
		save(pPlayer, "Decisions_ThHellStrikeFearIntoCityStates", pPlayer:GetCurrentEra())
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TH_HELL, "Decisions_ThHellStrikeFearIntoCityStates", Decisions_ThHellStrikeFearIntoCityStates)
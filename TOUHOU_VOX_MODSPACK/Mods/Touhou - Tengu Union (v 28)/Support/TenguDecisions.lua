local Decisions_TenguTerraceFarm = {}
    Decisions_TenguTerraceFarm.Name = "TXT_KEY_DECISIONS_TENGU_TERRACE_FARM"
	Decisions_TenguTerraceFarm.Desc = "TXT_KEY_DECISIONS_TENGU_TERRACE_FARM_DESC"
	HookDecisionCivilizationIcon(Decisions_TenguTerraceFarm, "CIVILIZATION_TOUHOU_TENGU")
	Decisions_TenguTerraceFarm.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TOUHOU_TENGU then return false, false end
		if load(pPlayer, "Decisions_TenguTerraceFarm") == true then
			Decisions_TenguTerraceFarm.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TENGU_TERRACE_FARM_ENACTED_DESC")
			return false, false, true
		end
		
		local iTech = GameInfoTypes.TECH_CONSTRUCTION
		local iCost = math.ceil(pPlayer:GetResearchCost(iTech) * 0.30)
		Decisions_TenguTerraceFarm.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TENGU_TERRACE_FARM_DESC", iCost)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetCurrentResearch() == -1) then return true, false end
		
		if (Teams[pPlayer:GetTeam()]:IsHasTech(iTech)) and (pPlayer:GetResearchProgress(pPlayer:GetCurrentResearch()) >= iCost) then
			return true, true
		else
			return true, false
		end
		
		return true, true		
	end
	)
	
	Decisions_TenguTerraceFarm.DoFunc = (
	function(pPlayer)
		local iTech = GameInfoTypes.TECH_CONSTRUCTION
		local iCost = math.ceil(pPlayer:GetResearchCost(iTech) * 0.30)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), -iCost, pPlayer:GetID())
		
		local pTeam = Teams[pPlayer:GetTeam()]
		pTeam:SetHasTech(GameInfoTypes.TECH_LIVEABLE_MOUNTAINS_DUMMY, true)
		save(pPlayer, "Decisions_TenguTerraceFarm", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TOUHOU_TENGU, "Decisions_TenguTerraceFarm", Decisions_TenguTerraceFarm)

local Decisions_TenguNewsTournament = {}
	Decisions_TenguNewsTournament.Name = "TXT_KEY_DECISIONS_TENGU_NEWS_TOURNAMENT"
	Decisions_TenguNewsTournament.Desc = "TXT_KEY_DECISIONS_TENGU_NEWS_TOURNAMENT_DESC"
	HookDecisionCivilizationIcon(Decisions_TenguNewsTournament, "CIVILIZATION_TOUHOU_TENGU")
	Decisions_TenguNewsTournament.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TOUHOU_TENGU then return false, false end
		if load(pPlayer, "Decisions_TenguNewsTournament") == true then
			Decisions_TenguNewsTournament.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TENGU_NEWS_TOURNAMENT_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(1000 * iMod)
		Decisions_TenguNewsTournament.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TENGU_NEWS_TOURNAMENT_DESC", iCost)
		if (pPlayer:GetGold() < iCost) then return true, false end		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_PRINTING_PRESS)) then return true, false end
		return true, true
	end
	)
	
	Decisions_TenguNewsTournament.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(1000 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_NEWS_TOURNAMENT_DUMMY, true)
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_NEWS_TOURNAMENT_DUMMY, 1)
		save(pPlayer, "Decisions_TenguNewsTournament", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TOUHOU_TENGU, "Decisions_TenguNewsTournament", Decisions_TenguNewsTournament)
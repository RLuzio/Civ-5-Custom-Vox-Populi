-- TsukumogamiDecisions
-- Author: Igniszath
-- DateCreated: 8/26/2017 10:40:11 AM
--------------------------------------------------------------
local Decisions_TsukumogamiInspire = {}
	Decisions_TsukumogamiInspire.Name = "TXT_KEY_DECISIONS_TSUKUMOGAMI_INSPIRE"
	Decisions_TsukumogamiInspire.Desc = "TXT_KEY_DECISIONS_TSUKUMOGAMI_INSPIRE_DESC"
	Decisions_TsukumogamiInspire.Pedia = "TXT_KEY_BUILDING_CONCERT_HALL"
	HookDecisionCivilizationIcon(Decisions_TsukumogamiInspire, "CIVILIZATION_TSUKUMOGAMI")
	Decisions_TsukumogamiInspire.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TSUKUMOGAMI then return false, false end
		if load(pPlayer, "Decisions_TsukumogamiInspire") == true then
			Decisions_TsukumogamiInspire.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TSUKUMOGAMI_INSPIRE_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(1500 * iMod)
		Decisions_TsukumogamiInspire.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TSUKUMOGAMI_INSPIRE_DESC", iCost)
		
		if (pPlayer:GetGold() < iCost) then return true, false end		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_AMPHITHEATER) < 1) then return true, false end
		if (pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_OPERA_HOUSE) < 1) then return true, false end
		if (Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_ARCHITECTURE) ~= true) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_TsukumogamiInspire.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(1500 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_INSPIRATION_DUMMY, true)
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_CONCERT_HALL, 1)
		save(pPlayer, "Decisions_TsukumogamiInspire", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TSUKUMOGAMI, "Decisions_TsukumogamiInspire", Decisions_TsukumogamiInspire)

local Decisions_TsukumogamiSearchArtifacts = {}
	Decisions_TsukumogamiSearchArtifacts.Name = "TXT_KEY_DECISIONS_TSUKUMOGAMI_SEARCH_ARTIFACTS"
	Decisions_TsukumogamiSearchArtifacts.Desc = "TXT_KEY_DECISIONS_TSUKUMOGAMI_SEARCH_ARTIFACTS_DESC"
	HookDecisionCivilizationIcon(Decisions_TsukumogamiSearchArtifacts, "CIVILIZATION_TSUKUMOGAMI")
	Decisions_TsukumogamiSearchArtifacts.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TSUKUMOGAMI then return false, false end
		if load(pPlayer, "Decisions_TsukumogamiSearchArtifacts") == true then
			Decisions_TsukumogamiSearchArtifacts.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TSUKUMOGAMI_SEARCH_ARTIFACTS_ENACTED_DESC")
			return false, false, true
		end
		
		Decisions_TsukumogamiSearchArtifacts.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TSUKUMOGAMI_SEARCH_ARTIFACTS_DESC")

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 3) then return true, false end
		local iReligion = GetPlayerMajorityReligion(pPlayer)
		if iReligion == nil then return true, false end
		if GetReligiousUnity(pPlayer, iReligion) < 0.75 then return true, false end
		if (Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_CIVIL_SERVICE)) then
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_TsukumogamiSearchArtifacts.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -3)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_SEARCH_ARTIFACTS_DUMMY, true)
		save(pPlayer, "Decisions_TsukumogamiSearchArtifacts", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TSUKUMOGAMI, "Decisions_TsukumogamiSearchArtifacts", Decisions_TsukumogamiSearchArtifacts)
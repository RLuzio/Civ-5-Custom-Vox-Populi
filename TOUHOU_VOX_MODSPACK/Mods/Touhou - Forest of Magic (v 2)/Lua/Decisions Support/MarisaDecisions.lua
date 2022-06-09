-- MarisaDecisions
-- Author: user
-- DateCreated: 8/31/2014 1:07:31 PM
--------------------------------------------------------------

print("Forest of Magic Decisions: loaded")

--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Forest of Magic: Write a Grimoire
-------------------------------------------------------------------------------------------------------------------------

local Decisions_MarisaGrimoire = {}
	Decisions_MarisaGrimoire.Name = "TXT_KEY_DECISIONS_MARISAGRIMOIRE"
	Decisions_MarisaGrimoire.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MARISAGRIMOIRE_DESC")
	HookDecisionCivilizationIcon(Decisions_MarisaGrimoire, "CIVILIZATION_TH_FOREST_OF_MAGIC")
	Decisions_MarisaGrimoire.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_FOREST_OF_MAGIC) then
			return false, false
		end
		if load(pPlayer, "Decisions_MarisaGrimoire") == true then
			Decisions_MarisaGrimoire.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MARISAGRIMOIRE_ENACTED_DESC")
			return false, false, true
		end
				
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_EDUCATION)) then return true, false end

		local pCity = pPlayer:GetCapitalCity()
		local pPlot = pCity:Plot()
		local iNumUnits = pPlot:GetNumUnits()
		for iVal = 0,(iNumUnits - 1) do
			local pUnit = pPlot:GetUnit(iVal)
			if (pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_WRITER) then
				Decisions_MarisaGrimoire.Data1 = pUnit
				break
			end
		end			

		if not(Decisions_MarisaGrimoire.Data1) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_MarisaGrimoire.DoFunc = (
	function(pPlayer, pUnit)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pUnit:Kill()
		save(pPlayer, "Decisions_MarisaGrimoire", true)
	end
	)

	Decisions_MarisaGrimoire.Monitors = {}
	Decisions_MarisaGrimoire.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_FOREST_OF_MAGIC) then return end
		if load(pPlayer, "Decisions_MarisaGrimoire") == true then
			for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
				local playerTeam = Teams[pPlayer:GetTeam()]
				local teamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
				local otherPlayer = Players[iPlayerLoop]
				if otherPlayer ~= pPlayer and otherPlayer:IsAlive() then
					local otherTeam = Teams[otherPlayer:GetTeam()]
					if otherPlayer:IsDoF(iPlayer) then
						for row in GameInfo.Technologies() do
							if otherTeam:IsHasTech(row.ID) and pPlayer:GetCurrentResearch() == row.ID then
								local modifier = pPlayer:GetScience()*10 / 100
								teamTechs:ChangeResearchProgress(row.ID, modifier, iPlayer)
							end
						end
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TH_FOREST_OF_MAGIC, "Decisions_MarisaGrimoire", Decisions_MarisaGrimoire)

--------------------------------------------------------------------------------------------------------------------------
-- Forest of Magic: Obtain a Mini-Hakkero
--------------------------------------------------------------------------------------------------------------------------

local Decisions_MiniHakkero = {}
	Decisions_MiniHakkero.Name = "TXT_KEY_DECISIONS_MINIHAKKERO"
	Decisions_MiniHakkero.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MINIHAKKERO_DESC")
	HookDecisionCivilizationIcon(Decisions_MiniHakkero, "CIVILIZATION_TH_FOREST_OF_MAGIC")
	Decisions_MiniHakkero.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_FOREST_OF_MAGIC) then
			return false, false
		end

		if load(pPlayer, "Decisions_MiniHakkero") == true then
			Decisions_MiniHakkero.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MINIHAKKERO_ENACTED_DESC")
			return false, false, true
		end

		local iNumAtelier = pPlayer:CountNumBuildings(GameInfoTypes["BUILDING_FOM_ATELIER"])
		if iNumAtelier > 4 then iNumAtelier = 4 end
		local iAtelierDiscount = iNumAtelier * 100
		local iCost = math.ceil((1000 - iAtelierDiscount) * iMod)
		Decisions_MiniHakkero.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MINIHAKKERO_DESC", iCost)

		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_PHYSICS)) then return true, false end

		local pCity = pPlayer:GetCapitalCity()
		if not (pCity:IsHasBuilding(GameInfoTypes.BUILDING_FOM_ATELIER)) then
			return true, false
		end			

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetGold() < iCost) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_MiniHakkero.DoFunc = (
	function(pPlayer)
		local iNumAtelier = pPlayer:CountNumBuildings(GameInfoTypes["BUILDING_FOM_ATELIER"])
		if iNumAtelier > 4 then iNumAtelier = 4 end
		local iAtelierDiscount = iNumAtelier * 100
		local iCost = math.ceil((1000 - iAtelierDiscount) * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_MINIHAKKERO, true)
		InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_FOM_WITCH, 1)

		save(pPlayer, "Decisions_MiniHakkero", true)
	end
	)

	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TH_FOREST_OF_MAGIC, "Decisions_MiniHakkero", Decisions_MiniHakkero)


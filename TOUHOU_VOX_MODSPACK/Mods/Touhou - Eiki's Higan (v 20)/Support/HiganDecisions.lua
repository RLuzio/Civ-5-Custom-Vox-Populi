--------------------------------------------------------------------------------------------------------------------------
-- Higan: Lecture City-States
--------------------------------------------------------------------------------------------------------------------------

local Decisions_HiganLecture = {}
	Decisions_HiganLecture.Name = "TXT_KEY_DECISIONS_HIGAN_LECTURE"
	Decisions_HiganLecture.Desc = "TXT_KEY_DECISIONS_HIGAN_LECTURE_DESC"
	Decisions_HiganLecture.Data1 = {}
	HookDecisionCivilizationIcon(Decisions_HiganLecture, "CIVILIZATION_HIGAN")
	Decisions_HiganLecture.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_HIGAN) then
			return false, false
		end

		local iEra = load(pPlayer, "Decisions_HiganLecture")
		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_HiganLecture", nil)
			else
				Decisions_HiganLecture.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HIGAN_LECTURE_ENACTED_DESC")
				return false, false, true
			end
		end
		
		Decisions_HiganLecture.Data1 = {}
		for iCS, pCS in pairs(Players) do
			if (pCS:IsAlive() and pCS:IsMinorCiv() and Teams[pPlayer:GetTeam()]:IsHasMet(pCS:GetTeam())) then
				table.insert(Decisions_HiganLecture.Data1, iCS)
			end
		end

		local iCost = math.ceil(#Decisions_HiganLecture.Data1 * 50 * iMod)
		Decisions_HiganLecture.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HIGAN_LECTURE_DESC", iCost)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:GetJONSCulture() < iCost) then	return true, false end
		
		if #Decisions_HiganLecture.Data1 < 4 then return true, false end

		if (Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_PHILOSOPHY) ~= true) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_HiganLecture.DoFunc = (
	function(pPlayer, tCSHigan)
		local iCost = math.ceil(#Decisions_HiganLecture.Data1 * 50 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		
		local iPlayer = pPlayer:GetID()
		for iKey, iCS in pairs(tCSHigan) do
			Players[iCS]:ChangeMinorCivFriendshipWithMajor(iPlayer, 30)
		end
		

		save(pPlayer, "Decisions_HiganLecture", pPlayer:GetCurrentEra())
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_HIGAN, "Decisions_HiganLecture", Decisions_HiganLecture)

--------------------------------------------------------------------------------------------------------------------------
-- Higan: Build Muenzuka in a City-State (City-State Based)
--------------------------------------------------------------------------------------------------------------------------

local Decisions_HiganMuenzuka = {}
	Decisions_HiganMuenzuka.Name = "TXT_KEY_DECISIONS_HIGAN_MUENZUKA"
	Decisions_HiganMuenzuka.Desc = "TXT_KEY_DECISIONS_HIGAN_MUENZUKA_DESC"
	Decisions_HiganMuenzuka.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_HIGAN then return end
		if load(pPlayer, "Decisions_HiganMuenzuka") ~= nil then
			Decisions_HiganMuenzuka.Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HIGAN_MUENZUKA", load(pPlayer, "Decisions_HiganMuenzuka"))
			Decisions_HiganMuenzuka.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HIGAN_MUENZUKA_ENACTED_DESC", load(pPlayer, "Decisions_HiganMuenzuka"))
			return false, false, true
		end
		--Generate Decisions
		for iCS, pCS in pairs(Players) do
			if (pCS:IsAlive() and pCS:IsMinorCiv() and Teams[pPlayer:GetTeam()]:IsHasMet(pCS:GetTeam())) then
				local sKey = pCS:GetID()
				local sName = pCS:GetName()
				
				tTempDecisions[sKey] = {}
				tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HIGAN_MUENZUKA", sName)
				tTempDecisions[sKey].Desc = "TXT_KEY_DECISIONS_HIGAN_MUENZUKA_DESC"
				tTempDecisions[sKey].Data1 = pCS
				tTempDecisions[sKey].Type = "Civilization"
				HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_HIGAN")

				tTempDecisions[sKey].CanFunc = (
				function(pPlayer, pCS)
				
					local sKey = pCS:GetID()
					local sName = pCS:GetName()
					
					local iCost = math.ceil((500 + (100 * pPlayer:GetCurrentEra())) * iMod)
					tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HIGAN_MUENZUKA_DESC", sName, iCost)

					if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
					if (pPlayer:GetGold() < iCost) then	return true, false end
					if not(pCS:IsAllies(pPlayer:GetID())) then return true, false end
					return true, true
				end
				)
				
				tTempDecisions[sKey].DoFunc = (
				function(pPlayer, pCS)
					local sKey = pCS:GetID()
					local iCost = math.ceil((500 + (100 * pPlayer:GetCurrentEra())) * iMod)
					local pCity = pCS:GetCapitalCity()
					local x = pCity:GetX()
					local y = pCity:GetY()
					local pPlot = Map.GetPlot(x, y)
					
					pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
					pPlayer:ChangeGold(-iCost)
					pPlayer:InitUnit(GameInfoTypes["UNIT_VENETIAN_MERCHANT"], x, y):PushMission(GameInfoTypes["MISSION_BUY_CITY_STATE"])
					pCity = pPlot:GetPlotCity()
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_MUENZUKA, 1)
					InitUnitFromCity(pCity, GameInfoTypes.UNIT_SHINIGAMI, 1)

					save(pPlayer, "Decisions_HiganMuenzuka", sName)
				end
				)
				
			end
		end
		
		--End Generation
		return
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_HIGAN, "Decisions_HiganMuenzuka", Decisions_HiganMuenzuka)
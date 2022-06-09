-- Oni Clans Events
-- Author: BouncyMischa
--=======================================================================================================================

print("Oni Events: loaded")

--=======================================================================================================================
-- Oni Clans Events
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
------------------------------------------------------------------------------------------------------------------------
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if not (player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--------------------------------------------------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------------------------------------------------

local iOniCiv = GameInfoTypes["CIVILIZATION_TOUHOU_ONI"]
local iIndustrialEra = GameInfoTypes["ERA_INDUSTRIAL"]
local iClassicalEra = GameInfoTypes["ERA_CLASSICAL"]

-------------------------------------------------------------------------------------------------------------------------
--  Night Parade of 100 Oni
-------------------------------------------------------------------------------------------------------------------------
local Event_THOniNightParade = {}
	Event_THOniNightParade.Name = "TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE"
	Event_THOniNightParade.Desc = "TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_DESC"
	Event_THOniNightParade.Weight = 15
	Event_THOniNightParade.CanFunc = (
		function(pPlayer)
			--print("Checking for Night Parade Event.")
			--print("Current era: " .. pPlayer:GetCurrentEra() .. " and Industrial is " .. GameInfoTypes["ERA_INDUSTRIAL"] .. " and Classical is " .. iClassicalEra)

			-- Check the Era
			if pPlayer:GetCurrentEra() > iIndustrialEra then return false end
			if pPlayer:GetCurrentEra() < iClassicalEra then return false end

			local sPlayerCiv = Locale.ConvertTextKey(GameInfo.Civilizations[pPlayer:GetCivilizationType()].Description)

			--print("Civilization is " .. sPlayerCiv)

			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= iOniCiv then return false end
	
			--print("Oni Clans civ and not post-Industrial")

			bAlreadyNurarihyon = false
			for pUnit in pPlayer:Units() do
				if (pUnit:GetUnitType() == GameInfoTypes.UNIT_ONI_GENERAL) and (pUnit:GetName() == "Nurarihyon") then bAlreadyNurarihyon = true end
			end
			if bAlreadyNurarihyon then return false end

			-- Fire the Event! (if chances are met)
			Event_THOniNightParade.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_DESC")

			return true
		end
		)
	Event_THOniNightParade.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_THOniNightParade.Outcomes[1] = {}
	Event_THOniNightParade.Outcomes[1].Name = "TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_1"
	Event_THOniNightParade.Outcomes[1].Desc = "TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_1_DESC"
	Event_THOniNightParade.Outcomes[1].Weight = 6
	Event_THOniNightParade.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iNumCities = pPlayer:GetNumCities()
			local iCost = math.ceil((iNumCities * 150) * iMod)
			if pPlayer:GetGold() < iCost then return false end

			Event_THOniNightParade.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_RESULT_1", iCost)
			
			return true
		end
		)
	Event_THOniNightParade.Outcomes[1].DoFunc = (
		function(pPlayer)
			local playerID = pPlayer:GetID()			
			local iNumCities = pPlayer:GetNumCities()
			local iCost = math.ceil((iNumCities * 150) * iMod)
			pPlayer:ChangeGold(-iCost)

			for pCity in pPlayer:Cities() do
				local iUnit = GetStrongestMilitaryUnit(pPlayer, false, "UNITCOMBAT_MELEE")
				InitUnitFromCity(pCity, iUnit, 1) 
			end
			local tNurarihyon = InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_ONI_GENERAL, 1)
			tNurarihyon[1]:SetName("Nurarihyon")

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_THOniNightParade.Name))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_TH_ONI_NIGHT_PARADE")) 
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_THOniNightParade.Outcomes[2] = {}
	Event_THOniNightParade.Outcomes[2].Name = "TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_2"
	Event_THOniNightParade.Outcomes[2].Desc = "TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_2_DESC"
	Event_THOniNightParade.Outcomes[2].Weight = 3
	Event_THOniNightParade.Outcomes[2].CanFunc = (
		function(pPlayer)
			Event_THOniNightParade.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_RESULT_2")

			return true
		end
		)
	Event_THOniNightParade.Outcomes[2].DoFunc = (
		function(pPlayer)
			local playerID = pPlayer:GetID()		
			for pCity in pPlayer:Cities() do
				if ((pCity:GetPopulation() > 3) and (GetRandom(1,2) == 2)) then
					local pPlot = pCity:Plot()
					local iUnit = GetStrongestMilitaryUnit(pPlayer, false, "UNITCOMBAT_MELEE")
					pUnit = pPlayer:InitUnit(iUnit, pPlot:GetX(), pPlot:GetY())
					pCity:ChangePopulation(-1, true)
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_THOniNightParade.Name))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_TH_ONI_NIGHT_PARADE")) 
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_THOniNightParade.Outcomes[3] = {}
	Event_THOniNightParade.Outcomes[3].Name = "TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_3"
	Event_THOniNightParade.Outcomes[3].Desc = "TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_3_DESC"
	Event_THOniNightParade.Outcomes[3].Weight = 3
	Event_THOniNightParade.Outcomes[3].CanFunc = (
		function(pPlayer)
			Event_THOniNightParade.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_RESULT_3")

			return true
		end
		)
	Event_THOniNightParade.Outcomes[3].DoFunc = (
		function(pPlayer)
			pPlayer:ChangeGoldenAgeTurns(8)
			pPlayer:GetCapitalCity():ChangeWeLoveTheKingDayCounter(8)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_NIGHT_PARADE_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey(Event_THOniNightParade.Name))
		end
		)
tEvents.Event_THOniNightParade = Event_THOniNightParade
-------------------------------------------------------------------------------------------------------------------------
--  More Alcohol
-------------------------------------------------------------------------------------------------------------------------
local Event_THOniMoreAlcohol = {}
	Event_THOniMoreAlcohol.Name = "TXT_KEY_EVENT_TH_ONI_MORE_ALCOHOL"
	Event_THOniMoreAlcohol.Desc = "TXT_KEY_EVENT_TH_ONI_MORE_ALCOHOL_DESC"
	Event_THOniMoreAlcohol.Weight = 20
	Event_THOniMoreAlcohol.CanFunc = (
		function(pPlayer)
			--print("Checking for More Alcohol event")
			local tPlots ={}
			local iPlayer = pPlayer:GetID()
			local iMarsh = GameInfoTypes.FEATURE_MARSH
			local iJungle = GameInfoTypes.FEATURE_JUNGLE
			local iFloodPlains =GameInfoTypes.FEATURE_FLOOD_PLAINS
			local iPlains = GameInfoTypes.TERRAIN_PLAINS
			local iGrasslands = GameInfoTypes.TERRAIN_GRASS

			if pPlayer:GetCivilizationType() ~= iOniCiv then return false end	
			
			--print("Checking for plots for More Alcohol event")
			for pCity in pPlayer:Cities() do
				if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_ONI_BREWERY)) then
					local pCentralPlot = pCity:Plot()
					for pPlot in PlotAreaSpiralIterator(pCentralPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						local iImprovement = pPlot:GetImprovementType()
						local iResource = pPlot:GetResourceType()
						local iTerrain = pPlot:GetTerrainType()
						local iFeature = pPlot:GetFeatureType()
						local iOwner = pPlot:GetOwner()
						local tPlot = {}
						
						if (iOwner == iPlayer) and (iImprovement == -1) and (iResource == -1) then
							local bWineValid = false
							local bCitrusValid = false
							local bSugarValid = false	

							if (iFeature == iJungle) then bCitrusValid = true end
							if (iFeature == iMarsh) or (iFeature == iFloodPlains) then bSugarValid = true end
							if (((iTerrain == iPlains) or (iTerrain == iGrasslands)) and (iFeature == -1) and (pPlot:IsFlatlands())) then bWineValid = true end
							if bWineValid or bCitrusValid or bSugarValid then
								local tPlot = {}
								tPlot.City = pCity
								tPlot.Plot = pPlot
								table.insert(tPlots, tPlot)
							end
						end
					end
				end
			end
			
			if #tPlots < 1 then return false end
			--print("At least one valid plot found")
			
			local tPlot = tPlots[GetRandom(1, #tPlots)]
			
			Event_THOniMoreAlcohol.Data1 = tPlot.City
			Event_THOniMoreAlcohol.Data2 = tPlot.Plot
			
			-- Fire the Event! (if chances are met)
			Event_THOniMoreAlcohol.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_MORE_ALCOHOL_DESC", Event_THOniMoreAlcohol.Data1:GetName())

			return true
		end
		)
	Event_THOniMoreAlcohol.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_THOniMoreAlcohol.Outcomes[1] = {}
	Event_THOniMoreAlcohol.Outcomes[1].Name = "TXT_KEY_EVENT_TH_ONI_MORE_ALCOHOL_OUTCOME_1"
	Event_THOniMoreAlcohol.Outcomes[1].Desc = "TXT_KEY_EVENT_TH_ONI_MORE_ALCOHOL_OUTCOME_1_DESC"
	Event_THOniMoreAlcohol.Outcomes[1].Weight = 5
	Event_THOniMoreAlcohol.Outcomes[1].CanFunc = (
		function(pPlayer)
			Event_THOniMoreAlcohol.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_MORE_ALCOHOL_OUTCOME_RESULT_1")
			
			return true
		end
		)
	Event_THOniMoreAlcohol.Outcomes[1].DoFunc = (
		function(pPlayer, pCity, pPlot)
			local iMarsh = GameInfoTypes.FEATURE_MARSH
			local iJungle = GameInfoTypes.FEATURE_JUNGLE
			local iFloodPlains =GameInfoTypes.FEATURE_FLOOD_PLAINS
			local iWine = GameInfoTypes.RESOURCE_WINE
			local iCitrus = GameInfoTypes.RESOURCE_CITRUS
			local iSugar = GameInfoTypes.RESOURCE_SUGAR
			local iResource = -1
			local iFeature = pPlot:GetFeatureType()
			
			if (iFeature == iJungle) then 
				iResource = iCitrus 
			else 
				if (iFeature == iMarsh) or (iFeature == iFloodPlains) then 
					iResource = iSugar
				else 
					iResource = iWine
				end
			end

			local tResource = GameInfo.Resources[iResource]
			local sName = tResource.Description
			local sIcon = tResource.IconString
			
			pPlot:SetResourceType(iResource, 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_MORE_ALCOHOL_OUTCOME_RESULT_1_NOTIFICATION", sIcon, sName, Event_THOniMoreAlcohol.Data1:GetName()), Locale.ConvertTextKey(Event_THOniMoreAlcohol.Name))
		end
		)
tEvents.Event_THOniMoreAlcohol = Event_THOniMoreAlcohol
-------------------------------------------------------------------------------------------------------------------------
--  Kishin Chief
-------------------------------------------------------------------------------------------------------------------------
local Event_THOniKishinChief = {}
	Event_THOniKishinChief.Name = "TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF"
	Event_THOniKishinChief.Desc = "TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_DESC"
	Event_THOniKishinChief.Data1 = {}
	Event_THOniKishinChief.Data2 = nil
	Event_THOniKishinChief.Weight = 10
	Event_THOniKishinChief.CanFunc = (
		function(pPlayer)
			--print("Checking for Kishin Chief Event.")

			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= iOniCiv then return false end
			--print("Oni civ is active")	

			local pTeam = Teams[pPlayer:GetTeam()]
			Event_THOniKishinChief.Data1 = {}
			for iCiv = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
				local pCiv = Players[iCiv]
				local sKey = "Event_THOniKishinChief" .. iCiv
				if (pCiv:IsAlive() and pTeam:IsHasMet(pCiv:GetTeam()) and (pCiv:GetCivilizationType() ~= iOniCiv) and (load(pPlayer, sKey) ~= true)) then
					table.insert(Event_THOniKishinChief.Data1, iCiv)
					--print("Adding " .. pCiv:GetCivilizationShortDescription())
					local pLeader = GameInfo.Leaders[pCiv:GetLeaderType()];
					--print("Leader is " .. Locale.ConvertTextKey(GameInfo.Leaders[pCiv:GetLeaderType()].Description))
				end
			end
			--print(#Event_THOniKishinChief.Data1 .. " potential immortals found.")
			if #Event_THOniKishinChief.Data1 < 1 then return false end

			-- Fire the Event! (if chances are met)
			Event_THOniKishinChief.Data2 = Event_THOniKishinChief.Data1[GetRandom(1, #Event_THOniKishinChief.Data1)]
			immortalCiv = Players[Event_THOniKishinChief.Data2]
			sImmortalName = Locale.ConvertTextKey(GameInfo.Leaders[immortalCiv:GetLeaderType()].Description)
			--print("Targeting " .. sImmortalName)
			Event_THOniKishinChief.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_DESC", sImmortalName, immortalCiv:GetCivilizationShortDescription())
			return true
		end
		)
	Event_THOniKishinChief.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_THOniKishinChief.Outcomes[1] = {}
	Event_THOniKishinChief.Outcomes[1].Name = "TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_OUTCOME_1"
	Event_THOniKishinChief.Outcomes[1].Desc = "TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_OUTCOME_1_DESC"
	Event_THOniKishinChief.Outcomes[1].Weight = 3
	Event_THOniKishinChief.Outcomes[1].CanFunc = (
		function(pPlayer)
			pCiv = Players[Event_THOniKishinChief.Data2]
			Event_THOniKishinChief.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_OUTCOME_RESULT_1", pCiv:GetCivilizationShortDescription())
			
			return true
		end
		)
	Event_THOniKishinChief.Outcomes[1].DoFunc = (
		function(pPlayer)
			--print("Selecting Kishin Chief")
			local playerID = pPlayer:GetID()	
			local tKishinChief = InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_ONI_HERO, 1)
			local pCiv = Players[Event_THOniKishinChief.Data2]
			sImmortalName = Locale.ConvertTextKey(GameInfo.Leaders[pCiv:GetLeaderType()].Description)	
			if not(pCiv:IsDenouncingPlayer(pPlayer)) then
				pCiv:DoForceDenounce(pPlayer)
			end
			immortalKey = "Event_THOniKishinChief" .. Event_THOniKishinChief.Data2
			save(pPlayer, immortalKey, true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_THOniKishinChief.Name))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_TH_ONI_KISHIN_CHIEF", sImmortalName, pCiv:GetCivilizationShortDescription())) 
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_THOniKishinChief.Outcomes[2] = {}
	Event_THOniKishinChief.Outcomes[2].Name = "TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_OUTCOME_2"
	Event_THOniKishinChief.Outcomes[2].Desc = "TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_OUTCOME_2_DESC"
	Event_THOniKishinChief.Outcomes[2].Weight = 7
	Event_THOniKishinChief.Outcomes[2].CanFunc = (
		function(pPlayer)
			Event_THOniKishinChief.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_OUTCOME_RESULT_2")

			return true
		end
		)
	Event_THOniKishinChief.Outcomes[2].DoFunc = (
		function(pPlayer)
			immortalKey = "Event_THOniKishinChief" .. Event_THOniKishinChief.Data2
			save(pPlayer, immortalKey, true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TH_ONI_KISHIN_CHIEF_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_THOniKishinChief.Name))
		end
		)
tEvents.Event_THOniKishinChief = Event_THOniKishinChief
-- Forest of Magic Events
-- Author: BouncyMischa
--=======================================================================================================================

print("Marisa Events: loaded")

--------------------------------------------------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------------------------------------------------

local iFOMCiv = GameInfoTypes["CIVILIZATION_TH_FOREST_OF_MAGIC"]
local iRenaissanceEra = GameInfoTypes["ERA_RENAISSANCE"]

--=======================================================================================================================
-- Forest of Magic Events
--=======================================================================================================================
--  Fairy Pranks
--------------------------------------------------------------------------------------------------------------------------
local Event_FOMFairyPranks = {}
	Event_FOMFairyPranks.Name = "TXT_KEY_EVENT_FOM_FAIRY_PRANKS"
	Event_FOMFairyPranks.Desc = "TXT_KEY_EVENT_FOM_FAIRY_PRANKS_DESC"
	Event_FOMFairyPranks.Weight = 15
	Event_FOMFairyPranks.CanFunc = (
		function(pPlayer)	
			print("Checking for Fairy Pranks")		
			local tPlots ={}
			local iForest = FeatureTypes.FEATURE_FOREST
			local iJungle = FeatureTypes.FEATURE_JUNGLE
			local iMarsh = FeatureTypes.FEATURE_MARSH
			local iPlayer = pPlayer:GetID()

			if pPlayer:GetCivilizationType() ~= iFOMCiv then return false end

			for pCity in pPlayer:Cities() do
				if not (pCity:IsHasBuilding(GameInfoTypes.BUILDING_FOM_FAIRY_TREE_HAPPY)) then
					local pCentralPlot = pCity:Plot()
					for pPlot in PlotAreaSpiralIterator(pCentralPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						local tPlot = {}
						local iFeature = pPlot:GetFeatureType()
						if ((iFeature == iForest) or (iFeature == iJungle) or (iFeature == iMarsh)) and (pPlot:GetOwner() == iPlayer) and (pPlot:GetImprovementType() == -1) and (pPlot:GetResourceType() == -1) then
							local tPlot = {}
							tPlot.City = pCity
							tPlot.Plot = pPlot
							table.insert(tPlots, tPlot)
						end
					end
				end
			end
			
			if #tPlots < 1 then return false end
			
			local tPlot = tPlots[GetRandom(1, #tPlots)]
			
			Event_FOMFairyPranks.Data1 = tPlot.City
			Event_FOMFairyPranks.Data2 = tPlot.Plot
			
			Event_FOMFairyPranks.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_FAIRY_PRANKS_DESC", Event_FOMFairyPranks.Data1:GetName())
			
			return true
		end
		)
	Event_FOMFairyPranks.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_FOMFairyPranks.Outcomes[1] = {}
	Event_FOMFairyPranks.Outcomes[1].Name = "TXT_KEY_EVENT_FOM_FAIRY_PRANKS_OUTCOME_1"
	Event_FOMFairyPranks.Outcomes[1].Desc = "TXT_KEY_EVENT_FOM_FAIRY_PRANKS_OUTCOME_RESULT_1"
	Event_FOMFairyPranks.Outcomes[1].CanFunc = (
		function(pPlayer)	
			Event_FOMFairyPranks.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_FAIRY_PRANKS_OUTCOME_RESULT_1")

			return true
		end
		)
	Event_FOMFairyPranks.Outcomes[1].DoFunc = (
		function(pPlayer) 
			local pPlot = Event_FOMFairyPranks.Data2
			local pCity = Event_FOMFairyPranks.Data1
			local iImprovement = GameInfoTypes.IMPROVEMENT_FAIRY_TREE
			if (GetRandom(1, 100) >= 50) then
				local iFairyUnhappy = pCity:GetNumRealBuilding(GameInfoTypes.BUILDING_FOM_FAIRY_PRANKS)
				iFairyUnhappy = iFairyUnhappy + 1
				print("Unhappiness increases to " .. iFairyUnhappy)
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_FOM_FAIRY_PRANKS, iFairyUnhappy)
				JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_FOM_FAIRY_PRANKS_OUTCOME_RESULT_1_NOTIFICATION", pCity:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_FAIRY_PRANKS"))
			else
				pPlot:SetImprovementType(iImprovement)
				local iFairyHappy = pCity:GetNumRealBuilding(GameInfoTypes.BUILDING_FOM_FAIRY_TREE_HAPPY)
				iFairyHappy = iFairyHappy + 1
				print("Happiness increases to " .. iFairyHappy)
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_FOM_FAIRY_TREE_HAPPY, iFairyHappy)
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_FOM_FAIRY_PRANKS, 0)

				JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_FOM_FAIRY_PRANKS_OUTCOME_RESULT_1_ALT_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_FAIRY_PRANKS"))
			end
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_FOMFairyPranks.Outcomes[2] = {}
	Event_FOMFairyPranks.Outcomes[2].Name = "TXT_KEY_EVENT_FOM_FAIRY_PRANKS_OUTCOME_2"
	Event_FOMFairyPranks.Outcomes[2].Desc = "TXT_KEY_EVENT_FOM_FAIRY_PRANKS_OUTCOME_RESULT_2"
	Event_FOMFairyPranks.Outcomes[2].CanFunc = (
		function(pPlayer)
			local pCity = Event_FOMFairyPranks.Data1			
			local iGoldCost = math.ceil(100 * iMod)
			Event_FOMFairyPranks.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_FAIRY_PRANKS_OUTCOME_RESULT_2", iGoldCost)
			if pPlayer:GetGold() < iGoldCost then return false end
			if not pCity:GetGarrisonedUnit() then return false end
			
			return true
		end
		)
	Event_FOMFairyPranks.Outcomes[2].DoFunc = (
		function(pPlayer) 
			local pCity = Event_FOMFairyPranks.Data2
			local iGoldCost = math.ceil(100 * iMod)
			pPlayer:ChangeGold(-iGoldCost)
			pCity:GetGarrisonedUnit():ChangeExperience(10)
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_FOM_FAIRY_PRANKS_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_FAIRY_PRANKS"))
		end)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_FOMFairyPranks.Outcomes[3] = {}
	Event_FOMFairyPranks.Outcomes[3].Name = "TXT_KEY_EVENT_FOM_FAIRY_PRANKS_OUTCOME_3"
	Event_FOMFairyPranks.Outcomes[3].Desc = "TXT_KEY_EVENT_FOM_FAIRY_PRANKS_OUTCOME_RESULT_3"
	Event_FOMFairyPranks.Outcomes[3].CanFunc = (
		function(pPlayer)
			local iGoldenAgeReward = math.ceil(50 * iMod)
			Event_FOMFairyPranks.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_FAIRY_PRANKS_OUTCOME_RESULT_3", iGoldenAgeReward)
			
			return true
		end
		)
	Event_FOMFairyPranks.Outcomes[3].DoFunc = (
		function(pPlayer) 
			local iGoldenAgeReward = math.ceil(50 * iMod)
			pPlayer:ChangeGoldenAgeProgressMeter(iGoldenAgeReward) 
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_FOM_FAIRY_PRANKS_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_FAIRY_PRANKS"))
		end
		)

tEvents.Event_FOMFairyPranks = Event_FOMFairyPranks
-------------------------------------------------------------------------------------------------------------------------
--  Carnivorous Plants
--------------------------------------------------------------------------------------------------------------------------
local Event_FOMCarnivorousPlants = {}
	Event_FOMCarnivorousPlants.Name = "TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS"
	Event_FOMCarnivorousPlants.Desc = "TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_DESC"
	Event_FOMCarnivorousPlants.Weight = 15
	Event_FOMCarnivorousPlants.CanFunc = (
		function(pPlayer)		
			print("Checking for Carnivorous Plants")	
			local tPlots ={}
			local iForest = FeatureTypes.FEATURE_FOREST
			local iJungle = FeatureTypes.FEATURE_JUNGLE
			local iMarsh = FeatureTypes.FEATURE_MARSH
			local iPlayer = pPlayer:GetID()

			if pPlayer:GetCivilizationType() ~= iFOMCiv then return false end

			for pCity in pPlayer:Cities() do
				local pCentralPlot = pCity:Plot()
				local sCityName = pCity:GetName()
				for pPlot in PlotAreaSpiralIterator(pCentralPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					local tPlot = {}
					local iFeature = pPlot:GetFeatureType()
					if ((iFeature == iForest) or (iFeature == iJungle) or (iFeature == iMarsh)) and (pPlot:GetOwner() == iPlayer) and (pPlot:GetImprovementType() == -1) and (pPlot:GetResourceType() == -1) then
						local tPlot = {}
						tPlot.City = pCity
						tPlot.Plot = pPlot
						table.insert(tPlots, tPlot)
					end
				end
			end
			
			if #tPlots < 1 then return false end
			
			print("Selecting plot")
			local tPlot = tPlots[GetRandom(1, #tPlots)]
			
			Event_FOMCarnivorousPlants.Data1 = tPlot.City
			Event_FOMCarnivorousPlants.Data2 = tPlot.Plot
			
			Event_FOMCarnivorousPlants.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_DESC", Event_FOMCarnivorousPlants.Data1:GetName())
			
			return true
		end
		)
	Event_FOMCarnivorousPlants.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_FOMCarnivorousPlants.Outcomes[1] = {}
	Event_FOMCarnivorousPlants.Outcomes[1].Name = "TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_1"
	Event_FOMCarnivorousPlants.Outcomes[1].Desc = "TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_1_DESC"
	Event_FOMCarnivorousPlants.Outcomes[1].CanFunc = (
		function(pPlayer)	
			local iGoldCost = math.ceil(75 * iMod)
			Event_FOMCarnivorousPlants.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_1_DESC", iGoldCost)
			if pPlayer:GetGold() < iGoldCost then return false end

			return true
		end
		)
	Event_FOMCarnivorousPlants.Outcomes[1].DoFunc = (
		function(pPlayer) 
			local iGoldCost = math.ceil(75 * iMod)
			pPlayer:ChangeGold(-iGoldCost)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_FOMCarnivorousPlants.Outcomes[2] = {}
	Event_FOMCarnivorousPlants.Outcomes[2].Name = "TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_2"
	Event_FOMCarnivorousPlants.Outcomes[2].Desc = "TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_2_DESC"
	Event_FOMCarnivorousPlants.Outcomes[2].CanFunc = (
		function(pPlayer)
			local pCity = Event_FOMCarnivorousPlants.Data1		
			Event_FOMCarnivorousPlants.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_2_DESC",  Event_FOMCarnivorousPlants.Data1:GetName())
			if not pCity:GetGarrisonedUnit() then return false end

			return true
		end
		)
	Event_FOMCarnivorousPlants.Outcomes[2].DoFunc = (
		function(pPlayer) 
			local pCity = Event_FOMCarnivorousPlants.Data1
			pCity:GetGarrisonedUnit():ChangeDamage(25)
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS"))
		end)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_FOMCarnivorousPlants.Outcomes[3] = {}
	Event_FOMCarnivorousPlants.Outcomes[3].Name = "TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_3"
	Event_FOMCarnivorousPlants.Outcomes[3].Desc = "TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_3_DESC"
	Event_FOMCarnivorousPlants.Outcomes[3].CanFunc = (
		function(pPlayer)		
			Event_FOMCarnivorousPlants.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_3_DESC",  Event_FOMCarnivorousPlants.Data1:GetName())

			return true
		end
		)
	Event_FOMCarnivorousPlants.Outcomes[3].DoFunc = (
		function(pPlayer) 
			local pPlot = Event_FOMFairyPranks.Data2
			pPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_CARNIVOROUS_PLANTS)
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS_OUTCOME_3_NOTIFICATION",  Event_FOMCarnivorousPlants.Data1:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_CARNIVOROUS_PLANTS"))
		end)
tEvents.Event_FOMCarnivorousPlants = Event_FOMCarnivorousPlants
-------------------------------------------------------------------------------------------------------------------------
--  Steal the Precious Thing
--------------------------------------------------------------------------------------------------------------------------
local Event_FOMPreciousThing = {}
	Event_FOMPreciousThing.Name = "TXT_KEY_EVENT_FOM_PRECIOUS_THING"
	Event_FOMPreciousThing.Desc = "TXT_KEY_EVENT_FOM_PRECIOUS_THING_DESC"
	Event_FOMPreciousThing.Weight = 15
	Event_FOMPreciousThing.CanFunc = (
		function(pPlayer)
			print("Checking for Precious Thing")
			local tBooks ={}
			local iPlayer = pPlayer:GetID()
						
			if pPlayer:GetCurrentEra() < iRenaissanceEra then return false end

			if pPlayer:GetCivilizationType() ~= iFOMCiv then return false end

			for i,v in pairs(Players[iPlayer]:GetEspionageSpies()) do
				if v.EstablishedSurveillance then
					local pCity = Map.GetPlot(v.CityX, v.CityY):GetPlotCity();
					local iVictim = pCity:GetOwner();
					local sCityName = pCity:GetName()
					if vPlayer ~= iPlayer then
						if pCity:IsHasBuilding(GameInfoTypes.BUILDING_LIBRARY) then
							local sLocation = "a library in " .. sCityName
							table.insert(tBooks, sLocation)
						end
						if pCity:IsHasBuilding(GameInfoTypes.BUILDING_UNIVERSITY) then
							local sLocation = "the University of " .. sCityName
							table.insert(tBooks, sLocation)
						end
						if pCity:IsHasBuilding(GameInfoTypes.BUILDING_GREAT_LIBRARY) then
							local sLocation = "the Great Library of " .. sCityName
							table.insert(tBooks, sLocation)
							table.insert(tBooks, sLocation)
						end
					end
				end
			end
			
			if #tBooks < 1 then return false end
			
			local sBook = tBooks[GetRandom(1, #tBooks)]
			
			Event_FOMPreciousThing.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_PRECIOUS_THING_DESC", sBook)
			
			return true
		end
		)
	Event_FOMPreciousThing.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_FOMPreciousThing.Outcomes[1] = {}
	Event_FOMPreciousThing.Outcomes[1].Name = "TXT_KEY_EVENT_FOM_PRECIOUS_THING_OUTCOME_1"
	Event_FOMPreciousThing.Outcomes[1].Desc = "TXT_KEY_EVENT_FOM_PRECIOUS_THING_OUTCOME_1_DESC"
	Event_FOMPreciousThing.Outcomes[1].CanFunc = (
		function(pPlayer)	
			local iGoldCost = math.ceil(100 * iMod)
			Event_FOMPreciousThing.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_PRECIOUS_THING_OUTCOME_1_DESC", iGoldCost)
			if not pPlayer:HasAvailableGreatWorkSlot(GameInfoTypes["GREAT_WORK_SLOT_LITERATURE"]) then return false end
			if pPlayer:GetGold() < iGoldCost then return false end
			return true
		end
		)
	Event_FOMPreciousThing.Outcomes[1].DoFunc = (
		function(pPlayer) 
		local iGoldCost = math.ceil(100 * iMod)
			pPlayer:ChangeGold(-iGoldCost) 
			pPlayer:InitUnit(GameInfoTypes["UNIT_WRITER"], pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY()):PushMission(GameInfoTypes["MISSION_CREATE_GREAT_WORK"])
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_PRECIOUS_THING_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_PRECIOUS_THING"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_FOMPreciousThing.Outcomes[2] = {}
	Event_FOMPreciousThing.Outcomes[2].Name = "TXT_KEY_EVENT_FOM_PRECIOUS_THING_OUTCOME_2"
	Event_FOMPreciousThing.Outcomes[2].Desc = "TXT_KEY_EVENT_FOM_PRECIOUS_THING_OUTCOME_2_DESC"
	Event_FOMPreciousThing.Outcomes[2].CanFunc = (
		function(pPlayer)
			Event_FOMPreciousThing.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_PRECIOUS_THING_OUTCOME_2_DESC")
			
			return true
		end
		)
	Event_FOMPreciousThing.Outcomes[2].DoFunc = (
		function(pPlayer) 
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_PRECIOUS_THING_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_FOM_PRECIOUS_THING"))
		end)
tEvents.Event_FOMPreciousThing = Event_FOMPreciousThing
--=======================================================================================================================
--=======================================================================================================================
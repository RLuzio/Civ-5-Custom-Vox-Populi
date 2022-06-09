-- Ningen no Sato Events
-- Author: BouncyMischa
--=======================================================================================================================

print("Ningen no Sato Events: loaded")

--=======================================================================================================================
-- Ningen no Sato Events
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------

local iHVCiv = GameInfoTypes["CIVILIZATION_TOUHOU_HV"]
local iIndustrialEra = GameInfoTypes["ERA_INDUSTRIAL"]
local iRenaissanceEra = GameInfoTypes["ERA_RENAISSANCE"]
local iMedievalEra = GameInfoTypes["ERA_MEDIEVAL"]

-------------------------------------------------------------------------------------------------------------------------
--  Zashiki-Warashi
-------------------------------------------------------------------------------------------------------------------------
local Event_HVZashikiWarashi = {}
	Event_HVZashikiWarashi.Name = "TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI"
	Event_HVZashikiWarashi.Desc = "TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_DESC"
	Event_HVZashikiWarashi.Weight = 20
	Event_HVZashikiWarashi.CanFunc = (
		function(pPlayer)

			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= iHVCiv then return false end

			if pPlayer:GetCurrentEra() < iMedievalEra then return false end
			
			print("Checking for Zashiki-Warashi Event.")

			local iPlayer = pPlayer:GetID()
			local tCities ={}
			for pCity in pPlayer:Cities() do
				local iCity = pCity:GetID()
				local strCityName = pCity:GetName();
				print("Checking " .. strCityName)
				if not (pCity:IsHasBuilding(GameInfoTypes.BUILDING_HV_ZASHIKI_WARASHI) or pCity:IsHasBuilding(GameInfoTypes.BUILDING_HV_HOBGOBLINS) or pCity:IsHasBuilding(GameInfoTypes.BUILDING_HV_SUSPICIOUS)) then
					print("Valid city")
					table.insert(tCities, pCity)
				end
			end

			if #tCities < 1 then return false end
			print("At least one valid city found")
			
			local pZashikiWarashiCity = tCities[GetRandom(1, #tCities)]

			Event_HVZashikiWarashi.Data1 = pZashikiWarashiCity

			-- Fire the Event! (if chances are met)
			Event_HVZashikiWarashi.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_DESC", pZashikiWarashiCity:GetName())

			return true
		end
		)
	Event_HVZashikiWarashi.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_HVZashikiWarashi.Outcomes[1] = {}
	Event_HVZashikiWarashi.Outcomes[1].Name = "TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_1"
	Event_HVZashikiWarashi.Outcomes[1].Desc = "TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_RESULT_1"
	Event_HVZashikiWarashi.Outcomes[1].Weight = 5
	Event_HVZashikiWarashi.Outcomes[1].CanFunc = (
		function(pPlayer)
			local pCity = Event_HVZashikiWarashi.Data1
			local iGold = math.ceil(200 * iMod)
			if pPlayer:GetGold() < iGold then return false end

			Event_HVZashikiWarashi.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_RESULT_1", iGold, pCity:GetName())
			
			return true
		end
		)
	Event_HVZashikiWarashi.Outcomes[1].DoFunc = (
		function(pPlayer)
			local pCity = Event_HVZashikiWarashi.Data1
			local iGold = math.ceil(200 * iMod)
			pPlayer:ChangeGold(-iGold)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_HV_ZASHIKI_WARASHI"], 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_HVZashikiWarashi.Name))
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_HVZashikiWarashi.Outcomes[2] = {}
	Event_HVZashikiWarashi.Outcomes[2].Name = "TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_2"
	Event_HVZashikiWarashi.Outcomes[2].Desc = "TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_RESULT_2"
	Event_HVZashikiWarashi.Outcomes[2].Weight = 5
	Event_HVZashikiWarashi.Outcomes[2].CanFunc = (
		function(pPlayer)
			local pCity = Event_HVZashikiWarashi.Data1
			local iCost = math.ceil(100 * iMod)

			Event_HVZashikiWarashi.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_RESULT_2", iCost, pCity:GetName())
			
			return true
		end
		)
	Event_HVZashikiWarashi.Outcomes[2].DoFunc = (
		function(pPlayer)
			local pCity = Event_HVZashikiWarashi.Data1
			local iCost = math.ceil(-100 * iMod)
			pPlayer:ChangeGoldenAgeProgressMeter(iCost)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_HV_HOBGOBLINS"], 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_HVZashikiWarashi.Name))
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_HVZashikiWarashi.Outcomes[3] = {}
	Event_HVZashikiWarashi.Outcomes[3].Name = "TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_3"
	Event_HVZashikiWarashi.Outcomes[3].Desc = "TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_RESULT_3"
	Event_HVZashikiWarashi.Outcomes[3].Weight = 3
	Event_HVZashikiWarashi.Outcomes[3].CanFunc = (
		function(pPlayer)
			local pCity = Event_HVZashikiWarashi.Data1

			Event_HVZashikiWarashi.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_RESULT_3", pCity:GetName())
			
			return true
		end
		)
	Event_HVZashikiWarashi.Outcomes[3].DoFunc = (
		function(pPlayer)
			local pCity = Event_HVZashikiWarashi.Data1
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_HV_SUSPICIOUS"], 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TH_HV_ZASHIKI_WARASHI_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey(Event_HVZashikiWarashi.Name))
		end
		)
tEvents.Event_HVZashikiWarashi = Event_HVZashikiWarashi
-------------------------------------------------------------------------------------------------------------------------
--  God of Fortune
-------------------------------------------------------------------------------------------------------------------------
local Event_HVGodOfFortune = {}
	Event_HVGodOfFortune.Name = "TXT_KEY_EVENT_HV_GOD_OF_FORTUNE"
	Event_HVGodOfFortune.Desc = "TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_DESC"
	Event_HVGodOfFortune.Weight = 15
	Event_HVGodOfFortune.CanFunc = (
		function(pPlayer)
			if pPlayer:GetCivilizationType() ~= iHVCiv then return false end	

			print("Checking for God of Fortune Event.")

			local iPlayer = pPlayer:GetID()
			local iFortuneType = GetRandom(1, 3)
			print("God is of type " .. iFortuneType)
			local pBestCity = nil
			local pBestYield = 0
			for pCity in pPlayer:Cities() do
				local pLocalYield = 0
				if (iFortuneType == 1) then
					pLocalYield = pCity:GetYieldRate(GameInfoTypes.YIELD_FOOD)
				end
				if (iFortuneType == 2) then
					pLocalYield = pCity:GetYieldRate(GameInfoTypes.YIELD_GOLD)
				end
				if (iFortuneType == 3) then
					pLocalYield = pCity:GetYieldRate(GameInfoTypes.YIELD_PRODUCTION)
				end
				print("Local yield is " .. pLocalYield)
				if pLocalYield > pBestYield then
					pBestCity = pCity
					pBestYield = pLocalYield
				end
			end
			
			if not pBestCity then return false end

			local strCityName = pBestCity:GetName();
			print("Best city is " .. strCityName)

			Event_HVGodOfFortune.Data1 = pBestCity
			Event_HVGodOfFortune.Data2 = iFortuneType

			-- Fire the Event! (if chances are met)
			Event_HVGodOfFortune.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_DESC", pBestCity:GetName())

			return true
		end
		)
	Event_HVGodOfFortune.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_HVGodOfFortune.Outcomes[1] = {}
	Event_HVGodOfFortune.Outcomes[1].Name = "TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME"
	Event_HVGodOfFortune.Outcomes[1].Desc = "TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME_RESULT_1"
	Event_HVGodOfFortune.Outcomes[1].Weight = 5
	Event_HVGodOfFortune.Outcomes[1].CanFunc = (
		function(pPlayer)
			local pCity = Event_HVGodOfFortune.Data1
			local iFood = math.floor(pCity:GetYieldRate(GameInfoTypes.YIELD_FOOD) * 5 * iMod)
			if (Event_HVGodOfFortune.Data2 ~= 1) then return false end

			Event_HVGodOfFortune.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME_RESULT_1", iFood, pCity:GetName())
			return true
		end
		)
	Event_HVGodOfFortune.Outcomes[1].DoFunc = (
		function(pPlayer, pCity, pPlot)
			local pCity = Event_HVGodOfFortune.Data1
			local iFood = math.ceil(pCity:GetYieldRate(GameInfoTypes.YIELD_FOOD) * 5 * iMod)
			pCity:ChangeFood(iFood)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME_RESULT_1_NOTIFICATION", pCity:GetName()), Locale.ConvertTextKey(Event_HVGodOfFortune.Name))
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_HVGodOfFortune.Outcomes[2] = {}
	Event_HVGodOfFortune.Outcomes[2].Name = "TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME"
	Event_HVGodOfFortune.Outcomes[2].Desc = "TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME_RESULT_2"
	Event_HVGodOfFortune.Outcomes[2].Weight = 5
	Event_HVGodOfFortune.Outcomes[2].CanFunc = (
		function(pPlayer)
			local pCity = Event_HVGodOfFortune.Data1
			local iGold = math.floor(pCity:GetYieldRate(GameInfoTypes.YIELD_GOLD) * 5 * iMod)

			if (Event_HVGodOfFortune.Data2 ~= 2) then return false end

			Event_HVGodOfFortune.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME_RESULT_2", iGold, pCity:GetName())
			
			return true
		end
		)
	Event_HVGodOfFortune.Outcomes[2].DoFunc = (
		function(pPlayer, pCity, pPlot)
			local pCity = Event_HVGodOfFortune.Data1
			local iGold = math.ceil(pCity:GetYieldRate(GameInfoTypes.YIELD_GOLD) * 5 * iMod)
			pPlayer:ChangeGold(iGold)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME_RESULT_2_NOTIFICATION", pCity:GetName()), Locale.ConvertTextKey(Event_HVGodOfFortune.Name))
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_HVGodOfFortune.Outcomes[3] = {}
	Event_HVGodOfFortune.Outcomes[3].Name = "TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME"
	Event_HVGodOfFortune.Outcomes[3].Desc = "TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME_RESULT_3"
	Event_HVGodOfFortune.Outcomes[3].Weight = 5
	Event_HVGodOfFortune.Outcomes[3].CanFunc = (
		function(pPlayer)
			local pCity = Event_HVGodOfFortune.Data1
			local iProduction = math.ceil(pCity:GetYieldRate(GameInfoTypes.YIELD_PRODUCTION) * 5 * iMod)

			if (Event_HVGodOfFortune.Data2 ~= 3) then return false end

			Event_HVGodOfFortune.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME_RESULT_3", iProduction, pCity:GetName())
			
			return true
		end
		)
	Event_HVGodOfFortune.Outcomes[3].DoFunc = (
		function(pPlayer, pCity, pPlot)
			local pCity = Event_HVGodOfFortune.Data1
			local iProduction = math.ceil(pCity:GetYieldRate(GameInfoTypes.YIELD_PRODUCTION) * 5 * iMod)
			pCity:ChangeProduction(iProduction)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HV_GOD_OF_FORTUNE_OUTCOME_RESULT_3_NOTIFICATION", pCity:GetName()), Locale.ConvertTextKey(Event_HVGodOfFortune.Name))
		end
		)
tEvents.Event_HVGodOfFortune = Event_HVGodOfFortune
-------------------------------------------------------------------------------------------------------------------------
--  Hopeless Masquerade
-------------------------------------------------------------------------------------------------------------------------
local Event_HVHopelessMasquerade = {}
	Event_HVHopelessMasquerade.Name = "TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE"
	Event_HVHopelessMasquerade.Desc = "TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_DESC"
	Event_HVHopelessMasquerade.Weight = 40
	Event_HVHopelessMasquerade.CanFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()
	
			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= iHVCiv then return false end

			if pPlayer:GetCurrentEra() < iRenaissanceEra then return false end

			print("Checking for Hopeless Masquerade Event.")

			if not(pPlayer:IsEmpireUnhappy() or pPlayer:IsEmpireVeryUnhappy() or pPlayer:IsEmpireSuperUnhappy()) then return false end

			--print("Human Village is unhappy")

			local pNumReligions = GetNumReligionsinEmpire(pPlayer)
			--print("Num religions: " .. pNumReligions)
			if pNumReligions < 2 then return false end

			print("At least two religions for Hopeless Masquerade found")

			-- Fire the Event! (if chances are met)
			Event_HVHopelessMasquerade.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_DESC")

			return true
		end
		)
	Event_HVHopelessMasquerade.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_HVHopelessMasquerade.Outcomes[1] = {}
	Event_HVHopelessMasquerade.Outcomes[1].Name = "TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_OUTCOME_1"
	Event_HVHopelessMasquerade.Outcomes[1].Desc = "TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_OUTCOME_1_DESC"
	Event_HVHopelessMasquerade.Outcomes[1].Weight = 3
	Event_HVHopelessMasquerade.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iCities = pPlayer:GetNumCities()
			local iFaith = math.ceil(100 * iCities * iMod)

			Event_HVHopelessMasquerade.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_OUTCOME_RESULT_1", iFaith)
			
			return true
		end
		)
	Event_HVHopelessMasquerade.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iCities = pPlayer:GetNumCities()
			local iFaith = math.ceil(100 * iCities * iMod)
			pPlayer:ChangeFaith(iFaith)

			local iReligion = pPlayer:GetReligionCreatedByPlayer();
			if not(iReligion) then 
				iReligion = GetPlayerMajorityReligion(pPlayer)
			end
			ConvertPlayerReligion(pPlayer, iReligion, 50)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_OUTCOME_RESULT_1_NOTIFICATION", Game.GetReligionName(iReligion)), Locale.ConvertTextKey(Event_HVHopelessMasquerade.Name))
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_HVHopelessMasquerade.Outcomes[2] = {}
	Event_HVHopelessMasquerade.Outcomes[2].Name = "TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_OUTCOME_2"
	Event_HVHopelessMasquerade.Outcomes[2].Desc = "TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_OUTCOME_2_DESC"
	Event_HVHopelessMasquerade.Outcomes[2].Weight = 6
	Event_HVHopelessMasquerade.Outcomes[2].CanFunc = (
		function(pPlayer)
			local iCities = pPlayer:GetNumCities()
			local iGold = math.ceil(50 * iCities * iMod)

			Event_HVHopelessMasquerade.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_OUTCOME_RESULT_2", iGold)

			return true
		end
		)
	Event_HVHopelessMasquerade.Outcomes[2].DoFunc = (
		function(pPlayer)
			local iCities = pPlayer:GetNumCities()
			local iGold = math.ceil(50 * iCities * iMod)
			pPlayer:ChangeGold(iGold)

			for pCity in pPlayer:Cities() do
				local iNumMasquerades = pCity:GetNumBuilding(GameInfoTypes.BUILDING_HV_HOPELESS_MASQUERADE)
				iNumMasquerades = iNumMasquerades + 1
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_HV_HOPELESS_MASQUERADE, iNumMasquerades)
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HV_HOPELESS_MASQUERADE_OUTCOME_RESULT_2_NOTIFICATION", Event_HVHopelessMasquerade.Data1:GetName()), Locale.ConvertTextKey(Event_HVHopelessMasquerade.Name))
		end
		)
tEvents.Event_HVHopelessMasquerade = Event_HVHopelessMasquerade
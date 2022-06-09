-- Moriya Shrine Events
-- Author: BouncyMischa
--=======================================================================================================================

print("Moriya Shrine Events: loaded")

--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetNumIncomingTradeRoutes
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetNumIncomingTradeRoutes(playerID, city)
	local player = Players[playerID]
	local tradeRoutes = player:GetTradeRoutes()
	local numIncomingTRs = 0
	for i, v in ipairs(tradeRoutes) do
		local originatingCity = v.FromCity
		local targetCity = v.ToCity
		if targetCity == city then
			numIncomingTRs = numIncomingTRs + 1
		end
	end
	
	return numIncomingTRs
end

--=======================================================================================================================
-- Moriya Shrine Events
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------

local iMoriyaCiv = GameInfoTypes["CIVILIZATION_MORIYA"]
local iIndustrialEra = GameInfoTypes["ERA_INDUSTRIAL"]

-------------------------------------------------------------------------------------------------------------------------
--  Onbashira Festival
-------------------------------------------------------------------------------------------------------------------------
local Event_MoriyaShrineOnbashira = {}
	Event_MoriyaShrineOnbashira.Name = "TXT_KEY_EVENT_MORIYA_ONBASHIRA_FESTIVAL"
	Event_MoriyaShrineOnbashira.Desc = "TXT_KEY_EVENT_MORIYA_ONBASHIRA_FESTIVAL_DESC"
	Event_MoriyaShrineOnbashira.Weight = 20
	Event_MoriyaShrineOnbashira.CanFunc = (
		function(pPlayer)
			print("Checking for Onbashira Event.")

			local sPlayerCiv = Locale.ConvertTextKey(GameInfo.Civilizations[pPlayer:GetCivilizationType()].Description)

			print("Civilization is " .. sPlayerCiv)

			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= iMoriyaCiv then return false end
	
			print("Moriya civ event")

			local iPlayer = pPlayer:GetID()
			local tCities ={}
			for pCity in pPlayer:Cities() do
				local iNumPlots = pCity:GetNumCityPlots();
				local strCityName = pCity:GetName();
				print("Checking " .. strCityName)
				for iPlot = 0, iNumPlots - 1 do
					local pPlot = pCity:GetCityIndexPlot(iPlot)
					if pPlot and pPlot:GetOwner() == iPlayer and pPlot:IsMountain() then
						print("Found a mountain")
						table.insert(tCities, pCity)
					end
				end
			end

			if #tCities < 1 then return false end
			print("At least one valid city found")
			
			local pOnbashiraCity = tCities[GetRandom(1, #tCities)]

			Event_MoriyaShrineOnbashira.Data1 = pOnbashiraCity

			-- Fire the Event! (if chances are met)
			Event_MoriyaShrineOnbashira.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_ONBASHIRA_FESTIVAL_DESC", pOnbashiraCity:GetName())

			return true
		end
		)
	Event_MoriyaShrineOnbashira.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_MoriyaShrineOnbashira.Outcomes[1] = {}
	Event_MoriyaShrineOnbashira.Outcomes[1].Name = "TXT_KEY_EVENT_MORIYA_ONBASHIRA_FESTIVAL_OUTCOME_1"
	Event_MoriyaShrineOnbashira.Outcomes[1].Desc = "TXT_KEY_EVENT_MORIYA_ONBASHIRA_FESTIVAL_OUTCOME_1_DESC"
	Event_MoriyaShrineOnbashira.Outcomes[1].Weight = 5
	Event_MoriyaShrineOnbashira.Outcomes[1].CanFunc = (
		function(pPlayer)
			local pCity = Event_MoriyaShrineOnbashira.Data1
			local iCulturePerTurn = pCity:GetJONSCulturePerTurn();
			local iFaithPerTurn = pCity:GetFaithPerTurn();
			
			local iFactor = 5
			if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_ONBASHIRA)) then
				iFactor = 10
			end

			iOnbashiraCulture = iCulturePerTurn * iFactor
			iOnbashiraFaith = iFaithPerTurn * iFactor

			Event_MoriyaShrineOnbashira.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_ONBASHIRA_FESTIVAL_OUTCOME_RESULT_1", iOnbashiraCulture, iOnbashiraFaith)
			
			return true
		end
		)
	Event_MoriyaShrineOnbashira.Outcomes[1].DoFunc = (
		function(pPlayer)
			local pCity = Event_MoriyaShrineOnbashira.Data1
			local iCulturePerTurn = pCity:GetJONSCulturePerTurn();
			local iFaithPerTurn = pCity:GetFaithPerTurn();

			local iFactor = 5
			if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_ONBASHIRA)) then
				iFactor = 10
			end

			iOnbashiraCulture = iCulturePerTurn * iFactor
			iOnbashiraFaith = iFaithPerTurn * iFactor

			pPlayer:ChangeJONSCulture(iOnbashiraCulture)
			pPlayer:ChangeFaith(iOnbashiraFaith)

			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_ONBASHIRA_ENABLER"], 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_ONBASHIRA_FESTIVAL_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_MoriyaShrineOnbashira.Name))
		end
		)
tEvents.Event_MoriyaShrineOnbashira = Event_MoriyaShrineOnbashira
-------------------------------------------------------------------------------------------------------------------------
--  Hisoutensoku
-------------------------------------------------------------------------------------------------------------------------
local Event_MoriyaShrineHisoutensoku = {}
	Event_MoriyaShrineHisoutensoku.Name = "TXT_KEY_EVENT_MORIYA_HISOUTENSOKU"
	Event_MoriyaShrineHisoutensoku.Desc = "TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_DESC"
	Event_MoriyaShrineHisoutensoku.Weight = 15
	Event_MoriyaShrineHisoutensoku.CanFunc = (
		function(pPlayer)
			if pPlayer:GetCivilizationType() ~= iMoriyaCiv then return false end	

			if pPlayer:GetCurrentEra() < iIndustrialEra then return false end

			bAlreadyHisoutensoku = false

			if load(pPlayer, "Event_MoriyaShrineHisoutensokuMecha") == true then return false end
			if load(pPlayer, "Event_MoriyaShrineHisoutensokuBalloon") == true then return false end
			
			if bAlreadyHisoutensoku then return false end
			
			-- Fire the Event! (if chances are met)
			Event_MoriyaShrineHisoutensoku.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_DESC")

			return true
		end
		)
	Event_MoriyaShrineHisoutensoku.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_MoriyaShrineHisoutensoku.Outcomes[1] = {}
	Event_MoriyaShrineHisoutensoku.Outcomes[1].Name = "TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_1"
	Event_MoriyaShrineHisoutensoku.Outcomes[1].Desc = "TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_1_DESC"
	Event_MoriyaShrineHisoutensoku.Outcomes[1].Weight = 5
	Event_MoriyaShrineHisoutensoku.Outcomes[1].CanFunc = (
		function(pPlayer)
			if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_LASERS)) then return false end

			Event_MoriyaShrineHisoutensoku.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_MoriyaShrineHisoutensoku.Outcomes[1].DoFunc = (
		function(pPlayer, pCity, pPlot)
			local tHisoutensoku = InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_MECH, 1)
			tHisoutensoku[1]:SetName("Hisoutensoku")
			tHisoutensoku[1]:SetHasPromotion(GameInfoTypes["PROMOTION_BLITZ"], true)
			tHisoutensoku[1]:SetHasPromotion(GameInfoTypes["PROMOTION_REPAIR"], true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_MoriyaShrineHisoutensoku.Name))
			save(pPlayer, "Event_MoriyaShrineHisoutensokuMecha", true)
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_MoriyaShrineHisoutensoku.Outcomes[2] = {}
	Event_MoriyaShrineHisoutensoku.Outcomes[2].Name = "TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_2"
	Event_MoriyaShrineHisoutensoku.Outcomes[2].Desc = "TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_2_DESC"
	Event_MoriyaShrineHisoutensoku.Outcomes[2].Weight = 5
	Event_MoriyaShrineHisoutensoku.Outcomes[2].CanFunc = (
		function(pPlayer)
			if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_STEAM_POWER)) then return false end

			Event_MoriyaShrineHisoutensoku.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_RESULT_2")
			
			return true
		end
		)
	Event_MoriyaShrineHisoutensoku.Outcomes[2].DoFunc = (
		function(pPlayer, pCity, pPlot)
			local pCity = pPlayer:GetCapitalCity()

			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_HISOUTENSOKU"], 1)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_HISOUTENSOKU_BONUS"], JFD_GetNumIncomingTradeRoutes(iPlayer, pCity))

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_MoriyaShrineHisoutensoku.Name))
			save(pPlayer, "Event_MoriyaShrineHisoutensokuBalloon", true)
		end
		)

	Event_MoriyaShrineHisoutensoku.Outcomes[2].Monitors = {}
	Event_MoriyaShrineHisoutensoku.Outcomes[2].Monitors[GameEvents.PlayerDoTurn] =  (	
	function(iPlayer)
		pPlayer = Players[iPlayer]
		if load(pPlayer, "Event_MoriyaShrineHisoutensokuBalloon") == true then
			local pCity = pPlayer:GetCapitalCity()
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_HISOUTENSOKU_BONUS"], JFD_GetNumIncomingTradeRoutes(iPlayer, pCity))
		end
	end
	)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_MoriyaShrineHisoutensoku.Outcomes[3] = {}
	Event_MoriyaShrineHisoutensoku.Outcomes[3].Name = "TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_3"
	Event_MoriyaShrineHisoutensoku.Outcomes[3].Desc = "TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_3_DESC"
	Event_MoriyaShrineHisoutensoku.Outcomes[3].Weight = 5
	Event_MoriyaShrineHisoutensoku.Outcomes[3].CanFunc = (
		function(pPlayer)

			Event_MoriyaShrineHisoutensoku.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_RESULT_3")
			
			return true
		end
		)
	Event_MoriyaShrineHisoutensoku.Outcomes[3].DoFunc = (
		function(pPlayer, pCity, pPlot)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_HISOUTENSOKU_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey(Event_MoriyaShrineHisoutensoku.Name))
		end
		)
tEvents.Event_MoriyaShrineHisoutensoku = Event_MoriyaShrineHisoutensoku
-------------------------------------------------------------------------------------------------------------------------
--  Kappa Dam
-------------------------------------------------------------------------------------------------------------------------
local Event_MoriyaShrineKappaDam = {}
	Event_MoriyaShrineKappaDam.Name = "TXT_KEY_EVENT_MORIYA_KAPPA_DAM"
	Event_MoriyaShrineKappaDam.Desc = "TXT_KEY_EVENT_MORIYA_KAPPA_DAM_DESC"
	Event_MoriyaShrineKappaDam.Weight = 15
	Event_MoriyaShrineKappaDam.CanFunc = (
		function(pPlayer)
			print("Checking for Kappa Dam Event.")
			local iPlayer = pPlayer:GetID()
	
			-- Check the Era
			if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_MACHINERY)) then return false end

			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= iMoriyaCiv then return false end
	
			print("Moriya Shrine and has Machinery")

			local tCities ={}
			for pCity in pPlayer:Cities() do
				print("Checking " .. pCity:GetName())
				if (not (pCity:IsHasBuilding(GameInfoTypes.BUILDING_MORIYA_KAPPA_DAM)) and (not (pCity:IsHasBuilding(GameInfoTypes.BUILDING_HYDRO_PLANT)))) then
					print(pCity:GetName() .. " has no Kappa Dam or Hydro Plant")
					local pCentralPlot = pCity:Plot()
					if (pCentralPlot:IsRiver()) then
						--print(pCity:GetName() .. " is on a river")
						local bDammable = false
						if (pCentralPlot:IsHills()) then 
							bDammable = true 
							--print("Central plot is hills")
						end
						for pPlot in PlotAreaSpiralIterator(pCentralPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							local iOwner = pPlot:GetOwner()	
							if (iOwner == iPlayer) then
								--print("Checking plot belonging to player")
								if (pPlot:IsHills()) or (pPlot:IsMountain()) then
									--print("Hills or Mountain found nearby")
									bDammable = true
								end
							end
						end
						if bDammable then
							table.insert(tCities, pCity)
							print("Adding " .. pCity:GetName() .. " to table")
						end
					end
				end
			end

			if #tCities < 1 then return false end
			print("At least one valid city for Kappa Dam found")
			
			local pKappaDamCity = tCities[GetRandom(1, #tCities)]

			Event_MoriyaShrineKappaDam.Data1 = pKappaDamCity

			-- Fire the Event! (if chances are met)
			Event_MoriyaShrineKappaDam.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_KAPPA_DAM_DESC", Event_MoriyaShrineKappaDam.Data1:GetName())

			return true
		end
		)
	Event_MoriyaShrineKappaDam.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_MoriyaShrineKappaDam.Outcomes[1] = {}
	Event_MoriyaShrineKappaDam.Outcomes[1].Name = "TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_1"
	Event_MoriyaShrineKappaDam.Outcomes[1].Desc = "TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_1_DESC"
	Event_MoriyaShrineKappaDam.Outcomes[1].Weight = 3
	Event_MoriyaShrineKappaDam.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iCost = math.ceil(100 * iMod)
			if pPlayer:GetFaith() < iCost then return false end

			Event_MoriyaShrineKappaDam.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_RESULT_1", iCost)
			
			return true
		end
		)
	Event_MoriyaShrineKappaDam.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iCost = math.ceil(100 * iMod)
			pPlayer:ChangeFaith(-iCost)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_MoriyaShrineKappaDam.Name))
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_MoriyaShrineKappaDam.Outcomes[2] = {}
	Event_MoriyaShrineKappaDam.Outcomes[2].Name = "TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_2"
	Event_MoriyaShrineKappaDam.Outcomes[2].Desc = "TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_2_DESC"
	Event_MoriyaShrineKappaDam.Outcomes[2].Weight = 6
	Event_MoriyaShrineKappaDam.Outcomes[2].CanFunc = (
		function(pPlayer)
			local iFaith = math.ceil(500 * iMod)
			local iGold = math.ceil(300 * iMod)
			if pPlayer:GetFaith() < iFaith then return false end
			if pPlayer:GetGold() < iGold then return false end

			Event_MoriyaShrineKappaDam.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_RESULT_2", iFaith, iGold, Locale.ConvertTextKey( Event_MoriyaShrineKappaDam.Data1:GetName()), Locale.ConvertTextKey(Event_MoriyaShrineKappaDam.Name))

			return true
		end
		)
	Event_MoriyaShrineKappaDam.Outcomes[2].DoFunc = (
		function(pPlayer)
			local pCity = Event_MoriyaShrineKappaDam.Data1
			local iFaith = math.ceil(300 * iMod)
			local iGold = math.ceil(500 * iMod)
			pPlayer:ChangeFaith(-iFaith)
			pPlayer:ChangeGold(-iGold)

			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_MORIYA_KAPPA_DAM"], 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_RESULT_2_NOTIFICATION", Event_MoriyaShrineKappaDam.Data1:GetName()), Locale.ConvertTextKey(Event_MoriyaShrineKappaDam.Name))
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_MoriyaShrineKappaDam.Outcomes[3] = {}
	Event_MoriyaShrineKappaDam.Outcomes[3].Name = "TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_3"
	Event_MoriyaShrineKappaDam.Outcomes[3].Desc = "TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_3_DESC"
	Event_MoriyaShrineKappaDam.Outcomes[3].Weight = 1
	Event_MoriyaShrineKappaDam.Outcomes[3].CanFunc = (
		function(pPlayer)
			Event_MoriyaShrineKappaDam.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_RESULT_3", Event_MoriyaShrineKappaDam.Data1:GetName())

			return true
		end
		)
	Event_MoriyaShrineKappaDam.Outcomes[3].DoFunc = (
		function(pPlayer)
			local pCity = Event_MoriyaShrineKappaDam.Data1
			local iPlayer = pPlayer:GetID()

			local pCentralPlot = pCity:Plot()
			for pPlot in PlotAreaSpiralIterator(pCentralPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				local iImprovement = pPlot:GetImprovementType()
				local iOwner = pPlot:GetOwner()
				local tPlot = {}
						
				if (iOwner == iPlayer) and (iImprovement ~= -1) and (pPlot:IsRiver()) then
					pPlot:SetImprovementPillaged(true)
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_MORIYA_KAPPA_DAM_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey(Event_MoriyaShrineKappaDam.Name))
		end
		)
tEvents.Event_MoriyaShrineKappaDam = Event_MoriyaShrineKappaDam
local Event_Junko_Grudge = {}
	Event_Junko_Grudge.Name = "TXT_KEY_EVENT_JUNKO_GRUDGE"
	Event_Junko_Grudge.Desc = "TXT_KEY_EVENT_JUNKO_GRUDGE_DESC"
	Event_Junko_Grudge.EventImage = "JunkoGrudge.dds"
	Event_Junko_Grudge.Weight = 5
	Event_Junko_Grudge.CanFunc = (
		function(pPlayer)
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_HELL) then return end
			if not(pPlayer:GetCapitalCity()) then return end
			if (Teams[pPlayer:GetTeam()]:GetAtWarCount(false)) > 0 then return end
			if (pPlayer:GetGold() < (math.ceil(200 * iMod))) then return end
			return true
		end
		)
	Event_Junko_Grudge.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Junko_Grudge.Outcomes[1] = {}
	Event_Junko_Grudge.Outcomes[1].Name = "TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_1"
	Event_Junko_Grudge.Outcomes[1].Desc = "TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_1_DESC"
	Event_Junko_Grudge.Outcomes[1].CanFunc = (
		function(pPlayer)
			if not(pPlayer:GetCapitalCity()) then return end
			if (pPlayer:GetCapitalCity()):GetPopulation() < 2 then return end

			Event_Junko_Grudge.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_1_DESC", (math.ceil(30 * iMod)))
			return true
		end
		)
	Event_Junko_Grudge.Outcomes[1].DoFunc = (
		function(pPlayer)
			local pCity = pPlayer:GetCapitalCity()
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_TH_HELL_JUNKO_GRUDGE, 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_1_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE")
			)
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Junko_Grudge.Outcomes[2] = {}
	Event_Junko_Grudge.Outcomes[2].Name = "TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_2"
	Event_Junko_Grudge.Outcomes[2].Desc = "TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_2_DESC"
	Event_Junko_Grudge.Outcomes[2].CanFunc = (
		function(pPlayer)
			if not(pPlayer:GetCapitalCity()) then return end
			local pCity = pPlayer:GetCapitalCity()
			local iGold = math.ceil(200 * iMod)
			if (pPlayer:GetGold() < iGold) then return end
			local nearestDistance = 10000
			local nearestCityState = nil
			for iCS, pCS in pairs(Players) do
				if (pCS:IsAlive() and pCS:IsMinorCiv() and Teams[pPlayer:GetTeam()]:IsHasMet(pCS:GetTeam())) then
					local tCity = pCS:GetCapitalCity()
					if tCity ~= nil then
						local distance = Map.PlotDistance(tCity:GetX(), tCity:GetY(), pCity:GetX(), pCity:GetY())
						if distance < nearestDistance then
							nearestDistance = distance
							nearestCityState = tCity
						end
					end
				end
			end
			if nearestCityState == nil then return end
			Event_Junko_Grudge.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_2_DESC", iGold, nearestCityState:GetName())
			return true
		end
		)
	Event_Junko_Grudge.Outcomes[2].DoFunc = (
		function(pPlayer)
			local pCity = pPlayer:GetCapitalCity()
			local iGold = math.ceil(200 * iMod)
			pPlayer:ChangeGold(-iGold)
			local nearestDistance = 10000
			local nearestCityState = nil
			for iCS, pCS in pairs(Players) do
				if (pCS:IsAlive() and pCS:IsMinorCiv() and Teams[pPlayer:GetTeam()]:IsHasMet(pCS:GetTeam())) then
					local tCity = pCS:GetCapitalCity()
					if tCity ~= nil then
						local distance = Map.PlotDistance(tCity:GetX(), tCity:GetY(), pCity:GetX(), pCity:GetY())
						if distance < nearestDistance then
							nearestDistance = distance
							nearestCityState = tCity
						end
					end
				end
			end
			if nearestCityState ~= nil then
				if nearestCityState:GetPopulation() > 1 then
					nearestCityState:ChangePopulation(-1,1)
				end
				Players[nearestCityState:GetOwner()]:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), 30)
			end
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_2_NOTIFICATION", nearestCityState:GetName()),
				Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE")
			)
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_Junko_Grudge.Outcomes[3] = {}
	Event_Junko_Grudge.Outcomes[3].Name = "TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_3"
	Event_Junko_Grudge.Outcomes[3].Desc = "TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_3_DESC"
	Event_Junko_Grudge.Outcomes[3].CanFunc = (
		function(pPlayer)
			if not(pPlayer:GetCapitalCity()) then return end
			if (pPlayer:GetCapitalCity()):GetPopulation() < 2 then return end
			return true
		end
		)
	Event_Junko_Grudge.Outcomes[3].DoFunc = (
		function(pPlayer)
			local pCity = pPlayer:GetCapitalCity()
			if pCity:GetPopulation() > 1 then
				pCity:ChangePopulation(-1,1)
			end
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_3_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE")
			)
		end
		)

Events_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TH_HELL, "Event_Junko_Grudge", Event_Junko_Grudge)

function JunkoGrudgeCheck(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_HELL) then return end
	local junkogrudge = pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_TH_HELL_JUNKO_GRUDGE)
	for city in pPlayer:Cities() do
		city:SetNumRealBuilding(GameInfoTypes.BUILDING_TH_HELL_JUNKO_GRUDGE, 0)
	end
	local pCity = pPlayer:GetCapitalCity()
	if pCity ~= nil then
		if junkogrudge > 0 then
			if (Teams[pPlayer:GetTeam()]:GetAtWarCount(false)) > 0 then
				pPlayer:ChangeFaith(30 * iMod)
				pPlayer:ChangeJONSCulture(30 * iMod)
				JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
					Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_1_NOTIFICATION_MET"),
					Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE")
				)
			else
				if pCity:GetPopulation() > 1 then
					pCity:ChangePopulation(-1,1)
				end
				JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
					Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE_OUTCOME_3_NOTIFICATION"),
					Locale.ConvertTextKey("TXT_KEY_EVENT_JUNKO_GRUDGE")
				)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(JunkoGrudgeCheck)
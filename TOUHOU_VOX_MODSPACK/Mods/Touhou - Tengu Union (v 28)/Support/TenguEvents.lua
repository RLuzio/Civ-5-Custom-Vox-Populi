local Event_Youkai_Mountain_Incident = {}
	Event_Youkai_Mountain_Incident.Name = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT"
	Event_Youkai_Mountain_Incident.Desc = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_DESC"
	Event_Youkai_Mountain_Incident.EventImage = "YoukaiMountainIncident.dds"
	Event_Youkai_Mountain_Incident.Weight = 100
	Event_Youkai_Mountain_Incident.CanFunc = ( 
		function(pPlayer)
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TOUHOU_TENGU) then return end
			if load(pPlayer, "Event_Youkai_Mountain_Incident") then return end
			local iEra = pPlayer:GetCurrentEra()
			if (iEra < GameInfoTypes.ERA_INDUSTRIAL) then return end

			local iGold = math.ceil(1000 * iMod)
			if (pPlayer:GetGold() < iGold) then return end

			local iCulture = math.ceil(500 * iMod)
			if (pPlayer:GetJONSCulture() < iCulture) then return end

			if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return end

			if not(pPlayer:GetCapitalCity()) then return end

			return true
		end
		)
	Event_Youkai_Mountain_Incident.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Youkai_Mountain_Incident.Outcomes[1] = {}
	Event_Youkai_Mountain_Incident.Outcomes[1].Name = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_1"
	Event_Youkai_Mountain_Incident.Outcomes[1].Desc = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_1_DESC"
	Event_Youkai_Mountain_Incident.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iFaith = math.ceil(500 * iMod)
			Event_Youkai_Mountain_Incident.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_1_DESC", iFaith)
			return true
		end
		)
	Event_Youkai_Mountain_Incident.Outcomes[1].DoFunc = (
		function(pPlayer)
			pPlayer:ChangeNumResourceTotal(iMagistrate, 1)

			local iFaith = math.ceil(500 * iMod)
			pPlayer:ChangeFaith(iFaith)

			save(pPlayer, "Event_Youkai_Mountain_Incident", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_1_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT")
			)
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Youkai_Mountain_Incident.Outcomes[2] = {}
	Event_Youkai_Mountain_Incident.Outcomes[2].Name = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_2"
	Event_Youkai_Mountain_Incident.Outcomes[2].Desc = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_2_DESC"
	Event_Youkai_Mountain_Incident.Outcomes[2].CanFunc = (
		function(pPlayer)
			if not(pPlayer:GetCapitalCity()) then return end
			return true
		end
		)
	Event_Youkai_Mountain_Incident.Outcomes[2].DoFunc = (
		function(pPlayer)
			local pCity = pPlayer:GetCapitalCity()
			InitUnitFromCity(pCity, GameInfoTypes.UNIT_REPORTER_JOURNALIST, 1)
			save(pPlayer, "Event_Youkai_Mountain_Incident", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_2_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT")
			)
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_Youkai_Mountain_Incident.Outcomes[3] = {}
	Event_Youkai_Mountain_Incident.Outcomes[3].Name = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_3"
	Event_Youkai_Mountain_Incident.Outcomes[3].Desc = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_3_DESC"
	Event_Youkai_Mountain_Incident.Outcomes[3].CanFunc = (
		function(pPlayer)
			if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return end
			local iCulture = math.ceil(500 * iMod)
			if (pPlayer:GetJONSCulture() < iCulture) then return end
			Event_Youkai_Mountain_Incident.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_3_DESC", iCulture)
			return true
		end
		)
	Event_Youkai_Mountain_Incident.Outcomes[3].DoFunc = (
		function(pPlayer)
			pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
			local iCulture = math.ceil(500 * iMod)
			pPlayer:ChangeJONSCulture(-iCulture)

			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_MORIYA_ACCEPT_DUMMY, true)

			save(pPlayer, "Event_Youkai_Mountain_Incident", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_3_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT")
			)
		end
		)
	--=========================================================
	-- Outcome 4
	--=========================================================
	Event_Youkai_Mountain_Incident.Outcomes[4] = {}
	Event_Youkai_Mountain_Incident.Outcomes[4].Name = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_4"
	Event_Youkai_Mountain_Incident.Outcomes[4].Desc = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_4_DESC"
	Event_Youkai_Mountain_Incident.Outcomes[4].CanFunc = (
		function(pPlayer)
			local iGold = math.ceil(1000 * iMod)
			if (pPlayer:GetGold() < iGold) then return end
			if not(pPlayer:GetCapitalCity()) then return end
			Event_Youkai_Mountain_Incident.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_4_DESC", iGold)
			return true
		end
		)
	Event_Youkai_Mountain_Incident.Outcomes[4].DoFunc = (
		function(pPlayer)
			local iGold = math.ceil(1000 * iMod)
			pPlayer:ChangeGold(-iGold)
			local pCity = pPlayer:GetCapitalCity()
			for i = 1, 4 do
				local iUnit = nil
				for sUnitType, iCombat in pairs(tUnitTable.Melee) do
					if pPlayer:CanTrain(GameInfoTypes[sUnitType]) then
						if iUnit == nil then
							iUnit = GameInfoTypes[sUnitType]
						elseif iCombat > GameInfo.Units[iUnit].Combat then
							iUnit = GameInfoTypes[sUnitType]
						end
					end
				end
				if iUnit ~= nil then InitUnitFromCity(pCity, iUnit, 1) end
			end
			InitUnitFromCity(pCity, GameInfoTypes.UNIT_GREAT_GENERAL, 1)
			save(pPlayer, "Event_Youkai_Mountain_Incident", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_4_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT")
			)
		end
		)
	--=========================================================
	-- Outcome 5
	--=========================================================
	Event_Youkai_Mountain_Incident.Outcomes[5] = {}
	Event_Youkai_Mountain_Incident.Outcomes[5].Name = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_5"
	Event_Youkai_Mountain_Incident.Outcomes[5].Desc = "TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_5_DESC"
	Event_Youkai_Mountain_Incident.Outcomes[5].CanFunc = (
		function(pPlayer)
			local iGold = math.ceil(500 * iMod)
			if (pPlayer:GetGold() < iGold) then return end
			if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return end
			if not(pPlayer:GetCapitalCity()) then return end
			Event_Youkai_Mountain_Incident.Outcomes[5].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_5_DESC", iGold)
			return true
		end
		)
	Event_Youkai_Mountain_Incident.Outcomes[5].DoFunc = (
		function(pPlayer)
			local iGold = math.ceil(500 * iMod)
			pPlayer:ChangeGold(-iGold)
			pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
			local pCity = pPlayer:GetCapitalCity()
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_MORIYA_CONSPIRACY_DUMMY, 1)
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_MORIYA_CONSPIRACY_DUMMY, 0)

			save(pPlayer, "Event_Youkai_Mountain_Incident", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT_OUTCOME_5_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_YOUKAI_MOUNTAIN_INCIDENT")
			)
		end
		)

Events_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TOUHOU_TENGU, "Event_Youkai_Mountain_Incident", Event_Youkai_Mountain_Incident)
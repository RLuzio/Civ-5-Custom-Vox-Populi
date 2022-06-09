local Event_Slacking_Shinigami = {}
	Event_Slacking_Shinigami.Name = "TXT_KEY_EVENT_SLACKING_SHINIGAMI"
	Event_Slacking_Shinigami.Desc = "TXT_KEY_EVENT_SLACKING_SHINIGAMI_DESC"
	Event_Slacking_Shinigami.EventImage = "SlackingShinigami.dds"
	Event_Slacking_Shinigami.Weight = 20
	Event_Slacking_Shinigami.CanFunc = ( 
		function(pPlayer)
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_HIGAN) then return end
			if pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_SHIGAN) < 1 then return end

			if not(pPlayer:GetCapitalCity()) then return end
			return true
		end
		)
	Event_Slacking_Shinigami.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Slacking_Shinigami.Outcomes[1] = {}
	Event_Slacking_Shinigami.Outcomes[1].Name = "TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_1"
	Event_Slacking_Shinigami.Outcomes[1].Desc = "TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_1_DESC"
	Event_Slacking_Shinigami.Outcomes[1].CanFunc = (
		function(pPlayer)
			if not(pPlayer:GetCapitalCity()) then return end
			return true
		end
		)
	Event_Slacking_Shinigami.Outcomes[1].DoFunc = (
		function(pPlayer)
			local pCity = pPlayer:GetCapitalCity()
			InitUnitFromCity(pCity, GameInfoTypes.UNIT_SHINIGAMI, 1)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_1_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_SLACKING_SHINIGAMI")
			)
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Slacking_Shinigami.Outcomes[2] = {}
	Event_Slacking_Shinigami.Outcomes[2].Name = "TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_2"
	Event_Slacking_Shinigami.Outcomes[2].Desc = "TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_2_DESC"
	Event_Slacking_Shinigami.Outcomes[2].CanFunc = (
		function(pPlayer)
			if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return end

			local iGoldenAge = math.ceil(500 * iMod)
			Event_Slacking_Shinigami.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_2_DESC", iGoldenAge)
			return true
		end
		)
	Event_Slacking_Shinigami.Outcomes[2].DoFunc = (
		function(pPlayer)
			pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

			local iGoldenAge = math.ceil(500 * iMod)
			pPlayer:ChangeGoldenAgeProgressMeter(iGoldenAge)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_2_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_SLACKING_SHINIGAMI")
			)
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_Slacking_Shinigami.Outcomes[3] = {}
	Event_Slacking_Shinigami.Outcomes[3].Name = "TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_3"
	Event_Slacking_Shinigami.Outcomes[3].Desc = "TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_3_DESC"
	Event_Slacking_Shinigami.Outcomes[3].CanFunc = (
		function(pPlayer)
			local iGold = math.ceil(400 * iMod)
			if (pPlayer:GetGold() < iGold) then return end

			if not(pPlayer:GetCapitalCity()) then return end
			Event_Slacking_Shinigami.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_3_DESC", iGold)
			return true
		end
		)
	Event_Slacking_Shinigami.Outcomes[3].DoFunc = (
		function(pPlayer)
			local iGold = math.ceil(400 * iMod)
			pPlayer:ChangeGold(-iGold)

			local pCity = pPlayer:GetCapitalCity()
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_SLACKING_SHINIGAMI_DUMMY, pCity:GetNumRealBuilding(GameInfoTypes.BUILDING_SLACKING_SHINIGAMI_DUMMY) + 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_SLACKING_SHINIGAMI_OUTCOME_3_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_SLACKING_SHINIGAMI")
			)
		end
		)

Events_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_HIGAN, "Event_Slacking_Shinigami", Event_Slacking_Shinigami)
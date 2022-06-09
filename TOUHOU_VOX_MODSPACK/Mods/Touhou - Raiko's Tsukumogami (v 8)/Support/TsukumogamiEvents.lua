-- TsukumogamiEvents
-- Author: Igniszath
-- DateCreated: 8/25/2017 11:41:10 PM
--------------------------------------------------------------
local Event_Wanted_Amanojaku = {}
	Event_Wanted_Amanojaku.Name = "TXT_KEY_EVENT_WANTED_AMANOJAKU"
	Event_Wanted_Amanojaku.Desc = "TXT_KEY_EVENT_WANTED_AMANOJAKU_DESC"
	Event_Wanted_Amanojaku.EventImage = "WantedAmanojaku.dds"
	Event_Wanted_Amanojaku.Weight = 20
	Event_Wanted_Amanojaku.CanFunc = ( 
		function(pPlayer)
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TSUKUMOGAMI) then return end
			if load(pPlayer, "Event_Wanted_Amanojaku") then return end
			local iEra = pPlayer:GetCurrentEra()
			if (iEra < GameInfoTypes.ERA_MODERN) then return end

			return true
		end
		)
	Event_Wanted_Amanojaku.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Wanted_Amanojaku.Outcomes[1] = {}
	Event_Wanted_Amanojaku.Outcomes[1].Name = "TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_1"
	Event_Wanted_Amanojaku.Outcomes[1].Desc = "TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_1_DESC"
	Event_Wanted_Amanojaku.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iGoldenAge = math.ceil(500 * iMod)
			Event_Wanted_Amanojaku.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_1_DESC", iGoldenAge)
			return true
		end
		)
	Event_Wanted_Amanojaku.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iGoldenAge = math.ceil(500 * iMod)
			pPlayer:ChangeGoldenAgeProgressMeter(iGoldenAge)

			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_SEARCHED_FOR_AMANOJAKU_DUMMY, true)

			save(pPlayer, "Event_Wanted_Amanojaku", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_1_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_WANTED_AMANOJAKU")
			)
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Wanted_Amanojaku.Outcomes[2] = {}
	Event_Wanted_Amanojaku.Outcomes[2].Name = "TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_2"
	Event_Wanted_Amanojaku.Outcomes[2].Desc = "TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_2_DESC"
	Event_Wanted_Amanojaku.Outcomes[2].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_Wanted_Amanojaku.Outcomes[2].DoFunc = (
		function(pPlayer)
			local pTeam = Teams[pPlayer:GetTeam()]
			for iCiv = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
				local pCiv = Players[iCiv]
				if pCiv:IsAlive() and pTeam:IsHasMet(pCiv:GetTeam()) and pCiv:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TSUKUMOGAMI then 
					local iRand = Game.Rand(100, "Rolling for denouncement")
					if not(pCiv:IsDenouncingPlayer(pPlayer)) and iRand < 50 then
						pCiv:DoForceDenounce(pPlayer)
					end
				end
			end
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_AMANOJAKU_ASYLUM_DUMMY, true)
			save(pPlayer, "Event_Wanted_Amanojaku", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_2_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_WANTED_AMANOJAKU")
			)
		end
	)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_Wanted_Amanojaku.Outcomes[3] = {}
	Event_Wanted_Amanojaku.Outcomes[3].Name = "TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_3"
	Event_Wanted_Amanojaku.Outcomes[3].Desc = "TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_3_DESC"
	Event_Wanted_Amanojaku.Outcomes[3].CanFunc = (
		function(pPlayer)
			if not(pPlayer:GetCapitalCity()) then return end
			local iTurns = math.ceil(3 * iGAMod)
			Event_Wanted_Amanojaku.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_3_DESC", iTurns)
			return true
		end
		)
	Event_Wanted_Amanojaku.Outcomes[3].DoFunc = (
		function(pPlayer)
			local iTurns = math.ceil(3 * iGAMod)
			local pCapital = pPlayer:GetCapitalCity()
			InitUnitFromCity(pCapital, GameInfoTypes.UNIT_GREAT_MUSICIAN, 3)
			for pCity in pPlayer:Cities() do
				pCity:ChangeResistanceTurns(iTurns)
			end
			save(pPlayer, "Event_Wanted_Amanojaku", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_WANTED_AMANOJAKU_OUTCOME_3_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_WANTED_AMANOJAKU")
			)
		end
		)

Events_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TSUKUMOGAMI, "Event_Wanted_Amanojaku", Event_Wanted_Amanojaku)
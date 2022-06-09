local Event_Flower_Viewings_Popular = {}
	Event_Flower_Viewings_Popular.Name = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR"
	Event_Flower_Viewings_Popular.Desc = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_DESC"
	Event_Flower_Viewings_Popular.EventImage = "FlowerViewingsPopular.dds"
	Event_Flower_Viewings_Popular.Weight = 10
	Event_Flower_Viewings_Popular.CanFunc = ( 
		function(pPlayer)
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_NETHERWORLD) then return end
			if load(pPlayer, "Event_Flower_Viewings_Popular") then return end
			if not(pPlayer:IsGoldenAge()) then return end
			if pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN) < 1 then return end

			return true
		end
		)
	Event_Flower_Viewings_Popular.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Flower_Viewings_Popular.Outcomes[1] = {}
	Event_Flower_Viewings_Popular.Outcomes[1].Name = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_1"
	Event_Flower_Viewings_Popular.Outcomes[1].Desc = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_1_DESC"
	Event_Flower_Viewings_Popular.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_Flower_Viewings_Popular.Outcomes[1].DoFunc = (
		function(pPlayer)
			local pCity = pPlayer:GetCapitalCity()
			for xCity in pPlayer:Cities() do
				if (xCity:IsHasBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN)) then
					pCity = xCity
					break
				end
			end
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN, 0)
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN_CHARGE, 1)

			save(pPlayer, "Event_Flower_Viewings_Popular", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_1_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR")
			)
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Flower_Viewings_Popular.Outcomes[2] = {}
	Event_Flower_Viewings_Popular.Outcomes[2].Name = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_2"
	Event_Flower_Viewings_Popular.Outcomes[2].Desc = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_2_DESC"
	Event_Flower_Viewings_Popular.Outcomes[2].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_Flower_Viewings_Popular.Outcomes[2].DoFunc = (
		function(pPlayer)
			local pCity = pPlayer:GetCapitalCity()
			for xCity in pPlayer:Cities() do
				if (xCity:IsHasBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN)) then
					pCity = xCity
					break
				end
			end
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN, 0)
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN_CONCESSIONS, 1)

			save(pPlayer, "Event_Flower_Viewings_Popular", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_2_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR")
			)
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_Flower_Viewings_Popular.Outcomes[3] = {}
	Event_Flower_Viewings_Popular.Outcomes[3].Name = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_3"
	Event_Flower_Viewings_Popular.Outcomes[3].Desc = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_3_DESC"
	Event_Flower_Viewings_Popular.Outcomes[3].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_Flower_Viewings_Popular.Outcomes[3].DoFunc = (
		function(pPlayer)
			local pCity = pPlayer:GetCapitalCity()
			for xCity in pPlayer:Cities() do
				if (xCity:IsHasBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN)) then
					pCity = xCity
					break
				end
			end
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN, 0)
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN_CHARGECONCESSIONS, 1)

			save(pPlayer, "Event_Flower_Viewings_Popular", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_3_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR")
			)
		end
		)
	--=========================================================
	-- Outcome 4
	--=========================================================
	Event_Flower_Viewings_Popular.Outcomes[4] = {}
	Event_Flower_Viewings_Popular.Outcomes[4].Name = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_4"
	Event_Flower_Viewings_Popular.Outcomes[4].Desc = "TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_4_DESC"
	Event_Flower_Viewings_Popular.Outcomes[4].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_Flower_Viewings_Popular.Outcomes[4].DoFunc = (
		function(pPlayer)
			local pCity = pPlayer:GetCapitalCity()
			for xCity in pPlayer:Cities() do
				if (xCity:IsHasBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN)) then
					pCity = xCity
					break
				end
			end
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN, 0)
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_NETHERWORLD_CHERRY_BLOSSOM_GARDEN_CONTEMPLATIVE, 1)

			save(pPlayer, "Event_Flower_Viewings_Popular", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC",
				Locale.ConvertTextKey("TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR_OUTCOME_4_NOTIFICATION"),
				Locale.ConvertTextKey("TXT_KEY_EVENT_FLOWER_VIEWINGS_POPULAR")
			)
		end
		)

Events_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_NETHERWORLD, "Event_Flower_Viewings_Popular", Event_Flower_Viewings_Popular)
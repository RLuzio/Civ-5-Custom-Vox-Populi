-- HumanVillageDecisions
-- Author: user
-- DateCreated: 8/31/2014 1:07:31 PM
--------------------------------------------------------------

print("Ningen no Sato Decisions: loaded")

--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Ningen no Sato: Establish a Village School
-------------------------------------------------------------------------------------------------------------------------

local Decisions_HVVillageSchool = {}
	Decisions_HVVillageSchool.Name = "TXT_KEY_DECISIONS_HVVILLAGESCHOOL"
	Decisions_HVVillageSchool.Desc = "TXT_KEY_DECISIONS_HVVILLAGESCHOOL_DESC"
	HookDecisionCivilizationIcon(Decisions_HVVillageSchool, "CIVILIZATION_TOUHOU_HV")
	Decisions_HVVillageSchool.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TOUHOU_HV) then
			return false, false
		end
		if load(pPlayer, "Decisions_HVVillageSchool") == true then
			Decisions_HVVillageSchool.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HVVILLAGESCHOOL_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(750 * iMod)
		Decisions_HVVillageSchool.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HVVILLAGESCHOOL_DESC", iCost)
			
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_EDUCATION)) then return true, false end


		local pCity = pPlayer:GetCapitalCity()
		if not(pCity) then return true, false end
		
		if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_LIBRARY)) and (pPlayer:GetGold() >= iCost) then
			return true, true
		else 
			return true, false
		end
	end
	)
	
	Decisions_HVVillageSchool.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(750 * iMod)
		local pCity = pPlayer:GetCapitalCity()
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_PUBLIC_SCHOOL, 1)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes["POLICY_HV_VILLAGE_SCHOOL"], true)
		save(pPlayer, "Decisions_HVVillageSchool", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TOUHOU_HV, "Decisions_HVVillageSchool", Decisions_HVVillageSchool)

--------------------------------------------------------------------------------------------------------------------------
-- Ningen no Sato: Encourage the Resource Trade
--------------------------------------------------------------------------------------------------------------------------

local Decisions_HVEncourageTrade = {}
	Decisions_HVEncourageTrade.Name = "TXT_KEY_DECISIONS_HVENCOURAGETRADE_NAME"
	Decisions_HVEncourageTrade.Desc = "TXT_KEY_DECISIONS_HVENCOURAGETRADE_DESC"
	Decisions_HVEncourageTrade.tLuxuries = {}
	for tResource in GameInfo.Resources("ResourceUsage = 0") do
		if (tResource.Description ~= "TXT_KEY_RESOURCE_MAGISTRATES") then 
			table.insert(Decisions_HVEncourageTrade.tLuxuries, tResource.ID)
			local sName = tResource.Description
			--print("Adding resource " .. sName .. " to the table")
		end
	end
	for tResource in GameInfo.Resources("ResourceUsage = 2") do
		table.insert(Decisions_HVEncourageTrade.tLuxuries, tResource.ID)
		local sName = tResource.Description
		--print("Adding resource " .. sName .. " to the table")
	end
	--HookDecisionCivilizationIcon(Decisions_HVEncourageTrade, "CIVILIZATION_TOUHOU_HV")
	Decisions_HVEncourageTrade.CanFunc = (

	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TOUHOU_HV then return false, false end
		
		--if load(pPlayer, "Decisions_HVEncourageTrade") == nil then
	--		save(pPlayer, "Decisions_HVEncourageTrade", 0)
	--	end
		--if load(pPlayer, "DominantHVResource") ~= nil then return false, false end
		
		local tDomResources = {}
		for iKey, iResource in ipairs(Decisions_HVEncourageTrade.tLuxuries) do
			local tResource = GameInfo.Resources[iResource]
			local sName = tResource.Description
			local iAvailable = pPlayer:GetNumResourceAvailable(iResource, false)
			local iTotal = pPlayer:GetNumResourceTotal(iResource, false)
			--print("Player has " .. iAvailable .. " copies of resource " .. sName .. " available, out of " .. iTotal .. " total")
			if (pPlayer:GetNumResourceTotal(iResource, false) > 2) then
				tDomResources[iResource] = true
			end
		end


		-------------------------------------
		-- Begin Decision Generation
		-------------------------------------				
		for iResource, _ in pairs(tDomResources) do
			local sKey = "Decisions_HVEncourageTrade" .. iResource
			local tResource = GameInfo.Resources[iResource]
		
			tTempDecisions[sKey] = {}
			tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HVENCOURAGETRADE_NAME", tResource.Description)
			tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HVENCOURAGETRADE_DESC", tResource.Description, tResource.IconString)
			tTempDecisions[sKey].Data1 = tResource
			tTempDecisions[sKey].Type = "Civilization"
			HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_TOUHOU_HV")
			tTempDecisions[sKey].CanFunc = (
			function(pPlayer, tResource)
				local iResource = tResource.ID
				local sKey = "Decisions_HVEncourageTrade" .. iResource
				local sName = tResource.Description
				local sIcon = tResource.IconString
				local domRes = load(pPlayer, "DominantHVResource")
				if load(pPlayer, "Decisions_HVEncourageTrade") == true then
					if domRes ~= nil then
						if domRes == iResource then
							tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HVENCOURAGETRADE_ENACTED_DESC", sIcon, sName)
							return false, false, true
						end
					end
					return false, false
				end
				--if tDomResources[iResource] then return false, false end
				--if load(pPlayer, "Decisions_HVEncourageTrade") >= 3 then return false, false end

				local iNumResource = pPlayer:GetNumResourceTotal(iResource, false)
				--print("Resource " .. sName .. " has " .. iNumResource)
				local iCost = math.ceil((150 + (50 * iNumResource)) * iMod)				
				tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HVENCOURAGETRADE_DESC", sIcon, sName, iCost)
				
				if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
				if (pPlayer:GetGold() < iCost) then return true, false end
							
				return true, true
			end
			)
			
			tTempDecisions[sKey].DoFunc = (
			function(pPlayer, tResource)
				local iResource = tResource.ID
				local iNumResource = pPlayer:GetNumResourceTotal(iResource, false)
				local iCost = math.ceil((350 + (50 * iNumResource)) * iMod)	
				
				pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
				pPlayer:ChangeGold(-iCost)
				save(pPlayer, "Decisions_HVEncourageTrade", true)
				save(pPlayer, "DominantHVResource", iResource)
				save(pPlayer, sKey, true)
			end
			)
		end
		-------------------------------------
		-- End Decision Generation
		-------------------------------------	
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TOUHOU_HV, "Decisions_HVEncourageTrade", Decisions_HVEncourageTrade)


function EncourageResourceTrade(iPlayer)
	local pPlayer = Players[iPlayer];
	if load(pPlayer, "Decisions_HVEncourageTrade") == true then
		local domRes = load(pPlayer, "DominantHVResource")
		local iResource = GameInfo.Resources[domRes]
		local iBonus = pPlayer:GetNumResourceTotal(iResource, false)
		print("Num of resource is " .. iBonus)
		local tIncomingTR =  pPlayer:GetTradeRoutesToYou()
		local iNumTR = #tIncomingTR
		print("Total TR = " .. iNumTR)
		local iGold = (((1 + iBonus) * iNumTR) * iMod)
		pPlayer:ChangeGold(iGold)
		if pPlayer:IsHuman() then
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_DECISIONS_HVENCOURAGETRADE_NOTIFICATION", iResource.IconString, iResource.Description, iGold))
		end
	end
end
GameEvents.PlayerDoTurn.Add(EncourageResourceTrade)
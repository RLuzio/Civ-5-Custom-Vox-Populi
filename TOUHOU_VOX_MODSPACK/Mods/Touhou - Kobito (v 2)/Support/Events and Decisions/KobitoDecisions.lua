-- Shinmyoumaru Unique Decisions

local CivilisationID = GameInfoTypes["CIVILIZATION_KOBITO"];
--------------------------------------------------------------
-- Decision 1
--------------------------------------------------------------
local Decisions_KobitoCollectMagic = {}
	Decisions_KobitoCollectMagic.Name = "TXT_KEY_DECISIONS_KOBITO_COLLECT_MAGIC"
	Decisions_KobitoCollectMagic.Desc = "TXT_KEY_DECISIONS_KOBITO_COLLECT_MAGIC_DESC"
	HookDecisionCivilizationIcon(Decisions_KobitoCollectMagic, "CIVILIZATION_KOBITO");
	Decisions_KobitoCollectMagic.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= CivilisationID) then
			return false, false
		end
		
		local iEra = load(pPlayer, "Decisions_KobitoCollectMagic");
		local iCurrentEra = pPlayer:GetCurrentEra();
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_KobitoCollectMagic", nil)
			else
				Decisions_KobitoCollectMagic.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KOBITO_COLLECT_MAGIC_ENACTED_DESC");
				return false, false, true
			end
		end
		
		local iGoldCost = math.ceil(500 * iMod);
		local iCulture = math.ceil(100 * iMod);
		local iScience = math.ceil(100 * iMod);
		local pCity = pPlayer:GetCapitalCity();

		Decisions_KobitoCollectMagic.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KOBITO_COLLECT_MAGIC_DESC", iGoldCost, iCulture, iScience)
		
		if pPlayer:GetNumCities() < 1												then return true, false end
		if pPlayer:GetGold() < iGoldCost											then return true, false end
		if pCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]) < 1	then return true, false	end
		if pCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]) > 3	then return true, false	end
		return true, true
	end
	)
	
	Decisions_KobitoCollectMagic.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(500 * iMod);
		local pCity = pPlayer:GetCapitalCity();
		local bNum = pCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]);
		if bNum == 1 then
			local iCulture = math.ceil(100 * iMod);
			pPlayer:ChangeJONSCulture(iCulture)
		elseif bNum == 2 then
			local iScience = math.ceil(100 * iMod);
			local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs();
			pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), iScience, pPlayer:GetID())
		elseif bNum == 3 then
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_GP"], 1);
		end
		pPlayer:ChangeGold(-iGoldCost);
		save(pPlayer, "Decisions_KobitoCollectMagic", pPlayer:GetCurrentEra());
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_KOBITO, "Decisions_KobitoCollectMagic", Decisions_KobitoCollectMagic);


--------------------------------------------------------------
-- Decision 2
--------------------------------------------------------------
local Decisions_ShiningNeedleSword = {}
	Decisions_ShiningNeedleSword.Name = "TXT_KEY_DECISIONS_SHINING_NEEDLE_SWORD"
	Decisions_ShiningNeedleSword.Desc = "TXT_KEY_DECISIONS_SHINING_NEEDLE_SWORD_DESC"
	HookDecisionCivilizationIcon(Decisions_ShiningNeedleSword, "CIVILIZATION_KOBITO");
	Decisions_ShiningNeedleSword.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= CivilisationID) then
			return false, false
		end
		
		if load(pPlayer, "Decisions_ShiningNeedleSword") == true then
			Decisions_ShiningNeedleSword.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SHINING_NEEDLE_SWORD_ENACTED_DESC");
			return false, false, true
		end
		
		local iCultureCost = math.ceil(150 * iMod);

		Decisions_ShiningNeedleSword.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SHINING_NEEDLE_SWORD_DESC", iCultureCost);
		
		if pPlayer:GetNumCities() < 1												then return true, false end
		if pPlayer:GetJONSCulture() < iCultureCost 									then return true, false end
		if not Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_STEEL)			then return true, false end
		return true, true
	end
	)
	
	Decisions_ShiningNeedleSword.DoFunc = (
	function(pPlayer)
		InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_STINGING_SWORDSMAN, 1);
		pPlayer:SetNumFreePolicies(1);
		pPlayer:SetNumFreePolicies(0);
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_SHINING_NEEDLE_SWORD, true);
		local iCultureCost = math.ceil(150 * iMod);
		pPlayer:ChangeJONSCulture(-iCultureCost);
		save(pPlayer, "Decisions_ShiningNeedleSword", true);
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_KOBITO, "Decisions_ShiningNeedleSword", Decisions_ShiningNeedleSword);
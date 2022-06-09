-- Kobito function Util

function KobitoFreeSP ( pPlayer )
	local pCapitalCity = pPlayer:GetCapitalCity();
	local iNum = pCapitalCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_01"]);
	if iNum > 0 then
		pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_01"], 0);
	end
	pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_01"], 1);
	pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"], 1);
end

function KobitoFreeTc ( pPlayer )
	local pCapitalCity = pPlayer:GetCapitalCity();
	local iNum = pCapitalCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_02"]);
	if iNum > 0 then
		pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_02"], 0);
	end
	pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_02"], 1);
	pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"], 2);
end

function KobitoFreeGP ( pPlayer )
	local pCapitalCity = pPlayer:GetCapitalCity();
	local iNum = pCapitalCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_03"]);
	if iNum > 0 then
		pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_03"], 0);
	end
	pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_03"], 1);
	pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"], 3);
end

function KobitoCheckDummyBuilding ( pPlayer, iLabel )
	local pCapitalCity = pPlayer:GetCapitalCity();
	if not pCapitalCity then
		return;
	end
	if pCapitalCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]) == 0 then
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]) then
				local iNum = pCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]);
				pCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"], iNum);
				pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"], 0);
			end
		end
	end
	if iLabel == 1 then
		return pCapitalCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]) == 1
	elseif iLabel == 2 then
		return pCapitalCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]) == 2
	elseif iLabel == 3 then
		return pCapitalCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]) == 3
	else
		return true;
	end
end

function KobitoActivateBonus( iLabel, pPlayer )
	if pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOBITO"] then
		if not pPlayer:GetCapitalCity() then
			return;
		end
		if iLabel == 1 then
			KobitoFreeSP(pPlayer);
		elseif iLabel == 2 then	
			if pPlayer:IsHuman() then
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_FREE_TECH, Locale.ConvertTextKey("TXT_KEY_CHOOSE_FREE_TECH_TT"), Locale.ConvertTextKey("TXT_KEY_CHOOSE_FREE_TECH"));
			end
			KobitoFreeTc(pPlayer);
		elseif iLabel == 3 then
			KobitoFreeGP(pPlayer);
		else
			return;
		end
	end
end
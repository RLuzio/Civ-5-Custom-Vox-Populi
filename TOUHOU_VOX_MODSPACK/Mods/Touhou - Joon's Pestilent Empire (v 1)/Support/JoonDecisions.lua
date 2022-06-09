-- JoonDecisions
-- Author: Igniszath
-- DateCreated: 2/3/2019 1:09:00 PM
--------------------------------------------------------------
function TouhouPestilenceGetNumLiveCivs()
	local iCount = 0
	for iPlayer, pPlayer in pairs(Players) do
		if pPlayer:IsAlive() then
			if not pPlayer:IsMinorCiv() and not pPlayer:IsBarbarian() then
				iCount = iCount + 1
			end
		end
	end
	return iCount
end

function TouhouPestilenceHasMetAll(pSubject)
	local pTeam = Teams[pSubject:GetTeam()]
	for iPlayer, pPlayer in pairs(Players) do
		if pPlayer:IsAlive() then
			if not pPlayer:IsMinorCiv() and not pPlayer:IsBarbarian() and not pTeam:IsHasMet(pPlayer:GetTeam()) then
				return false
			end
		end
	end
	return true
end

function TouhouPestilenceAllGiveGold(pSubject)
	for iPlayer, pPlayer in pairs(Players) do
		if pPlayer:IsAlive() then
			if not pPlayer:IsMinorCiv() and not pPlayer:IsBarbarian() and pPlayer ~= pSubject then
				local iGold = pPlayer:GetGold()
				pPlayer:ChangeGold(-iGold)
				pSubject:ChangeGold(iGold)

				sNotificationString = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_WELCOME_TEXT")
				sNotificationTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_WELCOME_TITLE")
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sNotificationString, sNotificationTitle, -1, -1)
			end
		end
	end
end

local Decisions_PestilenceLoanShark = {}
    Decisions_PestilenceLoanShark.Name = "TXT_KEY_DECISIONS_PESTILENCE_LOAN_SHARK"
	Decisions_PestilenceLoanShark.Desc = "TXT_KEY_DECISIONS_PESTILENCE_LOAN_SHARK_DESC"
	HookDecisionCivilizationIcon(Decisions_PestilenceLoanShark, "CIVILIZATION_TOUHOU_PESTILENCE")
	Decisions_PestilenceLoanShark.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TOUHOU_PESTILENCE then return false, false end
		if load(pPlayer, "Decisions_PestilenceLoanShark") == true then
			Decisions_PestilenceLoanShark.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_PESTILENCE_LOAN_SHARK_ENACTED_DESC")
			return false, false, true
		end
		Decisions_PestilenceLoanShark.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_PESTILENCE_LOAN_SHARK_DESC")
		local iTech = GameInfoTypes.TECH_ECONOMICS
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		if Teams[pPlayer:GetTeam()]:IsHasTech(iTech) then
			return true, true
		else
			return true, false
		end
		
		return true, true		
	end
	)
	
	Decisions_PestilenceLoanShark.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_LOAN_SHARK_DUMMY, true)
		save(pPlayer, "Decisions_PestilenceLoanShark", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TOUHOU_PESTILENCE, "Decisions_PestilenceLoanShark", Decisions_PestilenceLoanShark)

local Decisions_PestilenceWelcome = {}
	Decisions_PestilenceWelcome.Name = "TXT_KEY_DECISIONS_PESTILENCE_WELCOME"
	Decisions_PestilenceWelcome.Desc = "TXT_KEY_DECISIONS_PESTILENCE_WELCOME_DESC"
	HookDecisionCivilizationIcon(Decisions_PestilenceWelcome, "CIVILIZATION_TOUHOU_PESTILENCE")
	Decisions_PestilenceWelcome.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TOUHOU_PESTILENCE then return false, false end
		if load(pPlayer, "Decisions_PestilenceWelcome") == true then
			Decisions_PestilenceWelcome.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_PESTILENCE_WELCOME_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(150 * iMod * (TouhouPestilenceGetNumLiveCivs() - 1))
		Decisions_PestilenceWelcome.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_PESTILENCE_WELCOME_DESC", iCost)
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end
		if pPlayer:GetCurrentEra() > GameInfoTypes.ERA_INDUSTRIAL then return false, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if not (TouhouPestilenceHasMetAll(pPlayer)) then return true, false end
		return true, true
	end
	)
	
	Decisions_PestilenceWelcome.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(150 * iMod * (TouhouPestilenceGetNumLiveCivs() - 1))
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		TouhouPestilenceAllGiveGold(pPlayer)
		save(pPlayer, "Decisions_PestilenceWelcome", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TOUHOU_PESTILENCE, "Decisions_PestilenceWelcome", Decisions_PestilenceWelcome)
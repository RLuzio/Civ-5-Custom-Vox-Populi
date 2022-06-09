-- RaikoLua
-- Author: Igniszath
-- DateCreated: 8/6/2017 2:26:12 PM
--------------------------------------------------------------
local iRequiredCiv = GameInfoTypes.CIVILIZATION_TSUKUMOGAMI
local iTraitPromotion = GameInfoTypes.PROMOTION_PRISTINE_BEATS
local iKarakasaPromotion = GameInfoTypes.PROMOTION_SURPRISE
local iInvisiblePromotion = GameInfoTypes.PROMOTION_HIDING
local iMenreikiPromotion = GameInfoTypes.PROMOTION_LOST_EMOTION
local iAngerPromotion = GameInfoTypes.PROMOTION_MENREIKI_ANGER
local iSadnessPromotion = GameInfoTypes.PROMOTION_MENREIKI_SADNESS
local iHappinessPromotion = GameInfoTypes.PROMOTION_MENREIKI_HAPPINESS


print("RaikoLua successfully loaded.")
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "Tsukumogami";

-------------------------------------------------------------------------------------------------------------------------
-- PristineBeats
-------------------------------------------------------------------------------------------------------------------------

function TsukumogamiTrait(iPlayer)
	local pPlayer = Players[iPlayer]
	local iGameTurns = Game.GetGameTurn()
	if (pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iRequiredCiv) then
		for pUnit in pPlayer:Units() do
			if iGameTurns % 4 == 0 and iGameTurns ~= 0 then
				pUnit:SetHasPromotion(iTraitPromotion, true)
			else
				pUnit:SetHasPromotion(iTraitPromotion, false)
			end
		end
	elseif (pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() ~= iRequiredCiv) then
		for pUnit in pPlayer:Units() do
			pUnit:SetHasPromotion(iTraitPromotion, false)
		end
	end
end
GameEvents.PlayerDoTurn.Add(TsukumogamiTrait)

function TsukumogamiTraitIndiv(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local iGameTurns = Game.GetGameTurn()
	if (pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iRequiredCiv) then
		if pPlayer:GetUnitByID(iUnit) ~= nil then
			local pUnit = pPlayer:GetUnitByID(iUnit);
			if iGameTurns % 4 == 0 and iGameTurns ~= 0 then
				pUnit:SetHasPromotion(iTraitPromotion, true)
			end
		end
	end
end
Events.SerialEventUnitCreated.Add(TsukumogamiTraitIndiv)

function TsukumogamiExpendBonus(iPlayer, iUnitType, iUnitTypeVMC)
	if iUnitTypeVMC ~= nil then -- I need to do this because the game event input values was changed with VMC
		iUnitType = iUnitTypeVMC
	end
	local UnitClass = GameInfo.Units[iUnitType].Class
    local pPlayer = Players[iPlayer];
    if pPlayer:IsEverAlive() then
		if pPlayer:GetCivilizationType() == iRequiredCiv then
			local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
			if pPlayer:GetCurrentResearch() == -1 then --If player is currently not researching, give science on their next turn
				if load(pPlayer, "TsukumogamiExpendOverflow") then
					iOverflow = load(pPlayer, "TsukumogamiExpendOverflow")
				else
					iOverflow = 0
				end
				if UnitClass == "UNITCLASS_WRITER" or UnitClass == "UNITCLASS_ARTIST" or UnitClass == "UNITCLASS_MUSICIAN" then
					save(pPlayer, "TsukumogamiExpendOverflow", iOverflow + (pPlayer:GetScience() * 2))
				else
					save(pPlayer, "TsukumogamiExpendOverflow", iOverflow + pPlayer:GetScience())
				end
			else
				if UnitClass == "UNITCLASS_WRITER" or UnitClass == "UNITCLASS_ARTIST" or UnitClass == "UNITCLASS_MUSICIAN" then
					pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), pPlayer:GetScience() * 2, iPlayer)
				else
					pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), pPlayer:GetScience(), iPlayer)
				end
			end
		end
	end
end
GameEvents.GreatPersonExpended.Add(TsukumogamiExpendBonus)

function TsukumogamiExpendOverflow(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iRequiredCiv) then
		if load(pPlayer, "TsukumogamiExpendOverflow") then
			iOverflow = load(pPlayer, "TsukumogamiExpendOverflow")
		else
			iOverflow = 0
		end
		if iOverflow == 0 then return end --Speeds up the process
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		if pPlayer:GetCurrentResearch() ~= -1 then -- If player is currently researching something, give overflow
			pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), iOverflow, iPlayer)
			save(pPlayer, "TsukumogamiExpendOverflow", 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(TsukumogamiExpendOverflow)

-------------------------------------------------------------------------------------------------------------------------
-- KarakasaObake
-------------------------------------------------------------------------------------------------------------------------

function KarakasaObakeInvis(player, unit, x, y)
	local cUnit = Players[player]:GetUnitByID(unit);
	if cUnit:IsHasPromotion(iKarakasaPromotion) then
		if Map.GetPlot(x,y) ~= nil then
			local cPlot = Map.GetPlot(x,y);
			if cPlot:GetFeatureType() == GameInfoTypes.FEATURE_FOREST or cPlot:GetFeatureType() == GameInfoTypes.FEATURE_JUNGLE then
				if not cUnit:IsHasPromotion(iInvisiblePromotion) then
					cUnit:SetHasPromotion(iInvisiblePromotion, true);
				end
			else
				if cUnit:IsHasPromotion(iInvisiblePromotion) then
					cUnit:SetHasPromotion(iInvisiblePromotion, false);
				end
			end
		end
	else
		cUnit:SetHasPromotion(iInvisiblePromotion, false)
	end
end
GameEvents.UnitSetXY.Add(KarakasaObakeInvis)

function KarakasaObakeInvisCheck(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(iKarakasaPromotion) then
			local x = pUnit:GetX();
			local y = pUnit:GetY();
			if Map.GetPlot(x,y) ~= nil then
				local pPlot = Map.GetPlot(x,y);
				if pPlot:GetFeatureType() == GameInfoTypes.FEATURE_FOREST or pPlot:GetFeatureType() == GameInfoTypes.FEATURE_JUNGLE then
					if not pUnit:IsHasPromotion(iInvisiblePromotion) then
						pUnit:SetHasPromotion(iInvisiblePromotion, true);
					end
				else
					if pUnit:IsHasPromotion(iInvisiblePromotion) then
						pUnit:SetHasPromotion(iInvisiblePromotion, false);
					end
				end
			end
		else
			pUnit:SetHasPromotion(iInvisiblePromotion, false)
		end
	end
end
GameEvents.PlayerDoTurn.Add(KarakasaObakeInvisCheck)

-------------------------------------------------------------------------------------------------------------------------
-- Menreiki
-------------------------------------------------------------------------------------------------------------------------
function MenreikiPromotion(iPlayer)
	local pPlayer = Players[iPlayer]
	local iRand = Game.Rand(300, "Rolling for emotion")
	if pPlayer:IsEverAlive() then
		if load(pPlayer, "MenreikiPromotion") == Game.GetGameTurn() then return end
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(iAngerPromotion) then
				pUnit:SetHasPromotion(iAngerPromotion, false)
			end
			if pUnit:IsHasPromotion(iSadnessPromotion) then
				pUnit:SetHasPromotion(iSadnessPromotion, false)
			end
			if pUnit:IsHasPromotion(iHappinessPromotion) then
				pUnit:SetHasPromotion(iHappinessPromotion, false)
				pUnit:SetMoves(pUnit:MaxMoves())
			end
			if pUnit:IsHasPromotion(iMenreikiPromotion) then
				if iRand < 100 then
					pUnit:SetHasPromotion(iAngerPromotion, true)
				elseif iRand < 200 and iRand >= 100 then
					pUnit:SetHasPromotion(iSadnessPromotion, true)
				else
					pUnit:SetHasPromotion(iHappinessPromotion, true)
					pUnit:SetMoves(pUnit:MaxMoves())
				end
			end
		end
	end
	save(pPlayer, "MenreikiPromotion", Game.GetGameTurn())
end
GameEvents.PlayerDoTurn.Add(MenreikiPromotion)

-------------------------------------------------------------------------------------------------------------------------
-- EventsandDecisionsRewards
-------------------------------------------------------------------------------------------------------------------------

function TsukumogamiEventRewards(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:HasPolicy(GameInfoTypes.POLICY_SEARCHED_FOR_AMANOJAKU_DUMMY) then
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_WANTED_AMANOJAKU_DUMMY, 1)
		end
	else
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_WANTED_AMANOJAKU_DUMMY, 0)
		end
	end

	local iScore = pPlayer:GetScore()
	local bHighestScore = true

	for iCiv = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local pCiv = Players[iCiv]
		if (pCiv:IsAlive()) then
			if (pCiv:GetScore() > iScore) then
				bHighestScore = false
				break
			end
		end
	end

	if pPlayer:HasPolicy(GameInfoTypes.POLICY_AMANOJAKU_ASYLUM_DUMMY) and not bHighestScore then
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_ACCEPTED_AMANOJAKU_DUMMY, 1)
		end
		for pUnit in pPlayer:Units() do
			pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_REVERSE_IDEOLOGY, true)
		end
	else
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_ACCEPTED_AMANOJAKU_DUMMY, 0)
		end
		for pUnit in pPlayer:Units() do
			pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_REVERSE_IDEOLOGY, false)
		end
	end
end
GameEvents.PlayerDoTurn.Add(TsukumogamiEventRewards)

function TsukumogamiDecisionRewards(iPlayer, x, y, improvement)
	local pPlayer = Players[iPlayer]
	if improvement == GameInfoTypes.IMPROVEMENT_ARCHAEOLOGICAL_DIG and pPlayer:HasPolicy(GameInfoTypes.POLICY_SEARCH_ARTIFACTS_DUMMY) then
		local pCity = pPlayer:GetCapitalCity()
		pCity:ChangePopulation(1, true)
	end
end

GameEvents.BuildFinished.Add(TsukumogamiDecisionRewards)
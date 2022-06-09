-- MikoLua
-- Author: user
-- DateCreated: 7/25/2015 9:46:10 AM
--------------------------------------------------------------

include("MischaIteratingPlotsFunctions.lua")

local iCiv = GameInfoTypes.CIVILIZATION_BM_TH_HAKUREI_SHRINE
local iMikoDefense = GameInfoTypes.BUILDING_BM_TH_HS_MIKO_DEFENSE_DUMMY
local iBranchShrineBonus = GameInfoTypes.BUILDING_BM_TH_HS_BRANCH_SHRINE_BONUS_DUMMY
local iDonationBoxBonus = GameInfoTypes.BUILDING_BM_TH_HS_DONATION_BOX_BONUS_DUMMY
local iHakureiPolicy = GameInfoTypes.POLICY_HAKUREI_YOUKAI_HUNTER
local iCargo = GameInfoTypes.UNIT_CARGO_SHIP
local iCaravan = GameInfoTypes.UNIT_CARAVAN
local iImprovementBranchShrine = GameInfoTypes.IMPROVEMENT_BRANCH_SHRINE
local iImprovementHolySite = GameInfoTypes.IMPROVEMENT_HOLY_SITE
local iShrineFactor = 2
local iBuildingGrandTempleClass = GameInfo.BuildingClasses.BUILDINGCLASS_GRAND_TEMPLE.ID
local iBuildingPietyFinisherDummyClass = GameInfo.BuildingClasses.BUILDINGCLASS_BM_TH_HS_PIETY_FINISHER_DUMMY.ID
local iBuildingPietyFinisherDummy = GameInfoTypes.BUILDING_BM_TH_HS_PIETY_FINISHER_DUMMY

local iPietyPolicy1 = GameInfoTypes.POLICY_ORGANIZED_RELIGION
local iPietyPolicy2 = GameInfoTypes.POLICY_REFORMATION
local iPietyBranch = GameInfo.PolicyBranchTypes["POLICY_BRANCH_PIETY"].ID

local iHakureiLevelBonus4Promotion = GameInfoTypes.PROMOTION_HAKUREI_LEVEL_BONUS_4
local iHakureiLevelBonus3Promotion = GameInfoTypes.PROMOTION_HAKUREI_LEVEL_BONUS_3
local iHakureiLevelBonus2Promotion = GameInfoTypes.PROMOTION_HAKUREI_LEVEL_BONUS_2
local iHakureiLevelBonus1Promotion = GameInfoTypes.PROMOTION_HAKUREI_LEVEL_BONUS_1
local iHakureiMikoPromotion = GameInfoTypes.PROMOTION_HAKUREI_MIKO
local iYinYangOrbPromotion = GameInfoTypes.PROMOTION_YIN_YANG_ORB
local iHakureiMikoBomb1Promotion = GameInfoTypes.PROMOTION_HAKUREI_MIKO_BOMB_1
local iHakureiMikoBomb2Promotion = GameInfoTypes.PROMOTION_HAKUREI_MIKO_BOMB_2
local iHakureiMikoBomb3Promotion = GameInfoTypes.PROMOTION_HAKUREI_MIKO_BOMB_3
local iHakureiMikoBomb4Promotion = GameInfoTypes.PROMOTION_HAKUREI_MIKO_BOMB_4

-------------------------------------------------------------------------------------------------------------------------
-- GetStrongestMilitaryUnit
-------------------------------------------------------------------------------------------------------------------------
function GetStrongestMilitaryUnitStrength(pPlayer, bIgnoreResources, ...)
	local tUnit = {["Combat"] = 0}
	for iKey, sCombatType in pairs(arg) do
		for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
			if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
				tUnit = row
			end
		end
	end
	return tUnit.Combat
end

function HakureiMikoStrength(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:IsAlive()) then
		for pUnit in pPlayer:Units() do
			if (pUnit:IsHasPromotion(iHakureiMikoPromotion)) then
				local iBaseCombatStrength = GetStrongestMilitaryUnitStrength(pPlayer, false, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
				local iModifiedCombatStrength = math.ceil(iBaseCombatStrength * 1.25)
				pUnit:SetBaseCombatStrength(iModifiedCombatStrength)
			end
		end		
	end
end
GameEvents.PlayerAdoptPolicy.Add(HakureiMikoStrength);
GameEvents.PlayerDoTurn.Add(HakureiMikoStrength);

function HakureiMikoStrength2(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
		if pPlayer:GetUnitByID(iUnit) ~= nil then
			pUnit = pPlayer:GetUnitByID(iUnit);
 			if (pUnit:IsHasPromotion(iHakureiMikoPromotion)) then
				local iBaseCombatStrength = GetStrongestMilitaryUnitStrength(pPlayer, false, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
				local iModifiedCombatStrength = math.ceil(iBaseCombatStrength * 1.25)
				pUnit:SetBaseCombatStrength(iModifiedCombatStrength)
			end
        end
    end
end
Events.SerialEventUnitCreated.Add(HakureiMikoStrength2)

function HakureiMikoBombPolicies(iPlayer, iPolicy)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
		print("iPolicy is " .. iPolicy .. " and iPietyPolicyID is " .. iPietyPolicy1)
		if (iPolicy == iPietyPolicy1) then
		print("Player selected Piety 1")
			for pUnit in pPlayer:Units() do
				if (pUnit:IsHasPromotion(iYinYangOrbPromotion) and not pUnit:IsHasPromotion(iHakureiMikoBomb1Promotion)) then
					pUnit:SetHasPromotion(iHakureiMikoBomb1Promotion, true)
					print("Adding bomb")
				end
			end
		end
		if (iPolicy == iPietyPolicy2) then
		print("Player selected Piety 2")
		for pUnit in pPlayer:Units() do
				if (pUnit:IsHasPromotion(iYinYangOrbPromotion) and not pUnit:IsHasPromotion(iHakureiMikoBomb2Promotion)) then
					pUnit:SetHasPromotion(iHakureiMikoBomb2Promotion, true)
					print("Adding bomb.")
				end
			end
		end
    end
end
GameEvents.PlayerAdoptPolicy.Add(HakureiMikoBombPolicies);

function HakureiMikoBombBuildings(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if (buildingType == GameInfoTypes["BUILDING_BM_TH_HS_HONDEN"]) then
	print("Honden completed")
		local pPlayer = Players[ownerID];
		for pUnit in pPlayer:Units() do
			if (pUnit:IsHasPromotion(iYinYangOrbPromotion) and not pUnit:IsHasPromotion(iHakureiMikoBomb3Promotion)) then
				pUnit:SetHasPromotion(iHakureiMikoBomb3Promotion, true)
				print("Adding bomb.")
			end
		end
	end
end
GameEvents.CityConstructed.Add(HakureiMikoBombBuildings)

function HakureiMikoPromotions(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
		if pPlayer:GetUnitByID(iUnit) ~= nil then
			pUnit = pPlayer:GetUnitByID(iUnit);
			if pPlayer:GetCivilizationType() == iCiv then
				local iUnitLevel = pUnit:GetLevel()
				if iUnitLevel > 1 then
					pUnit:SetHasPromotion(iHakureiLevelBonus1Promotion, true)
				else
					pUnit:SetHasPromotion(iHakureiLevelBonus1Promotion, false)
				end
				if iUnitLevel > 2 then
					pUnit:SetHasPromotion(iHakureiLevelBonus2Promotion, true)
				else
					pUnit:SetHasPromotion(iHakureiLevelBonus2Promotion, false)
				end
				if iUnitLevel > 3 then
					pUnit:SetHasPromotion(iHakureiLevelBonus3Promotion, true)
				else
					pUnit:SetHasPromotion(iHakureiLevelBonus3Promotion, false)
				end
				if iUnitLevel > 4 then
					pUnit:SetHasPromotion(iHakureiLevelBonus4Promotion, true)
				else
					pUnit:SetHasPromotion(iHakureiLevelBonus4Promotion, false)
				end
			end
 			if (pUnit:IsHasPromotion(iHakureiMikoPromotion) and not pUnit:IsHasPromotion(iYinYangOrbPromotion)) then
				pUnit:SetHasPromotion(iYinYangOrbPromotion, true)
				if (pPlayer:HasPolicy(iPietyPolicy1)) then
					pUnit:SetHasPromotion(iHakureiMikoBomb1Promotion, true)
				end
				if (pPlayer:HasPolicy(iPietyPolicy2)) then
					pUnit:SetHasPromotion(iHakureiMikoBomb2Promotion, true)
				end
				if (pPlayer:GetBuildingClassCount(iBuildingGrandTempleClass) > 0) then
					pUnit:SetHasPromotion(iHakureiMikoBomb3Promotion, true)
				end
			end
        end
    end
end
Events.SerialEventUnitCreated.Add(HakureiMikoPromotions)

function HakureiBombEffects(iPlayer)
	local pPlayer = Players[iPlayer]
	local teamID = pPlayer:GetTeam()
	local pPlayerTeam = Teams[teamID]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	for pUnit in pPlayer:Units() do
		bBomb = pUnit:IsHasPromotion(iHakureiMikoBomb1Promotion) or pUnit:IsHasPromotion(iHakureiMikoBomb2Promotion) or pUnit:IsHasPromotion(iHakureiMikoBomb3Promotion) or pUnit:IsHasPromotion(iHakureiMikoBomb4Promotion)
		if bBomb and (pUnit:GetDamage() > 75) then
			pUnit:ChangeDamage(-50)
			local pPlot = pUnit:GetPlot()	
			for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
					local loopUnit = pAdjacentPlot:GetUnit(iVal)
					if loopUnit:GetOwner() ~= iPlayer then
						local loopUnitOwner = loopUnit:GetOwner()
						local otherPlayer = Players[loopUnitOwner]
						local otherTeamID = otherPlayer:GetTeam()
						if pPlayerTeam:IsAtWar(otherTeamID) then
							loopUnit:ChangeDamage(50)
						end
					end
				end
			end
			if (pUnit:IsHasPromotion(iHakureiMikoBomb3Promotion)) then
				pUnit:SetHasPromotion(iHakureiMikoBomb3Promotion, false)
			else
				if (pUnit:IsHasPromotion(iHakureiMikoBomb2Promotion)) then
					pUnit:SetHasPromotion(iHakureiMikoBomb2Promotion, false)
				else
					if (pUnit:IsHasPromotion(iHakureiMikoBomb1Promotion)) then
						pUnit:SetHasPromotion(iHakureiMikoBomb1Promotion, false)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(HakureiBombEffects)

function HakureiUnitDestroyed(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)

	local pPlayer = Players[iPlayer]
	local teamID = pPlayer:GetTeam()
	local pPlayerTeam = Teams[teamID]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	
	-- Must have been killed by another Player
	if iPlayer == iByPlayer then return end
	if iByPlayer == -1 then return end
	
	bBomb = pUnit:IsHasPromotion(iHakureiMikoBomb1Promotion) or pUnit:IsHasPromotion(iHakureiMikoBomb2Promotion) or pUnit:IsHasPromotion(iHakureiMikoBomb3Promotion)
	if (bBomb) then
		local pPlot = pUnit:GetPlot()	
		for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
			for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
				local loopUnit = pAdjacentPlot:GetUnit(iVal)
				if loopUnit:GetOwner() ~= iPlayer then
					local loopUnitOwner = loopUnit:GetOwner()
					local otherPlayer = Players[loopUnitOwner]
					local otherTeamID = otherPlayer:GetTeam()
					if pPlayerTeam:IsAtWar(otherTeamID) then
						loopUnit:ChangeDamage(25)
					end
				end
			end
		end
		pUnit:SetDamage(75)
		local pUnitType = pUnit:GetUnitType()
		local nUnit = pPlayer:InitUnit(pUnitType, pPlot:GetX(), pPlot:GetY())
		nUnit:Convert(pUnit)
		nUnit:JumpToNearestValidPlot()
		if (nUnit:IsHasPromotion(iHakureiMikoBomb3Promotion)) then
			nUnit:SetHasPromotion(iHakureiMikoBomb3Promotion, false)
		else
			if (nUnit:IsHasPromotion(iHakureiMikoBomb2Promotion)) then
				nUnit:SetHasPromotion(iHakureiMikoBomb2Promotion, false)
			else
				if (nUnit:IsHasPromotion(iHakureiMikoBomb1Promotion)) then
					nUnit:SetHasPromotion(iHakureiMikoBomb1Promotion, false)
				end
			end
		end
	else
		if pPlayer:GetCivilizationType() == iCiv then
			local iDeadUnitLevel = pUnit:GetLevel() - 1
			if iDeadUnitLevel > 4 then
				iDeadUnitLevel = 4
			end
			local iDeadUnitXP = iDeadUnitLevel * 5
			local pPlot = pUnit:GetPlot()	
			for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
					local loopUnit = pAdjacentPlot:GetUnit(iVal)
					if loopUnit:GetOwner() == iPlayer then
						loopUnit:ChangeExperience(iDeadUnitXP)
					end
				end
			end
		end
	end
end
GameEvents.UnitPrekill.Add(HakureiUnitDestroyed)

function HakureiUnitLevelBonus(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iCiv then
		for pUnit in pPlayer:Units() do
			local iUnitLevel = pUnit:GetLevel()
			if iUnitLevel > 1 then
				pUnit:SetHasPromotion(iHakureiLevelBonus1Promotion, true)
			else
				pUnit:SetHasPromotion(iHakureiLevelBonus1Promotion, false)
			end
			if iUnitLevel > 2 then
				pUnit:SetHasPromotion(iHakureiLevelBonus2Promotion, true)
			else
				pUnit:SetHasPromotion(iHakureiLevelBonus2Promotion, false)
			end
			if iUnitLevel > 3 then
				pUnit:SetHasPromotion(iHakureiLevelBonus3Promotion, true)
			else
				pUnit:SetHasPromotion(iHakureiLevelBonus3Promotion, false)
			end
			if iUnitLevel > 4 then
				pUnit:SetHasPromotion(iHakureiLevelBonus4Promotion, true)
			else
				pUnit:SetHasPromotion(iHakureiLevelBonus4Promotion, false)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(HakureiUnitLevelBonus)

--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetNumIncomingTradeRoutes
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetNumIncomingTradeRoutes(playerID, city)
	local player = Players[playerID]
	local tradeRoutes = player:GetTradeRoutes()
	local numIncomingTRs = 0
	for i, v in ipairs(tradeRoutes) do
		local originatingCity = v.FromCity
		local targetCity = v.ToCity
		if targetCity == city then
			numIncomingTRs = numIncomingTRs + 1
		end
	end
	
	return numIncomingTRs
end

function HakureiDonations(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iCiv then
		for pCity in pPlayer:Cities() do
			if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_BM_TH_HS_DONATION_BOX)) then
				local iNumTradeRoutes = JFD_GetNumIncomingTradeRoutes(iPlayer, pCity)
				print("Num Trade Routes: " .. iNumTradeRoutes)
				local iNumFollowers = 0
				if pPlayer:GetCapitalCity():GetReligiousMajority() > 0 then
					iNumFollowers = math.floor(pCity:GetNumFollowers(pPlayer:GetCapitalCity():GetReligiousMajority()))
				end
				print("Num Trade Routes: " .. iNumTradeRoutes .. ", Num Followers: " .. iNumFollowers)
				local iTotalDonations = iNumTradeRoutes + iNumFollowers
				pCity:SetNumRealBuilding(iDonationBoxBonus, iTotalDonations);	
				pPlayer:ChangeCombatExperience(iTotalDonations)
			else
				pCity:SetNumRealBuilding(iDonationBoxBonus, 0);	
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(HakureiDonations)


function HakureiPolicyInit(iPlayer, iX, iY)
	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iCiv then
		if not pPlayer:HasPolicy(iHakureiPolicy) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iHakureiPolicy, true)
			print("Activating Hakurei policy")
		end
	end
end
GameEvents.PlayerCityFounded.Add(HakureiPolicyInit)

function CheckHSImprovements (iHexX, iHexY, iContinent1, iContinent2)
	local pPlot = Map.GetPlot(ToGridFromHex(iHexX, iHexY))
	local ImpID = pPlot:GetImprovementType()
	local Owner = pPlot:GetOwner()
	local pPlayer = Players[Owner];
	if (pPlayer) then
		if (ImpID == iImprovementHolySite and pPlayer:GetCivilizationType() == iCiv) then
			pPlot:SetImprovementType(iImprovementBranchShrine)
		end
	end
end
Events.SerialEventImprovementCreated.Add(CheckHSImprovements);

function BranchShrineTRBonus(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iCiv then
		local iNumShrines = 0
		for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
			local mPlayer = Players[mPlayer];
			if (mPlayer:IsAlive()) then
				for mUnit in mPlayer:Units() do			
					if mUnit:GetUnitType() == iCargo or mUnit:GetUnitType() == iCaravan then
						local pPlot = mUnit:GetPlot()
						local iRadius = 2
						for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, iRadius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
							local iImprovement = pAdjacentPlot:GetImprovementType()
							local iOwner = pAdjacentPlot:GetOwner()
							if (iImprovement == iImprovementBranchShrine) and (iOwner == iPlayer) then
								iNumShrines = iNumShrines + 1
							end		
						end
					end
				end
			end
		end
		print("Number of shrines found near trade units: " .. iNumShrines)
		local iShrineBonus = iNumShrines * iShrineFactor
		pPlayer:ChangeGold(iShrineBonus)
		pPlayer:ChangeFaith(iShrineBonus)
		if pPlayer:IsHuman() and (iShrineBonus > 0) then
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_BM_TH_HS_BRANCH_SHRINE_NOTIFICATION", iShrineBonus, iShrineBonus))
		end

	end
end
GameEvents.PlayerDoTurn.Add(BranchShrineTRBonus)

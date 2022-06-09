-- TenmaLua
-- Author: Igniszath
-- DateCreated: 12/10/2016 11:33:37 AM
--------------------------------------------------------------
local iRequiredCiv = GameInfoTypes.CIVILIZATION_TOUHOU_TENGU

local iTraitPromotion = GameInfoTypes.PROMOTION_TRAIT_TOUHOU_TENGU
local iTengukakushi = GameInfoTypes.PROMOTION_TENGUKAKUSHI

local iCrowTengu = GameInfoTypes.PROMOTION_CROW_TENGU
local iCrowTenguBonus = GameInfoTypes.PROMOTION_CROW_TENGU_BONUS
local iCrowTenguBonusGP = GameInfoTypes.PROMOTION_CROW_TENGU_BONUS_GP
local iWhiteWolfTengu = GameInfoTypes.PROMOTION_WHITE_WOLF_TENGU
local iWhiteWolfTenguBonusGP = GameInfoTypes.PROMOTION_WHITE_WOLF_TENGU_BONUS_GP
local iYamabushiTengu = GameInfoTypes.PROMOTION_YAMABUSHI_TENGU
local iLongNoseTengu = GameInfoTypes.PROMOTION_LONG_NOSE_TENGU
local iGreatTengu = GameInfoTypes.PROMOTION_GREAT_TENGU

local iReporterJournalist = GameInfoTypes.UNIT_REPORTER_JOURNALIST
local iNewspaperOffice = GameInfoTypes.BUILDING_NEWSPAPER_OFFICE
local iHappinessBoost = GameInfoTypes.BUILDING_SCOOP_HAPPINESS_BOOST_DUMMY
local iNewspaperOfficeUpgrade = GameInfoTypes.BUILDING_NEWSPAPER_OFFICE_DUMMY

local iMelee = GameInfoTypes.UNITCOMBAT_MELEE
local iArcher = GameInfoTypes.UNITCOMBAT_ARCHER
local iRecon = GameInfoTypes.UNITCOMBAT_RECON
local iGun = GameInfoTypes.UNITCOMBAT_GUN
local iMounted = GameInfoTypes.UNITCOMBAT_MOUNTED
local iSiege = GameInfoTypes.UNITCOMBAT_SIEGE
local iArmor = GameInfoTypes.UNITCOMBAT_ARMOR
local iHelicopter = GameInfoTypes.UNITCOMBAT_HELICOPTER
local iNaval = GameInfoTypes.UNITCOMBAT_NAVAL
local iNavalRanged = GameInfoTypes.UNITCOMBAT_NAVALRANGED
local iNavalMelee = GameInfoTypes.UNITCOMBAT_NAVALMELEE
local iFighter = GameInfoTypes.UNITCOMBAT_FIGHTER
local iBomber = GameInfoTypes.UNITCOMBAT_BOMBER
local iSea = GameInfoTypes.DOMAIN_SEA
local iAir = GameInfoTypes.DOMAIN_AIR
local iFactory = GameInfoTypes.BUILDING_FACTORY

local iWriter = GameInfoTypes.UNITCLASS_WRITER
local iArtist = GameInfoTypes.UNITCLASS_ARTIST
local iMusician = GameInfoTypes.UNITCLASS_MUSICIAN
local iMerchant = GameInfoTypes.UNITCLASS_MERCHANT
local iEngineer = GameInfoTypes.UNITCLASS_ENGINEER
local iScientist = GameInfoTypes.UNITCLASS_SCIENTIST
local iProphet = GameInfoTypes.UNITCLASS_PROPHET
local iGeneral = GameInfoTypes.UNITCLASS_GREAT_GENERAL

local iIgnoreTerrain = GameInfoTypes.PROMOTION_IGNORE_TERRAIN_COST
local iFreePillage = GameInfoTypes.PROMOTION_FREE_PILLAGE_MOVES

local GameSpeed = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100)
local GoldenAgeSpeed = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldenAgePercent)/100)

print("Ayayayaya")
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "Touhou_Tengu";

-------------------------------------------------------------------------------------------------------------------------
-- CheckIfMercenary
-------------------------------------------------------------------------------------------------------------------------
-- Need to check if the unit is a mercenary, it will not make sense if they were to get tengu promotions
-- They're not supposed to get the special promotions, they're technically not tengu
function IsJFDMercenary(pUnit)
	if (pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_JFD_MERCENARY) ~= nil) then
		return pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_JFD_MERCENARY)
	else
		return false
	end
end

-------------------------------------------------------------------------------------------------------------------------
-- IsFootBasedUnit
-------------------------------------------------------------------------------------------------------------------------
function IsFootBasedUnit(pUnit)
	if (pUnit:GetDomainType() ~= iAir and pUnit:GetDomainType() ~= iSea and pUnit:GetUnitCombatType() ~= iMounted and pUnit:GetUnitCombatType() ~= iArmor and pUnit:GetUnitCombatType() ~= iHelicopter and pUnit:GetUnitCombatType() ~= iNaval and pUnit:GetUnitCombatType() ~= iNavalRanged and pUnit:GetUnitCombatType() ~= iFighter and pUnit:GetUnitCombatType() ~= iBomber and pUnit:GetUnitCombatType() ~= iNavalMelee) then
		return true
	else
		return false
	end
end

-------------------------------------------------------------------------------------------------------------------------
-- TenguRaceFunctions
-------------------------------------------------------------------------------------------------------------------------
--Picks a race for the unit, with Great People classes taking priority first
function SetTenguRace(pUnit, pPlayer)
	if (pUnit:GetUnitClassType() == iWriter) or (pUnit:GetUnitClassType() == iMusician) then
		pUnit:SetHasPromotion(iTengukakushi, true)
		pUnit:SetHasPromotion(iCrowTengu, true)
	end
	if (pUnit:GetUnitClassType() == iEngineer) or (pUnit:GetUnitClassType() == iProphet) then
		pUnit:SetHasPromotion(iTengukakushi, true)
		pUnit:SetHasPromotion(iYamabushiTengu, true)
	end
	if (pUnit:GetUnitClassType() == iMerchant) or (pUnit:GetUnitClassType() == iArtist) then
		pUnit:SetHasPromotion(iTengukakushi, true)
		pUnit:SetHasPromotion(iLongNoseTengu, true)
	end
	if (pUnit:GetUnitClassType() == iGeneral) then
		pUnit:SetHasPromotion(iTengukakushi, true)
		pUnit:SetHasPromotion(iWhiteWolfTengu, true)
	end
	if (pUnit:GetUnitClassType() == iScientist) then
		pUnit:SetHasPromotion(iTengukakushi, true)
		pUnit:SetHasPromotion(iGreatTengu, true)
	end
	--Picks race based on other factors, if it did not get a race picked, and if it has the Tengukakushi promotion
	if not pUnit:IsHasPromotion(iCrowTengu) and not pUnit:IsHasPromotion(iWhiteWolfTengu) and not pUnit:IsHasPromotion(iYamabushiTengu) and not pUnit:IsHasPromotion(iLongNoseTengu) and not pUnit:IsHasPromotion(iGreatTengu) and pUnit:IsHasPromotion(iTengukakushi) then
		if (pUnit:GetLevel() >= 5) then
			pUnit:SetHasPromotion(iGreatTengu, true)
			return
		end
		if (pUnit:GetUnitCombatType() == iMelee or pUnit:GetUnitCombatType() == iGun) and (pUnit:IsHasPromotion(iFreePillage)) then
			pUnit:SetHasPromotion(iLongNoseTengu, true)
			return
		end
		if (pUnit:GetUnitCombatType() == iMelee or pUnit:GetUnitCombatType() == iGun) and not (pUnit:IsHasPromotion(iFreePillage)) then
			pUnit:SetHasPromotion(iWhiteWolfTengu, true)
			return
		end
		if (pUnit:GetUnitCombatType() == iArcher or pUnit:GetUnitCombatType() == iRecon) then
			pUnit:SetHasPromotion(iCrowTengu, true)
			return
		end
		if (pUnit:GetUnitCombatType() == iSiege) then
			pUnit:SetHasPromotion(iYamabushiTengu, true)
			return
		end
	end
end

--Removes all racial promotions from the unit
function RemoveTenguRace(pUnit)
	pUnit:SetHasPromotion(iCrowTengu, false)
	pUnit:SetHasPromotion(iCrowTenguBonus, false)
	pUnit:SetHasPromotion(iCrowTenguBonusGP, false)
	pUnit:SetHasPromotion(iWhiteWolfTengu, false)
	pUnit:SetHasPromotion(iWhiteWolfTenguBonusGP, false)
	pUnit:SetHasPromotion(iYamabushiTengu, false)
	pUnit:SetHasPromotion(iLongNoseTengu, false)
	pUnit:SetHasPromotion(iGreatTengu, false)
end

--Gives upgrades to to the existing promotion of the unit, if applicaple
function UpgradeTenguRace(pUnit)
	if pUnit:IsHasPromotion(iCrowTengu) and pUnit:IsHasPromotion(iIgnoreTerrain) then
		if not pUnit:IsHasPromotion(iCrowTenguBonus) then
			pUnit:SetHasPromotion(iCrowTenguBonus, true)
			if pUnit:MovesLeft() > 0 then
				pUnit:SetMoves(pUnit:MaxMoves())
			end
		end
	else
		pUnit:SetHasPromotion(iCrowTenguBonus, false)
	end
	if pUnit:IsHasPromotion(iCrowTengu) and pUnit:IsGreatPerson() then
		if not pUnit:IsHasPromotion(iCrowTenguBonusGP) then
			pUnit:SetHasPromotion(iCrowTenguBonusGP, true)
			if pUnit:MovesLeft() > 0 then
				pUnit:SetMoves(pUnit:MaxMoves())
			end
		end
	else
		pUnit:SetHasPromotion(iCrowTenguBonusGP, false)
	end
	if pUnit:IsHasPromotion(iWhiteWolfTengu) and pUnit:IsGreatPerson() then
		pUnit:SetHasPromotion(iWhiteWolfTenguBonusGP, true)
	else
		pUnit:SetHasPromotion(iWhiteWolfTenguBonusGP, false)
	end
end

-------------------------------------------------------------------------------------------------------------------------
-- TraitMovementBonus
-------------------------------------------------------------------------------------------------------------------------
function TenguMovementBonus(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		if load(pPlayer, "TenguMovementBonus") == Game.GetGameTurn() then return end
	end
	if (pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iRequiredCiv) then --Same rules as to how the race gets picked, except military unit does not need the Tengukakushi promotion
		for pUnit in pPlayer:Units() do
			if (IsFootBasedUnit(pUnit) and not IsJFDMercenary(pUnit)) then
				if not pUnit:IsHasPromotion(iTraitPromotion) then
					pUnit:SetHasPromotion(iTraitPromotion, true)
					if pUnit:MovesLeft() > 0 then
						pUnit:SetMoves(pUnit:MaxMoves())
					end
				end
			elseif (not IsFootBasedUnit(pUnit)) then
				if pUnit:IsHasPromotion(iTraitPromotion) then
					pUnit:SetHasPromotion(iTraitPromotion, false)
				end
			end
		end
	elseif (pPlayer:IsEverAlive()) then
		for pUnit in pPlayer:Units() do
			if (not IsFootBasedUnit(pUnit)) then
				if pUnit:IsHasPromotion(iTraitPromotion) then
					pUnit:SetHasPromotion(iTraitPromotion, false)
				end
			end
		end
	end
	if pPlayer:IsEverAlive() then
		save(pPlayer, "TenguMovementBonus", Game.GetGameTurn())
	end
end
GameEvents.PlayerDoTurn.Add(TenguMovementBonus)

function TenguMovementBonusIndiv(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	if (pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iRequiredCiv) then
		if pPlayer:GetUnitByID(iUnit) ~= nil then
			local pUnit = pPlayer:GetUnitByID(iUnit);
			if (IsFootBasedUnit(pUnit) and not IsJFDMercenary(pUnit)) then
				if not pUnit:IsHasPromotion(iTraitPromotion) then
					pUnit:SetHasPromotion(iTraitPromotion, true)
					if pUnit:MovesLeft() > 0 then
						pUnit:SetMoves(pUnit:MaxMoves())
					end
				end
			end
		end
	end
end
Events.SerialEventUnitCreated.Add(TenguMovementBonusIndiv)

-------------------------------------------------------------------------------------------------------------------------
-- TraitTenguRaces
-------------------------------------------------------------------------------------------------------------------------

function AddTenguRace(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		if load(pPlayer, "AddTenguRace") == Game.GetGameTurn() then return end
	end
	if (pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iRequiredCiv) then
		for pUnit in pPlayer:Units() do
			if (IsFootBasedUnit(pUnit) and not IsJFDMercenary(pUnit)) then
				SetTenguRace(pUnit, pPlayer)
			--Need to run a check to remove all race Promotions from non foot based units. Mercenaries will keep them if they have it, so long as they are not a non foot based unit.
			elseif (not IsFootBasedUnit(pUnit)) then
				RemoveTenguRace(pUnit)
			end
			--Adding Bonuses + Upgrades
			UpgradeTenguRace(pUnit)
		end
	elseif (pPlayer:IsEverAlive()) then
		for pUnit in pPlayer:Units() do
			--Need to run a check to remove all race Promotions from non foot based Units
			if (not IsFootBasedUnit(pUnit)) then
				RemoveTenguRace(pUnit)
			end
		end
	end
	if pPlayer:IsEverAlive() then
		save(pPlayer, "AddTenguRace", Game.GetGameTurn())
	end
end
GameEvents.PlayerDoTurn.Add(AddTenguRace)

function AddTenguRaceIndiv(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	if (pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iRequiredCiv) then
		if pPlayer:GetUnitByID(iUnit) ~= nil then
			local pUnit = pPlayer:GetUnitByID(iUnit);
			if (IsFootBasedUnit(pUnit) and not IsJFDMercenary(pUnit)) then
				SetTenguRace(pUnit, pPlayer)
			end
			--Adding Bonuses + Upgrades
			UpgradeTenguRace(pUnit)
		end
	end
end
Events.SerialEventUnitCreated.Add(AddTenguRaceIndiv)

function AddTenguRacePromoted(iPlayer, iUnit, iPromotion)
	AddTenguRaceIndiv(iPlayer, iUnit)
end
GameEvents.UnitPromoted.Add(AddTenguRacePromoted)

-------------------------------------------------------------------------------------------------------------------------
-- TenguExpendBonus
-------------------------------------------------------------------------------------------------------------------------
function TenguExpendBonus(iPlayer, iUnitType, iUnitTypeVMC)
	if iUnitTypeVMC ~= nil then -- I need to do this because the game event input values was changed with VMC
		iUnitType = iUnitTypeVMC
	end
	local UnitClass = GameInfo.Units[iUnitType].Class
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
		if ((UnitClass == "UNITCLASS_PROPHET" or UnitClass == "UNITCLASS_ENGINEER") and pPlayer:GetCivilizationType() == iRequiredCiv) then
			print("Distributing yamabushi tengu racial bonus...")
			pPlayer:ChangeFaith(50 * GameSpeed)
		end
		if ((UnitClass == "UNITCLASS_MERCHANT" or UnitClass == "UNITCLASS_ARTIST") and pPlayer:GetCivilizationType() == iRequiredCiv) then
			print("Distributing long nose tengu racial bonus...")
			pPlayer:ChangeGold(200 * GameSpeed)
		end
		if ((UnitClass == "UNITCLASS_SCIENTIST" or UnitClass == "UNITCLASS_JFD_GREAT_MAGISTRATE" or UnitClass == "UNITCLASS_JFD_GREAT_DIGNITARY") and pPlayer:GetCivilizationType() == iRequiredCiv) then
			print("Distributing great tengu racial bonus...")
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				pCapital:ChangeFood(50 * GameSpeed)
			end
		end
		if (iUnitType == iReporterJournalist) then
			print("Distributing journalist bonus...")
			for pCity in pPlayer:Cities() do
				if (pCity:GetOriginalOwner() == iPlayer) then
					local iPopulation = math.floor(pCity:GetPopulation())
					local iCurrentBoost = pCity:GetNumBuilding(iHappinessBoost)
					local iValue = iPopulation * 2 * GameSpeed
					pCity:SetNumRealBuilding(iHappinessBoost, iCurrentBoost + iValue)
				end
			end
		end
	end
end
GameEvents.GreatPersonExpended.Add(TenguExpendBonus)

-------------------------------------------------------------------------------------------------------------------------
-- ReporterJournalistBoostTick
-------------------------------------------------------------------------------------------------------------------------
function ScoopHappinessBoostTick(iPlayer)
    local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		if load(pPlayer, "ScoopHappinessBoostTick") == Game.GetGameTurn() then return end
	end
	for pCity in pPlayer:Cities() do
		local iCurrentBoost = pCity:GetNumBuilding(iHappinessBoost)
		if pPlayer:IsGoldenAge() then
			local iCurrentCulture = pPlayer:GetJONSCulture()
			pPlayer:SetJONSCulture(iCurrentCulture + iCurrentBoost)
		end
		pCity:SetNumRealBuilding(iHappinessBoost, math.floor(iCurrentBoost / 2))
	end
	if pPlayer:IsEverAlive() then
		save(pPlayer, "ScoopHappinessBoostTick", Game.GetGameTurn())
	end
end
GameEvents.PlayerDoTurn.Add(ScoopHappinessBoostTick)

-------------------------------------------------------------------------------------------------------------------------
-- NewspaperOfficeUpgrade
-------------------------------------------------------------------------------------------------------------------------
function NewspaperOfficeUpgrade(iPlayer)
    local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iNewspaperOffice) and pCity:IsHasBuilding(iFactory) then
				pCity:SetNumRealBuilding(iNewspaperOfficeUpgrade, 1)
			else
				pCity:SetNumRealBuilding(iNewspaperOfficeUpgrade, 0)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(NewspaperOfficeUpgrade)
GameEvents.CityConstructed.Add(NewspaperOfficeUpgrade)
GameEvents.CitySoldBuilding.Add(NewspaperOfficeUpgrade)

-------------------------------------------------------------------------------------------------------------------------
-- EventsandDecisionsRewards
-------------------------------------------------------------------------------------------------------------------------
function TenguDecisionRewards(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		if pPlayer:HasPolicy(GameInfoTypes.POLICY_NEWS_TOURNAMENT_DUMMY) then
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_NEWS_TOURNAMENT_DUMMY, 0)
			end
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_NEWS_TOURNAMENT_DUMMY, 1)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(TenguDecisionRewards)
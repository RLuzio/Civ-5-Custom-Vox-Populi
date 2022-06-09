-- This is a modified version of bouncymischa's HakureiLua.lua, used without permission.

local iCiv = GameInfoTypes.CIVILIZATION_NETHERWORLD
local iSamuraiPoetPromotion = GameInfoTypes.PROMOTION_SAMURAI_POET

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

function SamuraiPoetStrength(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:IsAlive()) then
		for pUnit in pPlayer:Units() do
			if (pUnit:IsHasPromotion(iSamuraiPoetPromotion)) then
				local iBaseCombatStrength = GetStrongestMilitaryUnitStrength(pPlayer, false, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
				local iModifiedCombatStrength = math.ceil(iBaseCombatStrength * 1.30)
				pUnit:SetBaseCombatStrength(iModifiedCombatStrength)
			end
		end		
	end
end
GameEvents.PlayerAdoptPolicy.Add(SamuraiPoetStrength);
GameEvents.PlayerDoTurn.Add(SamuraiPoetStrength);

function SamuraiPoetStrength2(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
		if pPlayer:GetUnitByID(iUnit) ~= nil then
			pUnit = pPlayer:GetUnitByID(iUnit);
 			if (pUnit:IsHasPromotion(iSamuraiPoetPromotion)) then
				local iBaseCombatStrength = GetStrongestMilitaryUnitStrength(pPlayer, false, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
				local iModifiedCombatStrength = math.ceil(iBaseCombatStrength * 1.30)
				pUnit:SetBaseCombatStrength(iModifiedCombatStrength)
			end
        end
    end
end
Events.SerialEventUnitCreated.Add(SamuraiPoetStrength2)
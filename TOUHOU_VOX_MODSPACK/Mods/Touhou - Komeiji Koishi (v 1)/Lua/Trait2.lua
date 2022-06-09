-- Trait2
-- Author: kokoro
-- DateCreated: 4/28/2019 3:47:02 PM
--------------------------------------------------------------
local iRequiredCiv = GameInfoTypes.CIVILIZATION_ANIMISM
local iTraitBuilding = GameInfoTypes.BUILDING_KOISHI_TRAIT_BUILDING
local iSpyBuilding = GameInfoTypes.BUILDING_KOISHI_TRAIT_BUILDING_B


function AddKoishiTraitBuilding(iPlayer)

	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iRequiredCiv then

	print("IF WITH SPY")

		local CapitalCity = pPlayer:GetCapitalCity()

		local NumSpy = pPlayer:GetNumSpies()

		CapitalCity:SetNumRealBuilding(iSpyBuilding, 1)

		if pPlayer:GetNumSpies() > 0 then

			CapitalCity:SetNumRealBuilding(iTraitBuilding, NumSpy)

		else
			
			CapitalCity:SetNumRealBuilding(iTraitBuilding, 0)

		end
	end
end
GameEvents.PlayerDoTurn.Add(AddKoishiTraitBuilding)
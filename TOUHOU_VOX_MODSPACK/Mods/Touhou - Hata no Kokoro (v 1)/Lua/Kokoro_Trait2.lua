-- Kokoro_trait
-- Author: kokoro
-- DateCreated: 4/22/2019 8:40:40 AM
--------------------------------------------------------------
local iRequiredCiv = GameInfoTypes.CIVILIZATION_MASQUERADE
local iTraitBuilding = GameInfoTypes.BUILDING_KOKORO_TRAIT_BUILDING

tTableOfClasses = {}
for row in DB.Query("SELECT b.ID AS bID, b.BuildingClass AS bClass, bc.ID AS bcID FROM Buildings b JOIN BuildingClasses bc ON (b.BuildingClass = bc.Type) WHERE GreatWorkSlotType = 'GREAT_WORK_SLOT_ART_ARTIFACT'") do
  tTableOfClasses[row.bID] = row.bcID
end


function ChangeArtArtifactEffects(iPlayer)

	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iRequiredCiv then

	print("IF A WORKS")

		if pPlayer:GetNumGreatWorks() > 0 then

			for pCity in pPlayer:Cities() do

					local iNumberArtArtifact = 0

					for k,v in pairs(tTableOfClasses) do

						if pCity:IsHasBuilding(k) then
							iNumberArtArtifact = iNumberArtArtifact + pCity:GetNumGreatWorksInBuilding(v)
							print("Has build works")
						end

					end

					pCity:SetNumRealBuilding(iTraitBuilding, iNumberArtArtifact)

			end
		else
			if pPlayer:CountNumBuildings(iTraitBuilding) > 0 then
				for pCity in pPlayer:Cities() do
					pCity:SetNumRealBuilding(iTraitBuilding, 0)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(ChangeArtArtifactEffects)
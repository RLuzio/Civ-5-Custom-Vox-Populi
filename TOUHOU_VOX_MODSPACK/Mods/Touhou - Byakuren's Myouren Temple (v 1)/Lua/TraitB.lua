-- TraitB
-- Author: James
-- DateCreated: 5/21/2016 5:17:00 AM
--------------------------------------------------------------
local iRequiredCiv = GameInfoTypes.CIVILIZATION_MYOURENJI
local iTraitBuilding = GameInfoTypes.BUILDING_T_BUILD

tTableOfGreatWritingBuildings = {}
tTableOfClasses = {}
for row in DB.Query("SELECT b.ID AS bID, b.BuildingClass AS bClass, bc.ID AS bcID FROM Buildings b JOIN BuildingClasses bc ON (b.BuildingClass = bc.Type) WHERE GreatWorkSlotType = 'GREAT_WORK_SLOT_LITERATURE'") do
  tTableOfClasses[row.bID] = row.bcID
end


function ChangeGreatWritingEffects(iPlayer)

	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iRequiredCiv then

	print("IF A WORKS")

		if pPlayer:GetNumGreatWorks() > 0 then

			for pCity in pPlayer:Cities() do

					local iNumberGreatWritings = 0

					for k,v in pairs(tTableOfClasses) do

						if pCity:IsHasBuilding(k) then
							iNumberGreatWritings = iNumberGreatWritings + pCity:GetNumGreatWorksInBuilding(v)
							print("Has build works")
						end

					end

					pCity:SetNumRealBuilding(iTraitBuilding, iNumberGreatWritings)

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
GameEvents.PlayerDoTurn.Add(ChangeGreatWritingEffects)
-- Tersane
-- Author: pineappledan
-- DateCreated: 08/05/2022
--------------------------------------------------------------
local fGameSpeedModifier = GameInfo.GameSpeeds[ Game.GetGameSpeedType() ].ConstructPercent / 100
local eCivilizationOttoman = GameInfoTypes.CIVILIZATION_OTTOMAN
local eImprovementTersane = GameInfoTypes.IMPROVEMENT_OTTOMAN_TERSANE
local iUnitAdmiral = GameInfoTypes.UNIT_GREAT_ADMIRAL
local iUnitGeneral = GameInfoTypes.UNIT_GREAT_GENERAL
local iTersaneDummy = GameInfoTypes.BUILDING_D_FOR_TERSANE

function TersanePlaceDummy(iX, iY, iOwner, iOldImprovement, iNewImprovement, bPillaged)
	local pPlayer = Players[iOwner]

	if not (pPlayer and pPlayer:GetCivilizationType() == eCivilizationOttoman) then return end

	if iNewImprovement == eImprovementTersane then			
		local pMainPlot = Map.GetPlot(iX, iY)

		if not (pMainPlot:GetOwner() ~= nil and Players[pMainPlot:GetOwner()]:GetCivilizationType() == eCivilizationOttoman) then return end

		local tPossibleSpots = {}
								
		for iDirection = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do	
			local pPlot = Map.PlotDirection(iX, iY, iDirection)
			
			if pPlot:IsCity() then	
				local pCity = pPlot:GetPlotCity()
				pCity:SetNumRealBuilding(iTersaneDummy, 1)
			end
		end
	end
end

function TersaneGeneralBirth(iPlayer, iUnit, iUnitType, iX, iY)
	--AI automatically build Tersanes if a GG or GA spawns in a coastal city that doesn't already have one
	local pPlayer = Players[iPlayer]
	
	if pPlayer:IsHuman() then return end
	if not (pPlayer and pPlayer:GetCivilizationType() == eCivilizationOttoman) then return end

	if (iUnitType == iUnitAdmiral or iUnitType == iUnitGeneral) then 
		
		local pMainPlot = Map.GetPlot(iX, iY)
		if pMainPlot:IsCity() then
			local pCity = pMainPlot:GetPlotCity()
			if pCity:IsCoastal() then
				if not pCity:IsHasBuilding(iTersaneDummy) then
					pPlayer:GetUnitByID(iUnit):Kill(true, -1)
					pCity:SetNumRealBuilding(iTersaneDummy, 1)
				
					for iDirection = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do	
						local pPlot = Map.PlotDirection(iX, iY, iDirection)
			
						if (pPlot:IsWater() and pPlot:GetImprovementType() == -1) then	
							pPlot:SetImprovementType(eImprovementTersane)
							break
						end
					end
				end
			end
		else
			for iDirection = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do	
				local pPlot = Map.PlotDirection(iX, iY, iDirection)	
				if pPlot:IsCity() then	
					local pCity = pPlot:GetPlotCity()
					if pCity:IsCoastal() then
						pPlayer:GetUnitByID(iUnit):Kill(true, -1)
						pCity:SetNumRealBuilding(iTersaneDummy, 1)
						
						for iDirection = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do	
							local pPlot2 = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), iDirection)
			
							if (pPlot2:IsWater() and pPlot2:GetImprovementType() == -1) then	
								pPlot2:SetImprovementType(eImprovementTersane)
								break
							end
						end
						break
					end
				end
			end
		end
	end
end


if Game.IsCivEverActive(eCivilizationOttoman) then
	GameEvents.TileImprovementChanged.Add(TersanePlaceDummy)
	GameEvents.UnitCreated.Add(TersaneGeneralBirth)
end

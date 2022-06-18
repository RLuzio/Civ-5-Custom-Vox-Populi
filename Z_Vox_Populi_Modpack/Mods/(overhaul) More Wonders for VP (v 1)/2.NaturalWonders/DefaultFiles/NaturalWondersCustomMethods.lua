-- NaturalWondersCustomMethods.lua
-- Author: Leo
-- DateCreated: 3/13/2016 9:58:45 AM
--------------------------------------------------------------
------------------------------------------------------------------------------
--	MODDER:   Barathor
--  THANKS:	  whoward69
--  MODDER2	  adan_eslavo
------------------------------------------------------------------------------
-- MOD: * Great Barrier Reef (1):	3-tile wonder (in-line, any direction); much closer to land; surrounded by coast;
--		* Rock of Gibraltar (2):	one land adjacent (preferred flat grass);
--		* Krakatoa (3):				near islands and smaller landmasses;
--		* Lake Victoria (4):		looks for a river surrounded by bunch of hills and mountains;
--		* Giant's Causeway (5):		custom method similar to Rock of Gibraltar; prefers tundra;
--		* Salar de Uyuni (6):		has only tile changes method; flattens, clears features and changes adjacent tiles to desert; 2-tiles;
--		* Mt. Kailash (7):			has only tile changes method; adds mountains; changes adjacent to tundra;
--		* Sri Pada (8):				has only tile changes method; changes adjacent to grass;
--		* Mt. Everest (9):			has only tile changes method; adds mountains; changes adjacent to tundra or snow;
--		* Lake Retba (10):			must be on solid terrain with coast;
--		*
--		* Bermuda Triangle (12):	set between 3-4 tiles of land on 3 corners separated by water;
--		* Dallol (13):				has only tile changes method; all tiles around are clered from features;
--		* Bioluminescent Bay (14):	surrounded by jungle and grassland
--		
--		* Adds a latitude check for all water-based natural wonders in this function. Unlike land-based NW's, these are too flexible and need more restrictions.
--		  (With the new latitude check keeping them away from the polar areas, the ice checks aren't really needed anymore, but I kept them in for modders.)
--
--		* (Still trying to get this to work here in this file.) Fixes a rare bug with the Reef which would cause resources to sometimes be placed on top of its lower half (now around center).
------------------------------------------------------------------------------
--	FILE:	  NaturalWondersCustomMethods.lua
--	AUTHOR:   Bob Thomas
--	PURPOSE:  Functions designed to support custom natural wonder placement.
------------------------------------------------------------------------------
--	Copyright (c) 2011 Firaxis Games, Inc. All rights reserved.
------------------------------------------------------------------------------

--[[ -------------------------------------------------------------------------
NOTE: This file is an essential component of the Start Plot System. I have
separated out the functions in this file to permit more convenient operation
for modders wishing to add new natural wonders or modify existing ones. If
you are supplying new custom methods, you will not have to supply an updated
version of AssignStartingPlots with your mod instead, you only have to supply
an update of this file along with your updated Civ5Features.xml file.

CONTENTS OF THIS FILE:

* NWCustomEligibility(x, y, method_number)
* NWCustomPlacement(x, y, row_number, method_number)
------------------------------------------------------------------------- ]]--

include("MapmakerUtilities")

------------------------------------------------------------------------------
function NWCustomEligibility(x, y, method_number)
	local ePlotOcean = PlotTypes.PLOT_OCEAN
	local ePlotFlat = PlotTypes.PLOT_LAND
	local ePlotHill = PlotTypes.PLOT_HILLS
	local ePlotMountain = PlotTypes.PLOT_MOUNTAIN
	local eTerrainCoast = TerrainTypes.TERRAIN_COAST
	local eTerrainGrass = TerrainTypes.TERRAIN_GRASS	
	local eTerrainPlains = TerrainTypes.TERRAIN_PLAINS
	local eTerrainDesert = TerrainTypes.TERRAIN_DESERT
	local eTerrainTundra = TerrainTypes.TERRAIN_TUNDRA
	local eTerrainSnow = TerrainTypes.TERRAIN_SNOW
	local eFeatureNo = FeatureTypes.NO_FEATURE
	local eFeatureForest = FeatureTypes.FEATURE_FOREST
	local eFeatureJungle = FeatureTypes.FEATURE_JUNGLE

	local tDirectionTypes = {
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_NORTHWEST
	}

	local iW, iH = Map.GetGridSize()

	if method_number == 1 then
		-- Great Barrier Reef
		-- MOD: Now 3 tile wonder - long shape;
		-- MOD: Area checked is better to handle all 3 main directions: E-W, NW-SE, NE-SW;
		-- MOD: Latitude to prevent it from spawning in polar regions;
		if (y >= (iH/2)) then	
			-- Upper half of map;
			if (math.abs((iH/2) - y)/(iH/2)) > 0.8 then
				return false
			end
		else
			-- Lower half of map;
			if (math.abs((iH/2) - y + 1)/(iH/2)) > 0.8 then
				return false
			end
		end 
		
		local pMainPlot = Map.GetPlot(x, y)		
		
		if pMainPlot == nil then return false end
		if pMainPlot:GetFeatureType() ~= eFeatureNo then return false end
		if pMainPlot:IsWater() == false then return false end
		if pMainPlot:IsLake() then return false end
		if pMainPlot:IsAdjacentToLand() then return false end

		local iNumLand, iNumCoast = 0, 0
		
		local tDirectionsNE = {
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST
		}
		local tDirectionsE = {
			DirectionTypes.DIRECTION_EAST
		}
		local tDirectionsSE = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST
		}
		local tDirectionsSW = {
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST
		}
		local tDirectionsW = {
			DirectionTypes.DIRECTION_WEST
		}
		local tDirectionsNW = {
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST,
			DirectionTypes.DIRECTION_NORTHEAST
		}
		
		local tSubdirections = {
			tDirectionsNE,
			tDirectionsE,
			tDirectionsSE,
			tDirectionsSW,
			tDirectionsW,
			tDirectionsNW
		}

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if pAdjacentPlot == nil then return false end
			if pAdjacentPlot:GetFeatureType() ~= eFeatureNo then return false end
			
			local iX = pAdjacentPlot:GetX()
			local iY = pAdjacentPlot:GetY()
				
			for j, subdirection in ipairs(tSubdirections[i]) do
				local pDistantPlot = Map.PlotDirection(iX, iY, subdirection)

				if pDistantPlot == nil then return false end

				if pDistantPlot:GetTerrainType() == eTerrainCoast then
					iNumCoast = iNumCoast + 1
				end

				if pDistantPlot:IsAdjacentToLand() then
					iNumLand = iNumLand + 1
				end

			end
		end
		
		if iNumCoast < 7 or iNumLand < 5 then return false end
		
		return true
	elseif method_number == 2 then
		-- Rock of Gibraltar
		local pPlot = Map.GetPlot(x, y)
		
		if pPlot == nil then return false end
		if pPlot:IsWater() == false then return false end
		if pPlot:IsLake() then return false end
		
		local sFeatureType = pPlot:GetFeatureType()
		
		if sFeatureType ~= eFeatureNo then return false end
		
		local iNumLand = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
		
			local sAdjacentPlotType = pAdjacentPlot:GetPlotType()
			local sAdjacentTerrainType = pAdjacentPlot:GetTerrainType()
			local sAdjacentFeatureType = pAdjacentPlot:GetFeatureType()
			
			-- MOD: Don't permit small landmasses especially those single-tile islands!
			-- MOD: Avoid mountains
			if sAdjacentPlotType ~= ePlotOcean then
				if pAdjacentPlot:Area():GetNumTiles() < 10
				or sAdjacentPlotType == ePlotMountain or sAdjacentPlotType == ePlotHill
				or not (sAdjacentTerrainType == eTerrainDesert or sAdjacentTerrainType == eTerrainGrass) then return false end
				
				iNumLand = iNumLand + 1
				
				if iNumLand > 1 then return false end
			end
		end

		if iNumLand ~= 1 then return false end
		
		return true
	elseif method_number == 3 then
		-- MOD: Krakatoa
		local pMainPlot = Map.GetPlot(x, y)
		
		if pMainPlot == nil then return false end
		if pMainPlot:IsWater() == false then return false end
		if pMainPlot:IsLake() then return false end
		if pMainPlot:GetFeatureType() ~= eFeatureNo then return false end
		
		local bBigIsland = false
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
		
			local iX = pAdjacentPlot:GetX()
			local iY = pAdjacentPlot:GetY()
			
			if pAdjacentPlot:GetFeatureType() ~= eFeatureNo then return false end

			for j, subdirection in ipairs(tDirectionTypes) do
				local pDistantPlot = Map.PlotDirection(iX, iY, subdirection)
				
				if pDistantPlot == nil then return false end
		
				local sDistantPlotType = pDistantPlot:GetPlotType()
				local sDistantAreaNear = pDistantPlot:Area():GetNumTiles()
				
				if sDistantPlotType ~= ePlotOcean then
					if sDistantAreaNear > iH then return false end
					
					if sDistantAreaNear >= 8 and sDistantAreaNear <= iH then
						bBigIsland = true
					end
				end
			end
		end
		
		if not bBigIsland then return false end
		
		return true
	elseif method_number == 4 then
		-- MOD: Lake Victoria
		local pMainPlot = Map.GetPlot(x, y)
		
		if pMainPlot == nil then return false end
		if pMainPlot:IsAdjacentToShallowWater() then return false end
		if not pMainPlot:IsRiver() then return false end
		if pMainPlot:GetTerrainType() == eTerrainSnow or pMainPlot:GetTerrainType() == eTerrainDesert then return false end
		
		local iNumHillsAndMountains = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
			if pAdjacentPlot:GetTerrainType() == eTerrainSnow then return false end
			
			local sPlotType = pAdjacentPlot:GetPlotType()

			if sPlotType == ePlotHill or sPlotType == ePlotMountain then
				iNumHillsAndMountains = iNumHillsAndMountains + 1
			end
		end
		
		if iNumHillsAndMountains < 3 then return false end

		return true
	elseif method_number == 5 then
		-- Giant's Causeway
		local pPlot = Map.GetPlot(x, y)
		
		if pPlot == nil then return false end
		if pPlot:IsWater() == false then return false end
		if pPlot:IsLake() then return false end
		
		local sFeatureType = pPlot:GetFeatureType()
		
		if sFeatureType ~= eFeatureNo then return false end

		local iNumLand = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
		
			local sAdjacentPlotType = pAdjacentPlot:GetPlotType()
			local sAdjacentTerrainType = pAdjacentPlot:GetTerrainType()
			local sAdjacentFeatureType = pAdjacentPlot:GetFeatureType()
			
			if sAdjacentPlotType ~= ePlotOcean then
				if pAdjacentPlot:Area():GetNumTiles() < 5 
				or not (sAdjacentTerrainType == eTerrainTundra or sAdjacentTerrainType == eTerrainSnow)
				or sAdjacentFeatureType ~= eFeatureNo then return false end
				
				iNumLand = iNumLand + 1
				
				if iNumLand > 2 then return false end
			end
		end
		
		if iNumLand < 1 then return false end
		
		return true
	elseif method_number == 6 then
		-- reserved: Salar de Uyuni
	elseif method_number == 7 then
		-- reserved: Mt. Kailash
	elseif method_number == 8 then
		-- reserved: Sri Pada
	elseif method_number == 9 then
		-- reserved: Mt. Everest
	elseif method_number == 10 then
		-- Lake Retba
		local pMainPlot = Map.GetPlot(x, y)
		
		if pMainPlot == nil then return false end
		if not pMainPlot:IsAdjacentToShallowWater() then return false end
		if pMainPlot:IsRiver() then return false end
		if pMainPlot:GetPlotType() ~= ePlotFlat then return false end
		
		local pMainTerrainType = pMainPlot:GetTerrainType()

		if pMainTerrainType == eTerrainGrass or pMainTerrainType == eTerrainTundra or pMainTerrainType == eTerrainSnow then return false end
		
		local pMainAreaNear = pMainPlot:Area():GetNumTiles()

		if pMainAreaNear < 6 or pMainAreaNear > (2 * iH) then return false end 

		local bIsHasSeaTiles = false
		local iNumLandTiles = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
		
			local sAdjacentTerrainType = pAdjacentPlot:GetTerrainType()

			if sAdjacentTerrainType == eTerrainGrass or sAdjacentTerrainType == eTerrainTundra or sAdjacentTerrainType == eTerrainSnow then return false end

			local sAdjacentPlotType = pAdjacentPlot:GetPlotType()
			
			if sAdjacentPlotType == ePlotMountain then return false end

			if sAdjacentPlotType == ePlotOcean then
				if pAdjacentPlot:IsLake() then return false end
				
				bIsHasSeaTiles = true
			end

			if sAdjacentPlotType ~= ePlotOcean then
				iNumLandTiles = iNumLandTiles + 1
			end
		end

		if not bIsHasSeaTiles or iNumLandTiles ~= 4 then return false end

		return true
	elseif method_number == 11 then
		-- reserved: Eye of the Sahara
	elseif method_number == 12 then
		-- Bermuda Triangle
		local pMainPlot = Map.GetPlot(x, y)		
		
		if pMainPlot == nil then return false end
		if pMainPlot:GetFeatureType() ~= eFeatureNo then return false end
		if pMainPlot:IsWater() == false then return false end
		if pMainPlot:IsLake() then return false end

		local pSEPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHEAST)
		
		if pSEPlot == nil then return false end
		if pSEPlot:GetFeatureType() ~= eFeatureNo then return false end
		if pSEPlot:IsWater() == false then return false end
		
		local pSWPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHWEST)

		if pSWPlot == nil then return false end
		if pSWPlot:GetFeatureType() ~= eFeatureNo then return false end
		if pSWPlot:IsWater() == false then return false end
		
		local iNumLandN, iNumLandSE, iNumLandSW = 0, 0, 0
		
		local tDirectionsTop = {
			DirectionTypes.DIRECTION_NORTHWEST,
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_EAST
		}
		local tDirectionsBottomRight = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST
		}
		local tDirectionsBottomLeft = {
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST
		}

		for i, direction in ipairs(tDirectionsTop) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if pAdjacentPlot == nil then return false end

			if pAdjacentPlot:GetPlotType() ~= ePlotOcean then
				iNumLandN = iNumLandN + 1
			end
		end

		local iSEX = pSEPlot:GetX()
		local iSEY = pSEPlot:GetY()

		for i, direction in ipairs(tDirectionsBottomRight) do
			local pAdjacentPlot = Map.PlotDirection(iSEX, iSEY, direction)

			if pAdjacentPlot == nil then return false end
			
			if pAdjacentPlot:GetPlotType() ~= ePlotOcean  then
				iNumLandSE = iNumLandSE + 1
			end
		end

		local iSWX = pSWPlot:GetX()
		local iSWY = pSWPlot:GetY()

		for i, direction in ipairs(tDirectionsBottomLeft) do
			local pAdjacentPlot = Map.PlotDirection(iSWX, iSWY, direction)

			if pAdjacentPlot == nil then return false end
			
			if pAdjacentPlot:GetPlotType() ~= ePlotOcean then
				iNumLandSW = iNumLandSW + 1
			end
		end
		
		if iNumLandN < 1 or iNumLandSE < 1 or iNumLandSW < 1 then return false end

		local iNumLandSum = iNumLandN + iNumLandSE + iNumLandSW
		
		if iNumLandSum < 3 or iNumLandSum > 4 then return false end
		
		return true
	elseif method_number == 13 then
		-- reserved: Dallol
	elseif method_number == 14 then
		-- Bioluminescent Bay
		local pPlot = Map.GetPlot(x, y)
		
		if pPlot == nil then return false end
		if pPlot:IsWater() == false then return false end
		if pPlot:IsLake() then return false end
		if pPlot:GetTerrainType() ~= eTerrainCoast then return false end
		
		local sFeatureType = pPlot:GetFeatureType()
		
		if sFeatureType ~= eFeatureNo then return false end
		
		local iNumCoast, iNumJungle, iNumGrass = 0, 0, 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
		
			local sAdjacentPlotType = pAdjacentPlot:GetPlotType()
			local sAdjacentTerrainType = pAdjacentPlot:GetTerrainType()
			local sAdjacentFeatureType = pAdjacentPlot:GetFeatureType()
			
			if sAdjacentPlotType ~= ePlotOcean then
				if sAdjacentFeatureType == eFeatureJungle then
					iNumJungle = iNumJungle + 1
				end

				if sAdjacentTerrainType == eTerrainGrass then
					iNumGrass = iNumGrass + 1
				end
			else
				iNumCoast = iNumCoast + 1
			end
		end
		
		if iNumCoast < 1 or iNumCoast > 2 or iNumGrass < 2 or iNumJungle < 2 then return false end
		
		return true
	elseif method_number == 100 then
		-- dummy
		return false
	else
		-- unidentified method number;
		return false
	end
end
------------------------------------------------------------------------------
function NWCustomPlacement(x, y, row_number, method_number)
	local ePlotOcean = PlotTypes.PLOT_OCEAN
	local ePlotFlat = PlotTypes.PLOT_LAND
	local ePlotHill = PlotTypes.PLOT_HILLS
	local ePlotMountain = PlotTypes.PLOT_MOUNTAIN
	local eTerrainCoast = TerrainTypes.TERRAIN_COAST
	local eTerrainGrass = TerrainTypes.TERRAIN_GRASS	
	local eTerrainPlains = TerrainTypes.TERRAIN_PLAINS
	local eTerrainDesert = TerrainTypes.TERRAIN_DESERT
	local eTerrainTundra = TerrainTypes.TERRAIN_TUNDRA
	local eTerrainSnow = TerrainTypes.TERRAIN_SNOW
	local eTerrainMountain = TerrainTypes.TERRAIN_MOUNTAIN
	local eFeatureNo = FeatureTypes.NO_FEATURE
	local eFeatureForest = FeatureTypes.FEATURE_FOREST

	local tDirectionTypes = {
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_NORTHWEST
	}

	local iW, iH = Map.GetGridSize()
	
	if method_number == 1 then
		-- Great Barrier Reef
		-- Totally new method;
		-- Randomizer chooses one of main 3 directions: E-W, NE-SW, NW-SE;
		local iMainDirectionA = math.random(2) + 1
		local iMainDirectionB = iMainDirectionA + 3
		local iAtollDirectionA, iAtollDirectionB

		repeat
			iAtollDirectionA = math.random(5) + 1
		until iAtollDirectionA ~= iMainDirectionA and iAtollDirectionA ~= iMainDirectionB

		repeat
			iAtollDirectionB = math.random(5) + 1
		until iAtollDirectionB ~= iMainDirectionA and iAtollDirectionB ~= iMainDirectionB
		

		local pMainPlot = Map.GetPlot(x, y)
		
		if pMainPlot:GetTerrainType() ~= eTerrainCoast then
			pMainPlot:SetTerrainType(eTerrainCoast, false, false)
		end
		
		local tDirectionsNE = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_NORTHWEST
		}
		local tDirectionsE = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_NORTHEAST
		}
		local tDirectionsSE = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST
		}
		local tDirectionsSW = {
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_SOUTHEAST
		}
		local tDirectionsW = {
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST,
			DirectionTypes.DIRECTION_SOUTHWEST
		}
		local tDirectionsNW = {
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST,
			DirectionTypes.DIRECTION_NORTHEAST
		}
		
		local tSubDirections = {
			tDirectionsNE,
			tDirectionsE,
			tDirectionsSE,
			tDirectionsSW,
			tDirectionsW,
			tDirectionsNW
		}

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetTerrainType() ~= eTerrainCoast then
				pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
			end

			if i == iMainDirectionA or i == iMainDirectionB then
				local iX = pAdjacentPlot:GetX()
				local iY = pAdjacentPlot:GetY()

				for j, subdirection in ipairs(tSubDirections[i]) do
					local pDistantPlot = Map.PlotDirection(iX, iY, subdirection)

					if pDistantPlot:GetTerrainType() ~= eTerrainCoast then
						pDistantPlot:SetTerrainType(eTerrainCoast, false, false)
					end

					pAdjacentPlot:SetFeatureType(GameInfoTypes.FEATURE_REEF)
				end
			elseif i == iAtollDirectionA or i == iAtollDirectionB then
				local iX = pAdjacentPlot:GetX()
				local iY = pAdjacentPlot:GetY()
				local pPlot = Map.GetPlot(iX, iY)

				local iLandOrAtoll = math.random(3)	
					
				if iLandOrAtoll == 0 then 	
					pPlot:SetPlotType(ePlotFlat, false, false)
					pPlot:SetTerrainType(eTerrainGrass, false, false)
					pPlot:SetFeatureType(GameInfoTypes.FEATURE_JUNGLE)
				else 
					pPlot:SetFeatureType(GameInfoTypes.FEATURE_ATOLL)
				end
			end
		end
		
		-- MOD: This second plot of the Reef was missing impact values. This would cause resources to spawn on top of it sometimes.
		--[[ MOD: I don't know how to get this to work yet within this file.  I can fix it in the main AssignStartingPlots file, but I don't want to include the whole thing in this mod.--]]
		--[[AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 1, 1)		-- Strategic layer
		AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 2, 1)		-- Luxury layer
		AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 3, 1)		-- Bonus layer--]]
	elseif method_number == 2 then
		-- Rock of Gibraltar
		-- MOD: Removed mountain change;
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotHill, false, false)
		pPlot:SetTerrainType(eTerrainPlains, false, false)
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotOcean then
				pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
			end
		end
	elseif method_number == 3 then
		-- MOD: Krakatoa
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainGrass, false, false)
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			pAdjacentPlot:SetPlotType(ePlotOcean, false, false)
			pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
		end
	elseif method_number == 4 then
		-- MOD: Lake Victoria
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotOcean, false, false)
		pPlot:SetTerrainType(eTerrainCoast, false, false)
	elseif method_number == 5 then
		-- Giant's Causeway
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotOcean, false, false)
		pPlot:SetTerrainType(eTerrainCoast, false, false)
		
		local tPossibleSpots = {}
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotOcean then
				pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
			else
				table.insert(tPossibleSpots, pAdjacentPlot)
			end
		end
		
		pChosenPlot = table.remove(tPossibleSpots, math.random(#tPossibleSpots))
		pChosenPlot:SetPlotType(ePlotFlat, false, false)
		pChosenPlot:SetFeatureType(GameInfoTypes.FEATURE_CAUSEWAY_B)
	elseif method_number == 6 then
		-- Salar de Uyuni
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainDesert, false, false)
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotHill then
				pAdjacentPlot:SetPlotType(ePlotFlat, false, false)
			end	
			
			pAdjacentPlot:SetTerrainType(eTerrainDesert, false, false)
			pAdjacentPlot:SetFeatureType(eFeatureNo)
		end

		local tPossibleSpots = {}
		local pAdjacentPlot

		for i, direction in ipairs(tDirectionTypes) do
			pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotFlat and not pAdjacentPlot:IsAdjacentToShallowWater() and not pAdjacentPlot:IsRiver() then	
				table.insert(tPossibleSpots, pAdjacentPlot)
			end
		end

		pChosenPlot = table.remove(tPossibleSpots, math.random(#tPossibleSpots))
			
		local pChosenPlotX = pChosenPlot:GetX()
		local pChosenPlotY = pChosenPlot:GetY()

		for j, subdirection in ipairs(tDirectionTypes) do
			local pSecondAdjacentPlot = Map.PlotDirection(pChosenPlotX, pChosenPlotY, subdirection)
			
			if pSecondAdjacentPlot:GetPlotType() == ePlotHill then
				pSecondAdjacentPlot:SetPlotType(ePlotFlat, false, false)
			end	
			
			pSecondAdjacentPlot:SetTerrainType(eTerrainDesert, false, false)
					
			if pSecondAdjacentPlot:GetFeatureType() ~= GameInfoTypes.FEATURE_SALAR_A then
				pSecondAdjacentPlot:SetFeatureType(eFeatureNo)
			end
		end				
				
		pChosenPlot:SetFeatureType(GameInfoTypes.FEATURE_SALAR_B)
	elseif method_number == 7 then
		-- Mt. Kailash
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainTundra, false, false)
		
		local iNumMountains = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotMountain then
				iNumMountains = iNumMountains + 1
			end	
		end

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if (pAdjacentPlot:GetPlotType() == ePlotHill or pAdjacentPlot:GetPlotType() == ePlotFlat) and iNumMountains < 3 then
				pAdjacentPlot:SetPlotType(ePlotMountain, false, false)
				iNumMountains = iNumMountains + 1
			end	
			
			if pAdjacentPlot:GetTerrainType() == eTerrainDesert or pAdjacentPlot:GetTerrainType() == eTerrainGrass then
				pAdjacentPlot:SetTerrainType(eTerrainTundra, false, false)
			end
		end
	elseif method_number == 8 then
		-- Sri Pada
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainGrass, false, false)
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			pAdjacentPlot:SetTerrainType(eTerrainGrass, false, false)
		end
	elseif method_number == 9 then
		-- Mt. Everest
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainMountain, false, false)
		
		local iNumMountains = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotMountain then
				iNumMountains = iNumMountains + 1
			end	
		end

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if (pAdjacentPlot:GetPlotType() == ePlotHill or pAdjacentPlot:GetPlotType() == ePlotFlat) and iNumMountains < 4 then
				pAdjacentPlot:SetPlotType(ePlotMountain, false, false)
				iNumMountains = iNumMountains + 1
			end	
			
			if pAdjacentPlot:GetTerrainType() == eTerrainGrass then
				pAdjacentPlot:SetTerrainType(eTerrainTundra, false, false)
			end

			if pAdjacentPlot:GetTerrainType() == eTerrainDesert or pAdjacentPlot:GetTerrainType() == eTerrainPlains then
				pAdjacentPlot:SetTerrainType(eTerrainSnow, false, false)
			end
		end
	elseif method_number == 10 then
		-- Lake Retba
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainPlains, false, false)

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if pAdjacentPlot:GetPlotType() ~= ePlotOcean then
				pAdjacentPlot:SetTerrainType(eTerrainPlains, false, false)
				
				if pAdjacentPlot:GetFeatureType() == eFeatureForest or pAdjacentPlot:GetFeatureType() == FeatureTypes.JUNGLE then
					pAdjacentPlot:SetFeatureType(eFeatureNo)
				end
			end
		end
	elseif method_number == 11 then
		-- reserved for Eye of the Sahara
	elseif method_number == 12 then
		-- Bermuda Triangle
		local pPlot = Map.GetPlot(x, y)
		local pSEPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHEAST)
		local pSWPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHWEST)

		pPlot:SetTerrainType(eTerrainCoast, false, false)
		pSEPlot:SetTerrainType(eTerrainCoast, false, false)
		pSWPlot:SetTerrainType(eTerrainCoast, false, false)

		pSEPlot:SetFeatureType(GameInfoTypes.FEATURE_BERMUDA_B)
		pSWPlot:SetFeatureType(GameInfoTypes.FEATURE_BERMUDA_C)
	elseif method_number == 13 then
		-- Dallol
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			pAdjacentPlot:SetFeatureType(eFeatureNo)
		end
	elseif method_number == 14 then
		-- Bioluminescent Bay
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			local pAdjacentTerrainType = pAdjacentPlot:GetTerrainType()

			if pAdjacentPlot:GetPlotType() ~= ePlotOcean then
				pAdjacentPlot:SetTerrainType(eTerrainGrass, false, false)
			end
		end
	end
end
------------------------------------------------------------------------------

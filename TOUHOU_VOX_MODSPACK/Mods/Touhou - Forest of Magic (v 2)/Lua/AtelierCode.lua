-- Based on Sukritact's SieidiCode

print("Marisa's Atelier code loaded")

include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "ForestOfMagic";
include("MischaIteratingPlotsFunctions")

--------------------------------------------------------------
-- Initial Processes
--------------------------------------------------------------

local iImprovementMushrooms = GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH

local iBuildingAtelier = GameInfoTypes.BUILDING_FOM_ATELIER

local iForest = FeatureTypes.FEATURE_FOREST
local iJungle = FeatureTypes.FEATURE_JUNGLE
local iMarsh = FeatureTypes.FEATURE_MARSH
local iCoast = TerrainTypes.TERRAIN_COAST
local iOcean = TerrainTypes.TERRAIN_OCEAN
local iDesert = TerrainTypes.TERRAIN_DESERT
local iSnow = TerrainTypes.TERRAIN_SNOW
local iTundra = TerrainTypes.TERRAIN_TUNDRA
local iMushroom1 = GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_1
local iMushroom2 = GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_2
local iMushroom3 = GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_3
local iCiv = GameInfoTypes.CIVILIZATION_TH_FOREST_OF_MAGIC


--Weirdness to ensure that it works in Multiplayer
local tMarisa = {}
for iPlayer, pPlayer in pairs(Players) do
	if (pPlayer:GetCivilizationType() == iCiv) then
		tMarisa[iPlayer] = pPlayer
	end
end

local pSave = "GAME"

--------------------------------------------------------------
-- Main Code
--------------------------------------------------------------

function MushroomPatchCode(iPlayer)
	local pPlayer = Players[iPlayer]
	local iGameTurn = Game.GetGameTurn()

	if( pPlayer:IsMinorCiv() or pPlayer:IsBarbarian() ) then
		return;
	end
	
	if ( pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_TH_FOREST_OF_MAGIC"] ) then
		return;
	end

	--print("Turn " .. iGameTurn)
    for pCity in pPlayer:Cities() do
		local strCityName = pCity:GetName()
		--print("Checking " .. strCityName)
		local pPlot = pCity:Plot()
		local iCity = pCity:GetID()
		local iTurnFounded = pCity:GetGameTurnFounded ()	--Used to Compile Unique City ID
		local iCityX = pPlot:GetX()
		local iCityY = pPlot:GetY()
		if (iGameTurn - iTurnFounded) % 30 == 0 then
			--print("Divisible by 30")
			local iMushroomCount = 0
			for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					local iImprovement = pAdjacentPlot:GetImprovementType()
					if (iImprovement == iMushroom1) or (iImprovement == iMushroom2) or (iImprovement == iMushroom3) then
						iMushroomCount = iMushroomCount + 1
					end
			end
			--print("Mushrooms found: " .. iMushroomCount)
			if (iMushroomCount < 5) then		
				local iNumtoPlace = 1
				--print("will place max " .. iNumtoPlace)
				local iNumPlaced = 0
				
				--TestPlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE, highlights.RED)
				for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if (iNumtoPlace - iNumPlaced) <= 0 then
						break
					end
					
					local iImprovement = pAdjacentPlot:GetImprovementType()
					local iResource = pAdjacentPlot:GetResourceType()
					local iTerrain = pAdjacentPlot:GetTerrainType()
					local iFeature = pAdjacentPlot:GetFeatureType()
					local iOwner = pAdjacentPlot:GetOwner()
					
					-- For tracking reasons, comment out when done
					--local iX = pAdjacentPlot:GetX()
					--local iY = pAdjacentPlot:GetY()
					--print (iX, iY)
					--print (iTerrain, iResource, iImprovement)
					
					local iBias = (Game.Rand(12, "Rolling for bias") + 1)
					--print("Base = " .. iBias)
					
					-- Slight bias against unowned tiles
					if (iOwner == -1) then
						--iBias = iBias - (GetRandom(1,3))
						--print("Unowned")
					-- Cannot be placed on owned tiles
					elseif (iOwner ~= iPlayer) then
						iBias = -100
						--print("Owned by other player")
					end
					
					-- Cannot be placed on water or mountains
					if (iTerrain == iCoast) or (iTerrain == iOcean) or (iTerrain == iDesert) or (iTerrain == iSnow) or (iTerrain == iTundra) or (pAdjacentPlot:IsMountain()) then
						iBias = -100
						--print("Is Water or Mountain")
					-- Bias for Forest, Jungle, or Marsh
					elseif (iFeature == iForest) or (iFeature == iJungle) or (iFeature == iMarsh) then
						--iBias = iBias + (GetRandom(3,6))
						iBias = iBias + (Game.Rand(4, "Rolling for terrain") + 4)
						--print("Forest, Jungle, or Marsh")
					end
				
					-- Don't replace existing Unique or Great Improvements, Landmarks are the first of these, starting at ID = 15
					-- Further additional Improvements will also have IDs greater than 15; however I'm ignoring this possibility
					if (iImprovement ~= -1) then
						iBias = -100
						--print("Is improvement")
					end
				
					-- Cannot place on Resources
					if iResource ~= -1 then
						iBias = -100
						--print("Regular resource")
					end
				
					print(iBias)
					if iBias >= 10 then
						pAdjacentPlot:SetOwner(iPlayer, iCity, true, true)
						local random = Map.Rand(3, "Random Mushroom Patch Lua")
						if random == 0 then
							pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_1)
						end
						if random == 1 then
							pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_2)
						end
						if random == 2 then
							pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_3)
						end
						iNumPlaced = iNumPlaced + 1
						--print("Placed " .. iNumPlaced)
					end
				end
				-- In the unlikely event that one still hasn't been placed
				if iNumPlaced == 0 then
					--print("None have yet been placed")
					for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						local iImprovement = pAdjacentPlot:GetImprovementType()
						local iTerrain = pAdjacentPlot:GetTerrainType()
						local iOwner = pAdjacentPlot:GetOwner()
						if (iTerrain ~= iCoast) and (iTerrain ~= iOcean) and (iTerrain ~= iDesert) and (iTerrain ~= iSnow) and (iTerrain ~= iTundra) and not(pAdjacentPlot:IsMountain()) and (iImprovement ~= -1) and (iResource ~= -1) and ((iOwner == iPlayer) or (iOwner == -1)) then
							pAdjacentPlot:SetOwner(iPlayer, iCity, true, true)
							local random = Map.Rand(3, "Random Mushroom Patch Lua")
							if random == 0 then
								pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_1)
							end
							if random == 1 then
								pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_2)
							end
							if random == 2 then
								pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_3)
							end
							--print("Placed")
							break
						end
					end
				end
			--else
			--print("true")
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(MushroomPatchCode)
--GameEvents.PlayerAdoptPolicy.Add(AtelierCode)

function AtelierCode1()
	for iPlayer, pPlayer in pairs(tMarisa) do
		AtelierCode(iPlayer)
	end
end

--Events.SerialEventCityInfoDirty.Add(AtelierCode1)


function MarisaUA1(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() == iCiv) then
		local iTeam = pPlayer:GetTeam()
		local pPlot = Map.GetPlot(iCityX, iCityY)
		local pCity = pPlot:GetPlotCity()
		local iCity = pCity:GetID()
		local iTurnFounded = pCity:GetGameTurnFounded ()	--Used to Compile Unique City ID
		local iCityX = pPlot:GetX()
		local iCityY = pPlot:GetY()
		local iCityID = tostring("Sieidi: X" .. iCityX .. "Y" .. iCityY .. "T" .. iTurnFounded)	--Unique City ID	
				local iNumtoPlace = Game.Rand(2, "Rolling for mushrooms")+2
				--print("will place max " .. iNumtoPlace)
				print("will place max " .. iNumtoPlace)
				local iNumPlaced = 0
				
				--TestPlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE, highlights.RED)
				for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if (iNumtoPlace - iNumPlaced) <= 0 then
						break
					end
					
					local iImprovement = pAdjacentPlot:GetImprovementType()
					local iResource = pAdjacentPlot:GetResourceType()
					local iTerrain = pAdjacentPlot:GetTerrainType()
					local iFeature = pAdjacentPlot:GetFeatureType()
					local iOwner = pAdjacentPlot:GetOwner()
					
					-- For tracking reasons, comment out when done
					--local iX = pAdjacentPlot:GetX()
					--local iY = pAdjacentPlot:GetY()
					--print (iX, iY)
					--print (iTerrain, iResource, iImprovement)
					
					local iBias = (Game.Rand(12, "Rolling for bias") + 1)
					--print("Base = " .. iBias)
					
					-- Slight bias against unowned tiles
					if (iOwner == -1) then
						--iBias = iBias - (GetRandom(1,3))
						--print("Unowned")
					-- Cannot be placed on owned tiles
					elseif (iOwner ~= iPlayer) then
						iBias = -100
						--print("Owned by other player")
					end
					
					-- Cannot be placed on water or mountains
					if (iTerrain == iCoast) or (iTerrain == iOcean) or (iTerrain == iDesert) or (iTerrain == iSnow) or (iTerrain == iTundra) or (pAdjacentPlot:IsMountain()) then
						iBias = -100
						--print("Is Water or Mountain")
					-- Bias for Forest, Jungle, or Marsh
					elseif (iFeature == iForest) or (iFeature == iJungle) or (iFeature == iMarsh) then
						--iBias = iBias + (GetRandom(3,6))
						iBias = iBias + (Game.Rand(4, "Rolling for terrain") + 4)
						--print("Forest, Jungle, or Marsh")
					end
				
					-- Don't replace existing Unique or Great Improvements, Landmarks are the first of these, starting at ID = 15
					-- Further additional Improvements will also have IDs greater than 15; however I'm ignoring this possibility
					if (iImprovement ~= -1) then
						iBias = -100
						--print("Is improvement")
					end
				
					-- Cannot place on Resources
					if iResource ~= -1 then
						iBias = -100
						--print("Regular resource")
					end
				
					--print("Final = " .. iBias)
					if iBias >= 11 then
						pAdjacentPlot:SetOwner(iPlayer, iCity, true, true)
						local random = Map.Rand(3, "Random Mushroom Patch Lua")
						--print("Mushroom type is " .. random)
						if random == 0 then
							pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_1)
						end
						if random == 1 then
							pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_2)
						end
						if random == 2 then
							pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_3)
						end
						iNumPlaced = iNumPlaced + 1
						--print("Placed " .. iNumPlaced)
					end
				end
				-- In the unlikely event that one still hasn't been placed
				if iNumPlaced == 0 then
					--print("None have yet been placed")
					for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						local iImprovement = pAdjacentPlot:GetImprovementType()
						local iTerrain = pAdjacentPlot:GetTerrainType()
						local iOwner = pAdjacentPlot:GetOwner()
						if (iTerrain ~= iCoast) and (iTerrain ~= iOcean) and (iTerrain ~= iDesert) and (iTerrain ~= iSnow) and (iTerrain ~= iTundra) and not(pAdjacentPlot:IsMountain()) and (iImprovement ~= -1) and (iResource ~= -1) and ((iOwner == iPlayer) or (iOwner == -1)) then
							pAdjacentPlot:SetOwner(iPlayer, iCity, true, true)
							local random = Map.Rand(3, "Random Mushroom Patch Lua")
							if random == 0 then
								pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_1)
							end
							if random == 1 then
								pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_2)
							end
							if random == 2 then
								pAdjacentPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_MUSHROOM_PATCH_3)
							end
							--print("Placed")
							break
						end
					end
				end
		end
end
GameEvents.PlayerCityFounded.Add(MarisaUA1)


-- MarisaTerrainNames
-- Author: user
-- DateCreated: 8/2/2014 11:59:26 PM
--------------------------------------------------------------

print("Marisa's City Names Lua loaded")

--
-- Pick the name of the town based on the surrounding terrain/features
--

local iCivilizationFoM = GameInfoTypes.CIVILIZATION_TH_FOREST_OF_MAGIC

include("MapmakerUtilities")
include("PlotIterators")
include("MischaIteratingPlotsFunctions")

local allPlots = {}
local ring1Plots = {}
local ring2Plots = {}

local allTerrains = {}
local ring1Terrains = {}
local ring2Terrains = {}

local allFeatures = {}
local ring1Features = {}
local ring2Features = {}

function GetCount(array, index)
  return array[index] or 0
end

function IncCount(singleArray, combinedArray, index)
    singleArray[index] = (singleArray[index] or 0) + 1
    combinedArray[index] = (combinedArray[index] or 0) + 1
end

local namingFunctions = {}

-- River
function WaterNames(pPlot)
  local sNameKey = nil

  if (pPlot:IsRiver()) then
    sNameKey = "WATER"
  end

  return sNameKey
end

-- Mountains
function MountainNames(pPlot)
  local sNameKey = nil

 if (GetCount(ring1Plots, PlotTypes.PLOT_MOUNTAIN) == 1) then
    sNameKey = "MOUNTAIN"
  end

  return sNameKey
end

-- Marsh
function MarshNames(pPlot)
  local sNameKey = nil

  if (GetCount(ring1Features, GameInfoTypes.FEATURE_MARSH) >= 1 or GetCount(ring2Features, GameInfoTypes.FEATURE_MARSH) >= 2) then
    sNameKey = "MARSH"
  end

  return sNameKey
end

-- Snow
function SnowNames(pPlot)
  local sNameKey = nil

  -- Out of six ring1 plots need two or more, or from all 18 plots, need 6 or more
  if (GetCount(ring1Terrains, GameInfoTypes.TERRAIN_TUNDRA) >= 2 or GetCount(allTerrains, GameInfoTypes.TERRAIN_TUNDRA) >= 6) or ((GetCount(ring1Terrains, GameInfoTypes.TERRAIN_SNOW) + GetCount(ring1Features, GameInfoTypes.FEATURE_ICE)) >= 2
   or (GetCount(allTerrains, GameInfoTypes.TERRAIN_SNOW) + GetCount(allFeatures, GameInfoTypes.FEATURE_ICE)) >= 6) then
    sNameKey = "SNOW"
  end

  return sNameKey
end

-- Forest
function ForestNames(pPlot)
  local sNameKey = nil

  if (GetCount(ring1Features, GameInfoTypes.FEATURE_FOREST) >= 2) or (GetCount(ring1Features, GameInfoTypes.FEATURE_JUNGLE) >= 2) then
    sNameKey = "FOREST"
  end

  return sNameKey
end

-- Desert
function DesertNames(pPlot)
  local sNameKey = nil

  if (GetCount(ring1Terrains, GameInfoTypes.TERRAIN_DESERT) >= 3) then
    sNameKey = "DESERT"
  end

  return sNameKey
end

-- Plains and Grasslands
function FieldNames(pPlot)
  local sNameKey = nil

  if (GetCount(ring1Terrains, GameInfoTypes.TERRAIN_GRASS) >= 3) or (GetCount(ring1Terrains, GameInfoTypes.TERRAIN_PLAINS) >= 3) then
    sNameKey = "FIELD"
  end

  return sNameKey
end

-- Generic
function GenericNames(pPlot)
  return "GENERIC"
end

function AnalysePlots(pPlot)
  allPlots = {}
  ring1Plots = {}
  ring2Plots = {}

  allTerrains = {}
  ring1Terrains = {}
  ring2Terrains = {}

  allFeatures = {}
  ring1Features = {}
  ring2Features = {}

  for pRingPlot in PlotRingIterator(pPlot, 1) do
    IncCount(ring1Plots, allPlots, pRingPlot:GetPlotType())
    IncCount(ring1Terrains, allTerrains, pRingPlot:GetTerrainType())
    IncCount(ring1Features, allFeatures, pRingPlot:GetFeatureType())
  end

  for pRingPlot in PlotRingIterator(pPlot, 2) do
    IncCount(ring2Plots, allPlots, pRingPlot:GetPlotType())
    IncCount(ring2Terrains, allTerrains, pRingPlot:GetTerrainType())
    IncCount(ring2Features, allFeatures, pRingPlot:GetFeatureType())
  end
end

function IsFoMCiv(iCivType)
  return (iCivType == iCivilizationFoM)
end
  
function IsFoMPlayer(iPlayer)
  return (iPlayer ~= -1 and IsFoMCiv(Players[iPlayer]:GetCivilizationType()))
end

function SetFoMCityName(pCity)
  local pPlayer = Players[pCity:GetOwner()]
  local pPlot = pCity:Plot()
  local sKeyPrefix = "TXT_KEY_FOREST_OF_MAGIC_"

  -- Base the city name on the terrain/features of surrounding plots
  AnalysePlots(pPlot)

  --local nameFunctions = GetShuffledCopyOfTable(namingFunctions)
  local nameFunctions = {}
  table.insert(nameFunctions, MarshNames)
  local random = Map.Rand(2, "Random Terrain Names Lua")
  if random == 0 then
	 table.insert(nameFunctions, MountainNames)
	 table.insert(nameFunctions, WaterNames)
  else
	 table.insert(nameFunctions, WaterNames)
	 table.insert(nameFunctions, MountainNames)
  end
  table.insert(nameFunctions, ForestNames)
  table.insert(nameFunctions, FieldNames)
  table.insert(nameFunctions, SnowNames)
  table.insert(nameFunctions, DesertNames)
  table.insert(nameFunctions, GenericNames)

  for _, fnNaming in ipairs(nameFunctions) do
    sNameKey = fnNaming(pPlot)

    if (sNameKey) then
	  --print("Key found.")
      -- Find all possible city names from the key
      local sQuery = "SELECT Tag FROM Language_en_US WHERE Tag LIKE '" .. sKeyPrefix .. sNameKey .. "%' ORDER BY RANDOM();"

      for row in DB.Query(sQuery) do
        local sNewFoMCityName = Locale.ConvertTextKey(row.Tag)
		--print("Possible name: " .. sNewFoMCityName);

        -- If the city name is available, use it
		local iNameConflict = 0
		for pCity in pPlayer:Cities() do
			if (pCity:GetName() == sNewFoMCityName) then
			    --print("Conflict found.")
				iNameConflict = 1
			end
		end
        if (iNameConflict == 0) then
		  --print("Setting city name.")
          pCity:SetName(row.Tag)
          return
        end
      end
    end
  end

  -- Just keep the game assigned name
end

function OnSetPopulation(iPlotX, iPlotY, iOldPop, iNewPop)
  -- Has this city just been founded
  if (iOldPop == 0) then
    local pCity = Map.GetPlot(iPlotX, iPlotY):GetPlotCity()

    if (IsFoMPlayer(pCity:GetOwner()) and (Players[pCity:GetOwner()]:GetCapitalCity() ~= nil)) then
	  --print("Forest of Magic city grown.")
      SetFoMCityName(pCity)
    end
  end
end
GameEvents.SetPopulation.Add(OnSetPopulation)
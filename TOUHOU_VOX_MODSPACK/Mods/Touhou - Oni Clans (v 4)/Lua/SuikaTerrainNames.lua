-- MarisaTerrainNames
-- Author: user
-- DateCreated: 8/2/2014 11:59:26 PM
--------------------------------------------------------------

print("Suika's City Names Lua loaded")

--
-- Pick the name of the town based on the surrounding terrain/features
--

local iCivilizationOni = GameInfoTypes.CIVILIZATION_TOUHOU_ONI
local iPopulationKishinFactor = 10

include("MapmakerUtilities")
include("PlotIterators")

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
function RiverNames(pPlot)
  local sNameKey = nil

  if (pPlot:IsRiver()) then
    sNameKey = "RIVER"
  end

  return sNameKey
end

-- Coast
function CoastNames(pPlot)
  local sNameKey = nil

  for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
    local pAdjacentPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)

    if (pAdjacentPlot and pAdjacentPlot:IsWater()) then
      return "COAST"
    end
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

-- Hills
function HillsNames(pPlot)
  local sNameKey = nil

  if (GetCount(ring1Plots, PlotTypes.PLOT_HILLS) > 0) then
    if (GetCount(ring1Plots, PlotTypes.PLOT_HILLS) >= 3 or GetCount(ring2Plots, PlotTypes.PLOT_HILLS) >= 5) then
      sNameKey = "HILLS"
    end
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

function IsOniCiv(iCivType)
  return (iCivType == iCivilizationOni)
end
  
function IsOniPlayer(iPlayer)
  return (iPlayer ~= -1 and IsOniCiv(Players[iPlayer]:GetCivilizationType()))
end

function SetOniCityName(pCity)
  local pPlayer = Players[pCity:GetOwner()]
  local pPlot = pCity:Plot()
  local sKeyPrefix = "TXT_KEY_ONI_CLANS_"

  -- Base the city name on the terrain/features of surrounding plots
  AnalysePlots(pPlot)

  --local nameFunctions = GetShuffledCopyOfTable(namingFunctions)
  local nameFunctions = {}
  table.insert(nameFunctions, CoastNames)
  table.insert(nameFunctions, RiverNames)
  table.insert(nameFunctions, MountainNames)
  table.insert(nameFunctions, GenericNames)

  for _, fnNaming in ipairs(nameFunctions) do
    sNameKey = fnNaming(pPlot)

    if (sNameKey) then
	  --print("Key found.")
      -- Find all possible city names from the key
      local sQuery = "SELECT Tag FROM Language_en_US WHERE Tag LIKE '" .. sKeyPrefix .. sNameKey .. "%' ORDER BY RANDOM();"

      for row in DB.Query(sQuery) do
        local sNewOniCityName = Locale.ConvertTextKey(row.Tag)
		--print("Possible name: " .. sNewOniCityName);

        -- If the city name is available, use it
		local iNameConflict = 0
		for pCity in pPlayer:Cities() do
			if (pCity:GetName() == sNewOniCityName) then
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

function OnSetOniPopulation(iPlotX, iPlotY, iOldPop, iNewPop)
  	-- Is this an Oni city?
	--print("Calling OnSetOniPopulation")
	local pCity = Map.GetPlot(iPlotX, iPlotY):GetPlotCity()
  	if (IsOniPlayer(pCity:GetOwner())) then
		--print("Oni city has changed population.")
		-- Has this city just been founded
		if (iOldPop == 0) then
			if (Players[pCity:GetOwner()]:GetCapitalCity() ~= nil) then
				--print("Non-capital city founded.")
				SetOniCityName(pCity)
			end
		else 
			if (iNewPop > iOldPop) then
				--print("Oni city has grown.")
				local pPlayer = Players[pCity:GetOwner()]
				pPlayer:ChangeCombatExperience(iPopulationKishinFactor)
				--print("Added " .. iPopulationKishinFactor .. " Great General points")
			end
		end
	end
end
GameEvents.SetPopulation.Add(OnSetOniPopulation)
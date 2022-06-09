print("Loading MutualExclusive.lua from MWfVP")
--------------------------------------------------------------
-- Mutually Exclusive groups of Wonders using CityCanConstruct event
-- Dec 14, 2017: Created, Infixo
-- Jan 12, 2020: Improved, adan_eslavo
--------------------------------------------------------------

-- debug output routine
function dprint(sStr,p1,p2,p3,p4,p5,p6)
	local sOutStr = sStr
	if p1 ~= nil then sOutStr = sOutStr.." [1] "..tostring(p1) end
	if p2 ~= nil then sOutStr = sOutStr.." [2] "..tostring(p2) end
	if p3 ~= nil then sOutStr = sOutStr.." [3] "..tostring(p3) end
	if p4 ~= nil then sOutStr = sOutStr.." [4] "..tostring(p4) end
	if p5 ~= nil then sOutStr = sOutStr.." [5] "..tostring(p5) end
	if p6 ~= nil then sOutStr = sOutStr.." [6] "..tostring(p6) end
	print(sOutStr)
end

-- replacement for CountNumBuildings which produced wrong results during tests (idk)
function CountNumBuildingsLocal(pPlayer, iWonder)
	local iTotal = 0
	
	for city in pPlayer:Cities() do
		iTotal = iTotal + city:GetNumRealBuilding(iWonder)
	end
	
	return iTotal
end

local tValidWonders = {}
local tWonderGroups = {}

-- check for exclusiveness
function CheckMutualExclusiveness(iPlayer, iCity, iBuildingType)
	if not tValidWonders[iBuildingType] then return true end
	
	local pPlayer = Players[iPlayer]
	
	if not pPlayer:IsAlive() then return false end
	
	-- check if one of the group is built
	local iGroup = tWonderGroups[iBuildingType]
	
	for wonder, group in pairs(tWonderGroups) do
		if group == iGroup and CountNumBuildingsLocal(pPlayer, wonder) > 0 then
			return false
		end
	end
	
	return true
end
GameEvents.CityCanConstruct.Add(CheckMutualExclusiveness)

function Initialize()
	-- find all valid Wonders
	for building in GameInfo.Buildings() do	
		local thisBuildingClass = GameInfo.BuildingClasses[building.BuildingClass]
		
		if thisBuildingClass.MaxGlobalInstances == 1 and building.IsCorporation == 0 and building.MutuallyExclusiveGroup > 0 then -- exclude Corporations
			dprint("...adding (id,wonder,group)", building.ID, building.Type, building.MutuallyExclusiveGroup)
			tValidWonders[building.ID] = true
			tWonderGroups[building.ID] = building.MutuallyExclusiveGroup
		end
	end
end
Initialize()

print("Loaded MutualExclusive.lua from MWfVP")
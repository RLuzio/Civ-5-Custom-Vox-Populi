print("Loading UniqueNaturalWondersAbilities.lua from MWfVP");
--------------------------------------------------------------
-- Natural Wonders Abilities
-- Dec 13, 2017: Retrofitted for Vox Populi, Infixo
-- May 11, 2020: Created, adan_eslavo
--------------------------------------------------------------
local g_tNaturalWonder = {
	GameInfoTypes["FEATURE_SALAR_A"],
	GameInfoTypes["FEATURE_SALAR_B"],
	GameInfoTypes["FEATURE_EL_DORADO"],
	GameInfoTypes["FEATURE_POTOSI"],
	GameInfoTypes["FEATURE_CRATER"],
	GameInfoTypes["FEATURE_MESA"],
	GameInfoTypes["FEATURE_SOLOMONS_MINES"],
	GameInfoTypes["FEATURE_VOLCANO"],
	GameInfoTypes["FEATURE_FUJI"],
	GameInfoTypes["FEATURE_MT_SINAI"],
	GameInfoTypes["FEATURE_GEYSER"],
	GameInfoTypes["FEATURE_MT_EVEREST"],
	GameInfoTypes["FEATURE_REEF"],
	GameInfoTypes["FEATURE_GIBRALTAR"],
	GameInfoTypes["FEATURE_LAKE_VICTORIA"],
	GameInfoTypes["FEATURE_CAUSEWAY_A"],
	GameInfoTypes["FEATURE_CAUSEWAY_B"],
	GameInfoTypes["FEATURE_RETBA"],
	GameInfoTypes["FEATURE_LUMI_BAY"],
	GameInfoTypes["FEATURE_DALLOL"]
}
local g_iWonderWithDummies = 20

local g_tNaturalWonderOwner = {}
local g_tNaturalWonderExists = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderExists[i] = false
	end

local g_tNaturalWonderSkip = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderSkip[i] = false
	end
	g_tNaturalWonderSkip[16] = true

local g_tNaturalWonderX = {}
local g_tNaturalWonderY = {}

local g_tNaturalWonderDummy = {
	GameInfoTypes["BUILDING_SALAR_A_DUMMY"],
	GameInfoTypes["BUILDING_SALAR_B_DUMMY"],
	GameInfoTypes["BUILDING_EL_DORADO_DUMMY"],
	GameInfoTypes["BUILDING_POTOSI_DUMMY"],
	GameInfoTypes["BUILDING_CRATER_DUMMY"],
	GameInfoTypes["BUILDING_MESA_DUMMY"],
	GameInfoTypes["BUILDING_SOLOMONS_MINES_DUMMY"],
	GameInfoTypes["BUILDING_VOLCANO_DUMMY"],
	GameInfoTypes["BUILDING_FUJI_1_DUMMY"],
	GameInfoTypes["BUILDING_MT_SINAI_DUMMY"],
	GameInfoTypes["BUILDING_GEYSER_DUMMY"],
	GameInfoTypes["BUILDING_MT_EVEREST_DUMMY"],
	GameInfoTypes["BUILDING_REEF_DUMMY"],
	GameInfoTypes["BUILDING_GIBRALTAR_DUMMY"],
	GameInfoTypes["BUILDING_LAKE_VICTORIA_DUMMY"],
	GameInfoTypes["BUILDING_CAUSEWAY_DUMMY"],
	GameInfoTypes["BUILDING_CAUSEWAY_DUMMY"],
	GameInfoTypes["BUILDING_RETBA_DUMMY"],
	GameInfoTypes["BUILDING_LUMI_BAY_DUMMY"],
	GameInfoTypes["BUILDING_DALLOL_DUMMY"]
}

local g_tNaturalWonderDummy2 = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderDummy2[i] = false
	end
	g_tNaturalWonderDummy2[9] = GameInfoTypes["BUILDING_FUJI_2_DUMMY"]

local g_tNaturalWonderDummy3 = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderDummy3[i] = false
	end
	g_tNaturalWonderDummy3[9] = GameInfoTypes["BUILDING_FUJI_3_DUMMY"]

-- load game and check if they exists
function CheckIfNaturalWonderExists()
	for j = 0, Map.GetNumPlots() - 1 do
		local pPlot = Map.GetPlotByIndex(j)
		local eFeature = pPlot:GetFeatureType()

		for i, feature in ipairs(g_tNaturalWonder) do
			if eFeature == feature then
				g_tNaturalWonderX[i] = pPlot:GetX()
				g_tNaturalWonderY[i] = pPlot:GetY()
				g_tNaturalWonderExists[i] = true
			end
		end
	end
end
Events.LoadScreenClose.Add(CheckIfNaturalWonderExists)

function SetDummiesForOwnedNaturalWonders(ePlayer)
	local bSkip = false

	for i, existingFeature in ipairs(g_tNaturalWonderExists) do
		if existingFeature then
			local pPlayer = Players[ePlayer]
			local bHasNaturalWonderInRange = pPlayer:CountCityFeatures(g_tNaturalWonder[i]) >= 1
			
			if bHasNaturalWonderInRange then
				g_tNaturalWonderOwner[i] = Map.GetPlot(g_tNaturalWonderX[i], g_tNaturalWonderY[i]):GetOwner()
				
				if g_tNaturalWonderOwner[i] == ePlayer then
					pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy[i], 1)

					if g_tNaturalWonderDummy2[i] then
						pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy2[i], 1)
					end

					if g_tNaturalWonderDummy3[i] then
						pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy3[i], 1)
					end
					
					bSkip = g_tNaturalWonderSkip[i]
				else
					if not bSkip then
						pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy[i], 0)

						if g_tNaturalWonderDummy2[i] then
							pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy2[i], 0)
						end

						if g_tNaturalWonderDummy3[i] then
							pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy3[i], 0)
						end
					else
						bSkip = g_tNaturalWonderSkip[i]
					end
				end
			else
				if bSkip then
					bSkip = g_tNaturalWonderSkip[i]
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(SetDummiesForOwnedNaturalWonders)
--------------------------------------------------------------
--------------------------------------------------------------
print("Loaded UniqueNaturalWondersAbilities.lua from MWfVP");
--------------------------------------------------------------
--------------------------------------------------------------

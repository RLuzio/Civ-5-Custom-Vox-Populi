print("Loading WonderChartres.lua from MWfVP");
--------------------------------------------------------------
-- Vox Populi Wonders Expanded
-- The script for Chartres Cathedral was created by Sukritact
-- Author: Infixo
-- Dec 12, 2017: Retrofitted for VP
--------------------------------------------------------------

local iMod = 0.1

local iWonder = GameInfoTypes.BUILDING_CHARTRES
local iDummy = GameInfoTypes.BUILDING_CHARTRES_DUMMY

function GetTradeRoutesToCity(pCity)

	local tCities = {}
	local pPlayer = Players[pCity:GetOwner()]

	local tTradeRoutes = pPlayer:GetTradeRoutes()
	for _, tRoute in ipairs(tTradeRoutes) do
		-- Domestic Trade Routes
		if (tRoute.ToCity == pCity) then
			tCities[ tRoute.FromCity ] = true
		end
		-- Outgoing Trade Routes
		if (tRoute.FromCity == pCity) then
			tCities[ tRoute.ToCity ] = true
		end
	end
	
	-- Incoming International Trade Routes
	local tTradeRoutes = pPlayer:GetTradeRoutesToYou()
	for _, tRoute in ipairs(tTradeRoutes) do
		if (tRoute.ToCity == pCity) then
			tCities[ tRoute.FromCity ] = true
		end
	end	
	
	return tCities
end

function GetFaithFromCities(tCities)
	local iFaith = 0
	for pCity, _ in pairs(tCities) do
		--if pCity:GetFaithPerTurn() > 0 then
		iFaith = iFaith + pCity:GetFaithPerTurn()
		--end
	end
	return math.ceil(iFaith * iMod)
end

function SetChartesDummy(pCity)
	-- City has Chartres Cathedral
	if pCity:IsHasBuilding(iWonder) then
		local tCities = GetTradeRoutesToCity(pCity)
		local iFaith = GetFaithFromCities(tCities)
		
		if pCity:GetNumRealBuilding(iDummy) ~= iFaith then
			pCity:SetNumRealBuilding(iDummy, iFaith)
		end
		
	-- City has Chartres Dummies but not Chartres Cathedral
	elseif pCity:IsHasBuilding(iDummy) then
		pCity:SetNumRealBuilding(iDummy, 0)
	end
end

function SerialEventGameDataDirty()
	local pPlayer = Players[Game.GetActivePlayer()]
	for	pCity in pPlayer:Cities() do
		SetChartesDummy(pCity)
	end
end
Events.SerialEventGameDataDirty.Add(SerialEventGameDataDirty)

function PlayerDoTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	for	pCity in pPlayer:Cities() do
		SetChartesDummy(pCity)
	end
end
GameEvents.PlayerDoTurn.Add(PlayerDoTurn)

print("Loaded WonderChartres.lua from MWfVP");
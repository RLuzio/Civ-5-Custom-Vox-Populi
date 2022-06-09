include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "ThHell";
function DelegateSubtractAndMinistryBonus(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_HELL) then return end
	local ministrycount = pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_TH_HELL_MINISTRY_OF_RIGHT_AND_WRONG)
	for city in pPlayer:Cities() do
		city:SetNumRealBuilding(GameInfoTypes.BUILDING_TH_HELL_HAPPINESS_FAITH_BOOST, 0)
	end
	local pCity = pPlayer:GetCapitalCity()
	if pCity ~= nil then
		pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_TH_HELL_HAPPINESS_FAITH_BOOST, (math.floor(ministrycount/3)))
		if pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_TH_HELL_DELEGATE_SUBTRACTOR) > 0 then return end
		pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_TH_HELL_DELEGATE_SUBTRACTOR, 1)
	end
end
function AddMinistry(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TH_HELL) then return end
	if load(pPlayer, "ThHellCityNum") == nil then
		save(pPlayer, "ThHellCityNum", 0)
	end
	local cityNum = load(pPlayer, "ThHellCityNum")
	cityNum = (cityNum + 1)
	save(pPlayer, "ThHellCityNum", cityNum)
	if cityNum < 4 then
		for pCity in pPlayer:Cities() do
			if pCity:GetOriginalOwner() == pPlayer:GetID() then
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_TH_HELL_MINISTRY_OF_RIGHT_AND_WRONG, 1)
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_TH_HELL_DELEGATE_ADDER, 1)
			end
		end
	end
	if cityNum < 2 then
		ScatterSettlers(iPlayer)
	end
end
function ScatterSettlers(iPlayer)
	local pPlayer = Players[iPlayer]
	local plot2 = RandomSettlerSpawn(pPlayer)
	RandomSettlerSpawn(pPlayer,plot2)

end
function RandomSettlerSpawn(pPlayer,plot2)
	local iW, iH = Map.GetGridSize()
	local found = false
	local judgement = true
	local n = 0
	while found == false do
		if n > ((iW+iH)*6) then judgement = false end
		n = (n+1)
		local iX = math.random(1,iW)
		local iY = math.random(1,iH)
		if Map.GetPlot(iX,iY) ~= nil then
			local targetPlot = Map.GetPlot(iX,iY)
			if targetPlot ~= nil and
			not targetPlot:IsWater() and
			not targetPlot:IsImpassable() or
			not targetPlot:GetPlotType() == PlotTypes.PLOT_MOUNTAIN then
				local cityDistance = GetAnyNearestCityDistance(targetPlot)
				local settlerDistance = GetAnyNearestSettlerDistance(targetPlot)
				if cityDistance > 7 or cityDistance == -1 or judgement == false then
					if settlerDistance > 7 or settlerDistance == -1 or judgement == false then
						local lowestCityDistance = GetDistancetoCities(pPlayer,targetPlot)
						if plot2 ~= nil then
							 lowestCityDistance = GetDistancetoCities(pPlayer,targetPlot,plot2) end
						local mX = (iW / 3)
						local mY = (iH / 3)
						local mDistance = ((mX + mY) / 2)
						local score = LocationEvaluate(targetPlot, pPlayer)
						if lowestCityDistance > mDistance and score > 49 or lowestCityDistance > mDistance and judgement == false then
							found = true
							pPlayer:InitUnit(UNIT_SETTLER,iX,iY)
							return targetPlot
						end
					end
				end
			end
		end
	end
end
--The following functions are modified from functions in SIA_Utils.lua of Rozumiyko's Settler AI Mod.
function GetAnyNearestCityDistance(plot)
	local closestCity = nil
	local closestDistance = 10000
	local num = GameDefines.MAX_PLAYERS - 1
	for id = 0, num, 1 do
		local player = Players[id]
		if player ~= nil and player:IsAlive() and not player:IsBarbarian() then
			local city, distance = GetNearestCityWithException(id, plot, -1)
			if distance < closestDistance then
				closestDistance = distance
				closestCity = city
			end
		end
	end
	return closestDistance
end
function GetNearestCityWithException(playerID, plot, exceptCity)
	local player = Players[playerID]
	local nearestDistance = 10000
	local nearestCity = nil
	for city in player:Cities() do
		if city ~= exceptCity then
			distance = Map.PlotDistance(city:GetX(), city:GetY(), plot:GetX(), plot:GetY())
			if( distance < nearestDistance) then
				nearestDistance = distance
				nearestCity = city
			end		
		end
	end
	if nearestCity == nil then nearestDistance = -1 end
	return nearestCity, nearestDistance
end
function GetAnyNearestSettlerDistance(plot)
	local closestSettler = nil
	local closestDistance = 10000
	local num = GameDefines.MAX_PLAYERS - 1
	for id = 0, num, 1 do
		local player = Players[id]
		if player ~= nil and player:IsAlive() and not player:IsBarbarian() then
			local settler, distance = GetNearestSettlerWithException(id, plot, -1)
			if distance < closestDistance then
				closestDistance = distance
				closestSettler = settler
			end	
		end	
	end
	return closestDistance
end
function GetNearestSettlerWithException(playerID, plot, exceptSettler)
	local nearestDistance = 10000
	local nearestSettler = nil
	local num = GameDefines.MAX_PLAYERS - 1
	for id = 0, num, 1 do
		local player = Players[id]
		if player ~= nil and player:IsAlive() and not player:IsBarbarian() then
			for unit in player:Units() do
				if unit:GetUnitType() == GameInfo.Units.UNIT_SETTLER.ID and unit ~= exceptSettler then
					distance = Map.PlotDistance(unit:GetX(), unit:GetY(), plot:GetX(), plot:GetY())
					if( distance < nearestDistance) then
						nearestDistance = distance
						nearestSettler = unit
					end
				end
			end	
		end
	end
	if nearestSettler == nil then nearestDistance = -1 end
	return nearestSettler, nearestDistance
end
function GetDistancetoCities(pPlayer,plot,plot2)
	local pCapital = pPlayer:GetCapitalCity()
	local distance1 = Map.PlotDistance(pCapital:GetX(), pCapital:GetY(), plot:GetX(), plot:GetY())
	if plot2 ~= nil then
		local distance2 = Map.PlotDistance(plot2:GetX(), plot2:GetY(), plot:GetX(), plot:GetY())
		if distance1 > distance2 then return distance2 end
	end
	return distance1
end
function LocationEvaluate(originPlot, player)
	if player == nil then return 0 end
	local teamID = player:GetTeam()
	if teamID < 0 then return 0 end
	
	local score = 0
	local plots = GetPlotsInArea(originPlot, 1, 3)
	for i, plot in ipairs(plots) do
		score = score + PlotEvaluate(originPlot, plot, player)
	end	
	
	return score
end
function PlotEvaluate(originPlot, plot, player)
	if plot:GetOwner() ~= -1 and plot:GetOwner() ~=playerID then return 0 end
	
	if not originPlot:IsCoastalLand() and
	   plot:IsWater() and
	   not plot:IsLake()
	   then
		return 0
	end
	
	local score = 0
	local teamID = player:GetTeam()
	score = score + CalculateTotalNatureYield(plot, player)
	score = score + EvaluateResource(plot, teamID)
	
	if originPlot:IsRiverSide() and plot:IsRiverSide() then
		score = score + 2
	end
	
	distanceToOrigin = Map.PlotDistance( originPlot:GetX(), originPlot:GetY(), plot:GetX(), plot:GetY() )
	if distanceToOrigin == 3 then score = score / 2 end
	if distanceToOrigin == 2 then score = score * 3/4 end
	
	return score
end
function GetPlotsInArea(centralPlot, minRadius, maxRadius)
	if centralPlot == nil then return nil end

	local plots = {}
	local w, h = Map.GetGridSize()
	local xMin = centralPlot:GetX() - maxRadius
	local xMax = centralPlot:GetX() + maxRadius
	local yMin = centralPlot:GetY() - maxRadius
	local yMax = centralPlot:GetY() + maxRadius
	
	for y = yMin, yMax, 1 do
		if Map.IsWrapY() then y = y % h end
		for x = xMin, xMax, 1 do
			if Map.IsWrapX() then x = x % w end
			local plot = Map.GetPlot( x, y )
			if plot ~= nil then
				local distance = Map.PlotDistance( x, y, centralPlot:GetX(), centralPlot:GetY() )
				if distance >= minRadius and distance <= maxRadius then
					table.insert( plots, plot )
				end
			end
		end
	end
	
	return plots
end
function EvaluateResource(plot, teamID)
	if plot == nil then return 0 end
	local rt = plot:GetNonObsoleteResourceType(teamID)
	if rt == -1 then return 0 end
	local ut = Game.GetResourceUsageType(rt)
	if ut == -1 then return 0 end
	
	if ut == ResourceUsageTypes.RESOURCEUSAGE_BONUS then
		return 3
	end
	
	if ut == ResourceUsageTypes.RESOURCEUSAGE_LUXURY then
		return 10
	end
	
	if ut == ResourceUsageTypes.RESOURCEUSAGE_STRATEGIC then
		return plot:GetNumResource() * 2
	end
	
	return 0
end
function CalculateTotalNatureYield(plot, player)
	if player == nil then return 0 end
	local teamID = player:GetTeam()
	local total = 0
	
	local num = YieldTypes.NUM_YIELD_TYPES - 1
	for i = 0, num, 1 do
		total = total + plot:CalculateNatureYield(i, teamID, false)
	end
	return total
end
GameEvents.PlayerDoTurn.Add(DelegateSubtractAndMinistryBonus)
GameEvents.PlayerCityFounded.Add(AddMinistry)
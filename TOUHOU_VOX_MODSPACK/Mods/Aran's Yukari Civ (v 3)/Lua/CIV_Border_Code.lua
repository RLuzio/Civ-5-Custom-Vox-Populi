-- CIV_Border_Code
-- Author: aranicar
-- DateCreated: 10/23/2015 10:07:24 PM
--------------------------------------------------------------

local borderCiv = GameInfoTypes.CIVILIZATION_BORDER

local bPromotion = GameInfoTypes.PROMOTION_BLESSINGS_OF_THE_BORDER

local directions = {DirectionTypes.DIRECTION_NORTHEAST, DirectionTypes.DIRECTION_EAST,
					DirectionTypes.DIRECTION_SOUTHEAST, DirectionTypes.DIRECTION_SOUTHWEST,
					DirectionTypes.DIRECTION_WEST, DirectionTypes.DIRECTION_NORTHWEST}

local prevTiles = -1
local divider = 1.5

print("==========Yukari Loaded==========")

function updateText(number)
	if number ~= prevTiles then
		--print("Updating text:", number)
		local message = string.format("+%.1f%% [ICON_STRENGTH] Strength.  Currently [COLOR_POSITIVE_TEXT]%d[ENDCOLOR] tiles border other nations.", number/divider, number)
		for option in DB.Query("UPDATE Language_en_US SET Text = ? WHERE Tag = 'TXT_KEY_PROMOTION_BLESSINGS_OF_THE_BORDER_HELP'", message) do
		end
		Locale.SetCurrentLanguage(Locale.GetCurrentLanguage().Type)
		prevTiles = number
	end
end

function updateUnits(player, number)
	number = (number/(divider*100)) + 1
	for unit in player:Units() do
		if unit:IsHasPromotion(bPromotion) then
			local strength = GameInfo.Units[unit:GetUnitType()].Combat
			local rangedS = GameInfo.Units[unit:GetUnitType()].RangedCombat
			--print(strength, rangedS)
			--print("modifying values")
			strength = math.ceil(strength*number)
			rangedS = math.ceil(rangedS*number)
			--print(strength, rangedS)
			unit:SetBaseCombatStrength(strength)
		end
	end
end

function updateTileNumber(playerID, player)
	local tiles = 0
	for iPlot = 0, Map.GetNumPlots() - 1 do
		local plot = Map.GetPlotByIndex(iPlot)
		if plot:GetOwner() == playerID then
			for j = 1, 6 do
				local direction = directions[j]
				local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction)
				-- print(adjPlot:IsOwned(), adjPlot:GetOwner() == playerID)
				if adjPlot:IsOwned() and adjPlot:GetOwner() ~= playerID then
					tiles = tiles + 1
					break
				end
			end
		end
	end
	--print("done map parse:", tiles)
	
	updateText(tiles)
	updateUnits(player, tiles)
end

function updateBorderBonus(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == borderCiv then
		updateTileNumber(playerID, player)
	end
end
GameEvents.PlayerDoTurn.Add(updateBorderBonus)

function initBorderBonus()
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[i]
		if player:IsEverAlive() and player:GetCivilizationType() == borderCiv then
			updateTileNumber(i, player)
			break
		end
	end
end
Events.SequenceGameInitComplete.Add(initBorderBonus)
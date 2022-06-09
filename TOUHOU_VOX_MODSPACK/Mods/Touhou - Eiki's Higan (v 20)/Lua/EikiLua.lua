local iShinigami = GameInfoTypes.UNIT_SHINIGAMI
local iShinigamiPromotion = GameInfoTypes.PROMOTION_SHINIGAMI
local iRequiredCiv = GameInfoTypes.CIVILIZATION_HIGAN
local iYamaPunishment = GameInfoTypes.BUILDING_YAMA_JUDGEMENT_PUNISHMENT_DUMMY
local iYamaReward = GameInfoTypes.BUILDING_YAMA_JUDGEMENT_REWARD_DUMMY
local iYamaJudgementBonus10Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_10
local iYamaJudgementBonus9Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_9
local iYamaJudgementBonus8Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_8
local iYamaJudgementBonus7Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_7
local iYamaJudgementBonus6Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_6
local iYamaJudgementBonus5Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_5
local iYamaJudgementBonus4Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_4
local iYamaJudgementBonus3Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_3
local iYamaJudgementBonus2Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_2
local iYamaJudgementBonus1Promotion = GameInfoTypes.PROMOTION_YAMA_JUDGEMENT_BONUS_1
local GameSpeed = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100)

print("EikiLua successfully loaded.")

-------------------------------------------------------------------------------------------------------------------------
-- GetStrongestMilitaryUnit
-------------------------------------------------------------------------------------------------------------------------
function GetStrongestMilitaryUnitStrength(pPlayer, bIgnoreResources, ...)
	local tUnit = {["Combat"] = 0}
	for iKey, sCombatType in pairs(arg) do
		for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
			if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
				tUnit = row
			end
		end
	end
	return tUnit.Combat
end

function ShinigamiStrength(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:IsAlive()) then
		for pUnit in pPlayer:Units() do
			if (pUnit:IsHasPromotion(iShinigamiPromotion)) then
				local iBaseCombatStrength = GetStrongestMilitaryUnitStrength(pPlayer, false, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
				pUnit:SetBaseCombatStrength(iBaseCombatStrength)
			end
		end		
	end
end
GameEvents.PlayerAdoptPolicy.Add(ShinigamiStrength);
GameEvents.PlayerDoTurn.Add(ShinigamiStrength);

function ShinigamiStrengthIndiv(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
		if pPlayer:GetUnitByID(iUnit) ~= nil then
			pUnit = pPlayer:GetUnitByID(iUnit);
 			if (pUnit:IsHasPromotion(iShinigamiPromotion)) then
				local iBaseCombatStrength = GetStrongestMilitaryUnitStrength(pPlayer, false, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
				pUnit:SetBaseCombatStrength(iBaseCombatStrength)
			end
        end
    end
end
Events.SerialEventUnitCreated.Add(ShinigamiStrengthIndiv)

-------------------------------------------------------------------------------------------------------------------------
-- GetYamaID
-------------------------------------------------------------------------------------------------------------------------
function GetYamaID()
	for iPlayer, pPlayer in pairs(Players) do
		if (pPlayer:IsEverAlive()) and (pPlayer:GetCivilizationType() == iRequiredCiv) then 
			return iPlayer
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------
-- GetYamaPlayer
-------------------------------------------------------------------------------------------------------------------------
function GetYamaPlayer()
	for iPlayer, pPlayer in pairs(Players) do
		if (pPlayer:IsEverAlive()) and (pPlayer:GetCivilizationType() == iRequiredCiv) then 
			return pPlayer
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------
-- GetMoneyFromDeath
-------------------------------------------------------------------------------------------------------------------------

-- Courtesy of Pazyryk of CivFanatics
local iW, iH = Map.GetGridSize()
local bWrapX, bWrapY = Map.IsWrapX(), Map.IsWrapY()
local yOffsets, xOffsetsEvenY, xOffsetsOddY = {}, {}, {}	--contain tables indexed by radius; created and kept as needed
local tempIdx, sortedOffsetsX, sortedOffsetsY = {}, {}, {}	--used for sorting when approach plot given (indexed by radius; created and kept as needed)

function PlotToRadiusIterator(x, y, radius, myX, myY)
	-- last 2 args (optional & expensive) specify an "approach" coordinate that will cause return values to be sorted by nearest-first
	local Distance = Map.PlotDistance
	local Floor = math.floor
	local yOffset = yOffsets[radius]
	if not yOffset then	--calculate and keep offsets for this radius (radius up to half map size)
		local centerX = Floor(iW / 2)
		local centerYeven = Floor(iH / 4) * 2
		local centerYodd = centerYeven + 1
		local evenPos, oddPos = 1, 1
		yOffsets[radius], xOffsetsEvenY[radius], xOffsetsOddY[radius] = {}, {}, {}
		for testYoffset = -radius, radius do
			local testYeven = centerYeven + testYoffset
			local testYodd = centerYodd + testYoffset
			for textXoffset = -radius, radius do
				local testX = centerX + textXoffset
				if Distance(centerX, centerYeven, testX, testYeven) <= radius then
					xOffsetsEvenY[radius][evenPos] = textXoffset
					yOffsets[radius][evenPos] = testYoffset
					evenPos = evenPos + 1
				end
				if Distance(centerX, centerYodd, testX, testYodd) <= radius then
					xOffsetsOddY[radius][oddPos] = textXoffset
					oddPos = oddPos + 1
				end
			end
		end
		yOffset = yOffsets[radius]
	end

	local xOffset
	if y % 2 == 0 then -- y is even
		xOffset = xOffsetsEvenY[radius]
	else				 -- y is odd
		xOffset = xOffsetsOddY[radius]
	end

	local number = #yOffset
	if myX then		--sort returned values by direction I am comming from
		local Sort = table.sort
		local sortIdx, sortX, sortY = tempIdx[radius], sortedOffsetsX[radius], sortedOffsetsY[radius]
		if not sortIdx then
			sortIdx, sortX, sortY = {}, {}, {}
			tempIdx[radius], sortedOffsetsX[radius], sortedOffsetsY[radius] = sortIdx, sortX, sortY
			for i = 1, number do
				sortIdx[i] = i
			end
		end

		Sort(sortIdx, function(a, b)
							local Distance = Map.PlotDistance
							local myX, myY, xOffset, yOffset = myX, myY, xOffset, yOffset
							return Distance(myX, myY, x + xOffset[a], y + yOffset[a]) < Distance(myX, myY, x + xOffset[b], y + yOffset[b])
						end)
		for i = 1, number do
			local sortIndex = sortIdx[i]
			sortX[i] = xOffset[sortIndex]
			sortY[i] = yOffset[sortIndex]
		end
		xOffset, yOffset = sortX, sortY		--use sorted table instead of unsorted table
	end

	local i = 0
	return function()
		local x, y, bWrapX, bWrapY, number, xOffest, yOffset = x, y, bWrapX, bWrapY, number, xOffest, yOffset	--for speed
		while i < number do
			i = i + 1
			local xAdj = x + xOffset[i]
			local yAdj = y + yOffset[i]
			if bWrapX then
				if xAdj < 0 then
					xAdj = xAdj + iW
				elseif xAdj >= iW then
					xAdj = xAdj - iW
				end
			end
			if bWrapY then
				if yAdj < 0 then
					yAdj = yAdj + iH
				elseif yAdj >= iH then
					yAdj = yAdj - iH
				end
			end
			if yAdj >= 0 and yAdj < iH and xAdj >= 0 and xAdj < iW then		--only return a valid map coordinant
				return xAdj, yAdj
			end
		end
	end
end
--

function GetMoneyFromDeath(blank1, blank2, blank3, iCenterX, iCenterY, blank4, iKillingPlayer)
	if (iKillingPlayer == -1) then
		return
	end
	for iPlayer, pPlayer in pairs(Players) do
		if pPlayer:IsAlive() then
			for x, y in PlotToRadiusIterator(iCenterX, iCenterY, 3) do
			--x, y for plots at radius 3 to center
				local iStatus = false
				local pPlot = Map.GetPlot(x, y)
				for i = 0, pPlot:GetNumUnits() - 1 do
					local pUnit = pPlot:GetUnit(i)
					if pUnit ~= nil and (pUnit:IsHasPromotion(iShinigamiPromotion)) then
						if pUnit:GetOwner() == iPlayer then
							local iCurrentEra = pPlayer:GetCurrentEra()
							pPlayer:ChangeGold(20 * (iCurrentEra + 1) * GameSpeed)
							iStatus = true
							break -- ends search on current plot
						end
					end
				end
				if iStatus == true then
					break -- ends the iteration
				end
			end
		end
	end
end
GameEvents.UnitPrekill.Add(GetMoneyFromDeath);

-------------------------------------------------------------------------------------------------------------------------
-- Punishment
-------------------------------------------------------------------------------------------------------------------------
function DenouncedByYama(pPlayer)
	local yama = GetYamaPlayer()
	local iPlayer = pPlayer:GetID()
	if (yama == nil) then
		return false
	end
	if (pPlayer:IsEverAlive() and yama:IsDenouncedPlayer(iPlayer)) then
		return true
	else
		return false
	end
end

function YamaPunishment(iPlayer)
	local pPlayer = Players[iPlayer]
	local iPopulationSum = 0
	local iNumOfCity = 0
	if (pPlayer:IsAlive()) and (DenouncedByYama(pPlayer)) then
		for pCity in pPlayer:Cities() do
			iPopulationSum = pCity:GetPopulation() + iPopulationSum
			iNumOfCity = iNumOfCity + 1
			pCity:SetNumRealBuilding(iYamaPunishment, 0)
		end
		local iMilitaryUnits = pPlayer:GetNumMilitaryUnits()
		local iCapital = pPlayer:GetCapitalCity()
		local iTotal = math.floor((iPopulationSum / 4) + iMilitaryUnits*2 + iNumOfCity*3)
		iCapital:SetNumRealBuilding(iYamaPunishment, iTotal)
	else
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(iYamaPunishment, 0)
		end
	end
end

GameEvents.PlayerDoTurn.Add(YamaPunishment);
Events.SerialEventUnitDestroyed.Add(YamaPunishment);
Events.SerialEventUnitCreated.Add(YamaPunishment);


function YamaPunishmentUpdate1(hexPos, iPlayer, pCity, iPlayer_new)
	YamaPunishment(iPlayer)
	YamaPunishment(iPlayer_new)
end

Events.SerialEventCityCaptured.Add(YamaPunishmentUpdate1);


function YamaPunishmentUpdate2(vHexPos, iPlayer)
	YamaPunishment(iPlayer)
end

Events.SerialEventCityCreated.Add(YamaPunishmentUpdate2);

-------------------------------------------------------------------------------------------------------------------------
-- Combat Bonus
-------------------------------------------------------------------------------------------------------------------------
function CountFollowerDenouncements(pPlayer)
	local iCount = 0
	local iPlayer = pPlayer:GetID()
	local yamaID = GetYamaID()
	if (yamaID == nil) then
		return 0
	end
	if (pPlayer:IsEverAlive() and DenouncedByYama(pPlayer)) then 
		for iPlayer2, pPlayer2 in pairs(Players) do
			if (pPlayer2:IsDenouncedPlayer(iPlayer) and not pPlayer2:IsDenouncedPlayer(yamaID)) then
				iCount = iCount + 1
			end
		end
	end
	if iCount > 10 then -- Adds a cap to the bonus
		iCount = 10
	end
	return iCount
end

function YamaCombatBonus(iYama)
	local pYama = Players[iYama]
	local iDenouncementsLargest = 0
	if (pYama:IsEverAlive() and pYama:GetCivilizationType() == iRequiredCiv) then
		for iPlayer, pPlayer in pairs(Players) do
			local iDenouncements = CountFollowerDenouncements(pPlayer)
			if (iDenouncementsLargest <= iDenouncements) then
				for pUnit in pYama:Units() do
					iDenouncementsLargest = iDenouncements
					if iDenouncements == 1 then
						pUnit:SetHasPromotion(iYamaJudgementBonus1Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus1Promotion, false)
					end
					if iDenouncements == 2 then
						pUnit:SetHasPromotion(iYamaJudgementBonus2Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus2Promotion, false)
					end
					if iDenouncements == 3 then
						pUnit:SetHasPromotion(iYamaJudgementBonus3Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus3Promotion, false)
					end
					if iDenouncements == 4 then
						pUnit:SetHasPromotion(iYamaJudgementBonus4Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus4Promotion, false)
					end
					if iDenouncements == 5 then
						pUnit:SetHasPromotion(iYamaJudgementBonus5Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus5Promotion, false)
					end
					if iDenouncements == 6 then
						pUnit:SetHasPromotion(iYamaJudgementBonus6Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus6Promotion, false)
					end
					if iDenouncements == 7 then
						pUnit:SetHasPromotion(iYamaJudgementBonus7Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus7Promotion, false)
					end
					if iDenouncements == 8 then
						pUnit:SetHasPromotion(iYamaJudgementBonus8Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus8Promotion, false)
					end
					if iDenouncements == 9 then
						pUnit:SetHasPromotion(iYamaJudgementBonus9Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus9Promotion, false)
					end
					if iDenouncements == 10 then
						pUnit:SetHasPromotion(iYamaJudgementBonus10Promotion, true)
					else
						pUnit:SetHasPromotion(iYamaJudgementBonus10Promotion, false)
					end
				end
			end
		end
	elseif (pYama:IsEverAlive() and pYama:GetCivilizationType() ~= iRequiredCiv) then
		for pUnit in pYama:Units() do
			pUnit:SetHasPromotion(iYamaJudgementBonus1Promotion, false)
			pUnit:SetHasPromotion(iYamaJudgementBonus2Promotion, false)
			pUnit:SetHasPromotion(iYamaJudgementBonus3Promotion, false)
			pUnit:SetHasPromotion(iYamaJudgementBonus4Promotion, false)
			pUnit:SetHasPromotion(iYamaJudgementBonus5Promotion, false)
			pUnit:SetHasPromotion(iYamaJudgementBonus6Promotion, false)
			pUnit:SetHasPromotion(iYamaJudgementBonus7Promotion, false)
			pUnit:SetHasPromotion(iYamaJudgementBonus8Promotion, false)
			pUnit:SetHasPromotion(iYamaJudgementBonus9Promotion, false)
			pUnit:SetHasPromotion(iYamaJudgementBonus10Promotion, false)
		end
	end
end
GameEvents.PlayerDoTurn.Add(YamaCombatBonus)
Events.SerialEventUnitCreated.Add(YamaCombatBonus);

-------------------------------------------------------------------------------------------------------------------------
-- Reward
-------------------------------------------------------------------------------------------------------------------------

function YamaReward(iYama)
	local pYama = Players[iYama]
	local iDenouncementsLargest = 0
	if pYama:IsEverAlive() then
		for pCity in pYama:Cities() do
			pCity:SetNumRealBuilding(iYamaReward, 0)
		end
		if pYama:GetCivilizationType() == iRequiredCiv then
			for iPlayer, pPlayer in pairs(Players) do
				local iDenouncements = CountFollowerDenouncements(pPlayer)
				if (iDenouncementsLargest <= iDenouncements) then
					iDenouncementsLargest = iDenouncements
					local pCapital = pYama:GetCapitalCity()
					pCapital:SetNumRealBuilding(iYamaReward, iDenouncements)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(YamaReward)

-------------------------------------------------------------------------------------------------------------------------
-- ShinigamiGoldenAge
-------------------------------------------------------------------------------------------------------------------------
function CanTrainShinigami(iPlayer, iUnitType)
	local pPlayer = Players[iPlayer]
	if iUnitType == iShinigami and pPlayer:IsEverAlive() then
		if pPlayer:GetCivilizationType() ~= iRequiredCiv then
			return false
		else
			if pPlayer:IsGoldenAge() then	
				return true
			else		
				return false
			end
		end
	else
		return true
	end
end
GameEvents.PlayerCanTrain.Add(CanTrainShinigami)

-------------------------------------------------------------------------------------------------------------------------
-- AtLeastOneShinigami
-------------------------------------------------------------------------------------------------------------------------
function GuaranteedShinigami(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		if Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_CURRENCY) and pPlayer:GetCivilizationType() == iRequiredCiv then
			local pCity = pPlayer:GetCapitalCity()
			local bExist = false
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitType() == iShinigami then
					bExist = true
					break
				end
			end
			if pCity and not bExist then
				if pPlayer:GetGold() >= (200 * GameSpeed) then
					pPlayer:SetGold(pPlayer:GetGold() - (200 * GameSpeed))
					pPlayer:InitUnit(iShinigami, pCity:GetX(), pCity:GetY())
					sNotificationString = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HIGAN_GUARANTEED_SHINIGAMI_TEXT", 200 * GameSpeed)
					sNotificationTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HIGAN_GUARANTEED_SHINIGAMI_TITLE")
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sNotificationString, sNotificationTitle, -1, -1)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(GuaranteedShinigami)
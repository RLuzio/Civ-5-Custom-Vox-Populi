-- JoonLua
-- Author: Igniszath
-- DateCreated: 1/30/2019 10:58:07 AM
--------------------------------------------------------------
print("You can't pay back what you owe with money.")

local iRequiredCiv = GameInfoTypes.CIVILIZATION_TOUHOU_PESTILENCE
local iNeighborRange = 10
local iLoanSharkDecision = GameInfoTypes.POLICY_LOAN_SHARK_DUMMY

local iSwindlerDen = GameInfoTypes.BUILDING_SWINDLER_DEN
local iSwindlerSteal = GameInfoTypes.BUILDING_SWINDLER_STEAL_DUMMY
local iSwindlerLoot = GameInfoTypes.BUILDING_SWINDLER_LOOT_DUMMY
local iSwindlerRange = 10

include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "Touhou_Pestilence";

-------------------------------------------------------------------------------------------------------------------------
-- Utilities
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

-------------------------------------------------------------------------------------------------------------------------
-- TraitDebt
-------------------------------------------------------------------------------------------------------------------------
function GetLiveJoonPlayer()
	for iPlayer, pPlayer in pairs(Players) do
		if (pPlayer:IsAlive()) and (pPlayer:GetCivilizationType() == iRequiredCiv) then 
			return pPlayer
		end
	end
end

function TouhouPestilenceEnemy(pSubject)
	local pJoon = GetLiveJoonPlayer()
	local pTeam = Teams[pSubject:GetTeam()]
	if pJoon == nil then return false end
	if pTeam:IsAtWar(pJoon:GetTeam()) then
		return true
	else
		return false
	end
end

function TouhouPestilenceNeighbors(pSubject)
	local pJoon = GetLiveJoonPlayer()
	if pJoon == nil then return false end
	for pCity in pSubject:Cities() do
		local pCityPlot = pCity:Plot()
		for x, y in PlotToRadiusIterator(pCityPlot:GetX(), pCityPlot:GetY(), iNeighborRange) do
			local pPlot = Map.GetPlot(x, y)
			local pTargetCity = pPlot:GetPlotCity()
			if pTargetCity ~= nil then
				if Players[pTargetCity:GetOwner()]:GetCivilizationType() == iRequiredCiv then
					return true
				end
			end
		end
	end
	return false
end

function IsExtortedByJoon(pSubject)
	local pJoon = GetLiveJoonPlayer()
	if pJoon == nil then return false end
	for pCity in pSubject:Cities() do
		local pCityPlot = pCity:Plot()
		for x, y in PlotToRadiusIterator(pCityPlot:GetX(), pCityPlot:GetY(), 1) do
			local pPlot = Map.GetPlot(x, y)
			for i = 0, pPlot:GetNumUnits() - 1 do
				local pUnit = pPlot:GetUnit(i)
				if pUnit ~= nil then
					if pUnit:GetOwner() == pJoon:GetID() and pUnit:IsCombatUnit() then
						return true
					end
				end
			end
		end
	end
	return false
end

function PayJoonPlayer(iValue, sPlayerName, iRemainingDebt)
	local pPlayer = GetLiveJoonPlayer()
	if pPlayer == nil then return end
	pPlayer:ChangeGold(iValue)
	if iRemainingDebt == 0 then
		sNotificationString = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_DEBT_PAYMENT_TEXT", iValue, sPlayerName)
		sNotificationTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_DEBT_PAYMENT_TITLE")
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sNotificationString, sNotificationTitle, -1, -1)
	else
		sNotificationString = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_DEBT_PAYMENT_CANNOT_PAY_TEXT", iValue, sPlayerName, iRemainingDebt)
		sNotificationTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_DEBT_PAYMENT_TITLE")
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sNotificationString, sNotificationTitle, -1, -1)
	end
end

function TouhouPestilenceDebt(iPlayer)
	local pPlayer = Players[iPlayer]
	local pJoon = GetLiveJoonPlayer()
	if (pPlayer:IsAlive()) then
		if load(pPlayer, "TouhouPestilenceDebt") == Game.GetGameTurn() then return end -- Check to ensure this function is only ran once per turn

		local iDebt = 0 -- Default value in case value cannot be loaded
		if load(pPlayer, "TouhouPestilenceDebtAmount") ~= nil then
			iDebt = load(pPlayer, "TouhouPestilenceDebtAmount")
		end
		if TouhouPestilenceEnemy(pPlayer) and TouhouPestilenceNeighbors(pPlayer) then
			--Add to debt
			if (IsExtortedByJoon(pPlayer)) then
				iDebt = iDebt + (pPlayer:CalculateGrossGold() / 4)
			else
				iDebt = iDebt + (pPlayer:CalculateGrossGold() / 10)
			end
		end
		if iDebt ~= 0 and pJoon ~= nil then
			--Attempt to pay debt
			local iGold = pPlayer:GetGold()
			if iGold >= iDebt then -- Player is able to pay off the debt completely
				pPlayer:ChangeGold(-iDebt)
				PayJoonPlayer(iDebt, pPlayer:GetName(), 0)

				sNotificationString = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_DEBT_TEXT", iDebt)
				sNotificationTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_DEBT_TITLE")
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sNotificationString, sNotificationTitle, -1, -1)

				iDebt = 0
			else -- Player could not pay off the debt
				pPlayer:SetGold(0)
				iDebt = iDebt - iGold

				if pJoon:HasPolicy(iLoanSharkDecision) then -- If the loan shark decision has been made
					iDebt = iDebt * 1.2
				end

				PayJoonPlayer(iGold, pPlayer:GetName(), iDebt)

				sNotificationString = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_DEBT_CANNOT_PAY_TEXT", iGold, iDebt)
				sNotificationTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_TOUHOU_PESTILENCE_DEBT_TITLE")
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sNotificationString, sNotificationTitle, -1, -1)
			end
		end
		save(pPlayer, "TouhouPestilenceDebtAmount", iDebt)

		save(pPlayer, "TouhouPestilenceDebt", Game.GetGameTurn()) -- Indicates the player has attempted to pay the debt this turn
	end
end
GameEvents.PlayerDoTurn.Add(TouhouPestilenceDebt)

-------------------------------------------------------------------------------------------------------------------------
-- SwindlerDen
-------------------------------------------------------------------------------------------------------------------------
function SwindlerDenReset()
	for iPlayer, pPlayer in pairs(Players) do
		if pPlayer:IsEverAlive() then
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(iSwindlerSteal, 0)
				pCity:SetNumRealBuilding(iSwindlerLoot, 0)
			end
		end
	end
end

function SwindlerDenEffect(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iRequiredCiv then
		SwindlerDenReset()
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iSwindlerDen) then
				local pCityPlot = pCity:Plot()
				for x, y in PlotToRadiusIterator(pCityPlot:GetX(), pCityPlot:GetY(), iSwindlerRange) do
					local pPlot = Map.GetPlot(x, y)
					local pTargetCity = pPlot:GetPlotCity()
					if pTargetCity ~= nil then
						if Players[pTargetCity:GetOwner()]:GetCivilizationType() ~= iRequiredCiv then
							pTargetCity:SetNumRealBuilding(iSwindlerSteal, pTargetCity:GetNumBuilding(iSwindlerSteal) + 1)
							pCity:SetNumRealBuilding(iSwindlerLoot, pCity:GetNumBuilding(iSwindlerLoot) + 1)
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(SwindlerDenEffect)
GameEvents.CityConstructed.Add(SwindlerDenEffect)
GameEvents.CitySoldBuilding.Add(SwindlerDenEffect)
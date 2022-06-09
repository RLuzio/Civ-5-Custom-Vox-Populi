-- CIV_Doll_ImprovementCode
-- Author: aranicar
-- DateCreated: 7/6/2015 6:01:37 PM
--------------------------------------------------------------

-- used bouncymischa's Marisa as reference
local dollPolicy = GameInfoTypes.POLICY_DOLL
local nonDollPolicy = GameInfoTypes.POLICY_NONDOLL
local dollPolicyTech = GameInfoTypes.POLICY_DOLL_MACHINERY

local dollCiv = GameInfoTypes.CIVILIZATION_DOLL

local promotion = GameInfoTypes.PROMOTION_DOLLHOUSE_DEFENSE
local improvement = GameInfoTypes.IMPROVEMENT_DOLLHOUSE

local dollTech = GameInfoTypes.TECH_MACHINERY

print("==========Alice Loaded==========")

function setDollPolicies()
	--print("Set Doll Policies")
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[i]
		if player:IsEverAlive() then
			-- print(player:GetCivilizationType(), player:GetName())
			if player:GetCivilizationType() == dollCiv then
				if not player:HasPolicy(dollPolicy) then
					player:SetNumFreePolicies(1)
					player:SetHasPolicy(dollPolicy, true)
					player:SetNumFreePolicies(0)
					--print("Set to DOLL")
				end
			else
				if not player:HasPolicy(nonDollPolicy) then
					player:SetNumFreePolicies(1)
					player:SetHasPolicy(nonDollPolicy, true)
					player:SetNumFreePolicies(0)
					--print("Set to NONDOLL")
				end
			end
		end
	end
	-- print("End Doll Policies")
end
Events.SequenceGameInitComplete.Add(setDollPolicies)

function setPolicies(playerID)
	-- print("Set Tech Policies")
	local player = Players[playerID]
	local team = Teams[player:GetTeam()]
	if player:IsEverAlive() and not team:IsMinorCiv() then
		-- print(player:GetCivilizationType(), player:GetName())
		if player:GetCivilizationType() == dollCiv then
			if not player:HasPolicy(dollPolicyTech) and team:IsHasTech(dollTech) then
				player:SetNumFreePolicies(1)
				player:SetHasPolicy(dollPolicyTech, true)
				player:SetNumFreePolicies(0)
				--print("Set to DOLLTECH")
			end
		end
	end
	-- print("End Policies")
end
GameEvents.PlayerDoTurn.Add(setPolicies)

function setDollBonusDef(playerID, unitID, x, y)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == dollCiv and x > 0 and y > 0 then
		local unit = player:GetUnitByID(unitID)
		-- print(player:GetName(), unit:GetName(),"at",x,y)
		if unit:GetUnitCombatType() >= 0 then
			if unit:GetPlot():GetImprovementType() == improvement then
				if not unit:IsHasPromotion(promotion) then
					unit:SetHasPromotion(promotion, true)
					-- print("Assigned Promotion")
				end
			else
				if unit:IsHasPromotion(promotion) then
					unit:SetHasPromotion(promotion, false)
					-- print("Revoked Promotion")
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(setDollBonusDef)

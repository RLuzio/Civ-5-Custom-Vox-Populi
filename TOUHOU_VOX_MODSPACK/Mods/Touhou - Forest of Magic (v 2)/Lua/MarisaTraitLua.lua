-- MarisaTraitLua
-- Author: user
-- DateCreated: 7/1/2014 9:58:45 PM
--------------------------------------------------------------
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
--Marisa UA
----------------------------------------------------------------------------------------------------------------------------
local iPrereq1 = GameInfo.Technologies["TECH_METAL_CASTING"].ID
local iPrereq2 = GameInfo.Technologies["TECH_FERTILIZER"].ID

function InitMarisa(player)
	print ("Marisa Mushroom Magic Lua activated")
	for playerID, player in pairs(Players) do
		local player = Players[playerID];
		if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_TH_FOREST_OF_MAGIC"] then
			if not player:HasPolicy(GameInfoTypes["POLICY_FOM_MUSHROOMS_1"]) then
				player:SetNumFreePolicies(1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy(GameInfoTypes["POLICY_FOM_MUSHROOMS_1"], true)	
			end
		end
	end 
end
Events.SequenceGameInitComplete.Add(InitMarisa)

function MarisaMushroomMagicCheck(playerID)
	local player = Players[playerID]
	if player:IsAlive() and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_TH_FOREST_OF_MAGIC"] then
		local teamID = player:GetTeam();
		local pTeam = Teams[teamID];
		if (pTeam:IsHasTech(iPrereq1)) and not player:HasPolicy(GameInfoTypes["POLICY_FOM_MUSHROOMS_2"]) then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(GameInfoTypes["POLICY_FOM_MUSHROOMS_2"], true)	
		end
		if (pTeam:IsHasTech(iPrereq2)) and not player:HasPolicy(GameInfoTypes["POLICY_FOM_MUSHROOMS_3"]) then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(GameInfoTypes["POLICY_FOM_MUSHROOMS_3"], true)	
		end
	end
end
GameEvents.PlayerDoTurn.Add(MarisaMushroomMagicCheck)

----------------------------------------------------------------------------------------------------------------------------
-- JFD_ScientificDiffusion
----------------------------------------------------------------------------------------------------------------------------	
function Marisa_ScientificDiffusion(playerID)
	local player = Players[playerID]
	if player:IsAlive() and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_TH_FOREST_OF_MAGIC"] then
		for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
			local playerTeam = Teams[player:GetTeam()]
			local teamTechs = Teams[player:GetTeam()]:GetTeamTechs()
			local otherPlayer = Players[iPlayerLoop]
			if otherPlayer ~= player and otherPlayer:IsAlive() then
				local otherTeam = Teams[otherPlayer:GetTeam()]
				if otherPlayer:IsDoF(playerID) then
					for row in GameInfo.Technologies() do
						if otherTeam:IsHasTech(row.ID) and player:GetCurrentResearch() == row.ID then
							local modifier = player:GetScience()*10 / 100
							teamTechs:ChangeResearchProgress(row.ID, modifier, playerID)
						end
					end
				end
			end
		end
	end
end
--GameEvents.PlayerDoTurn.Add(Marisa_ScientificDiffusion)
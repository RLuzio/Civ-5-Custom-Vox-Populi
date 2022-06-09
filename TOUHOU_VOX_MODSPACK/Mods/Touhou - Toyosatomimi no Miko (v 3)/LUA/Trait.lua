-- Trait
-- Author: James
-- DateCreated: 5/17/2016 10:50:55 PM
--------------------------------------------------------------




function Trait(playerID)
	
	pPlayer = Players[playerID]

	numBuild = 0
	numBuildB = 0

	if pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_SENKAI"] then
		
		print("1stWork")

		for i=0, 111, 1
		do
			if pPlayer:HasPolicy(i)then
				numBuildB = numBuildB+1
				print("gottit")
			end
		end

		if pPlayer:HasPolicy(7) and pPlayer:HasPolicy(8) and pPlayer:HasPolicy(9) and pPlayer:HasPolicy(10) and pPlayer:HasPolicy(11) then
			numBuild = numBuild+4
		end

		if pPlayer:HasPolicy(1) and pPlayer:HasPolicy(2) and pPlayer:HasPolicy(3) and pPlayer:HasPolicy(4) and pPlayer:HasPolicy(5) then
			numBuild = numBuild+4
		end

		if pPlayer:HasPolicy(13) and pPlayer:HasPolicy(14) and pPlayer:HasPolicy(15) and pPlayer:HasPolicy(16) and pPlayer:HasPolicy(17) then
			numBuild = numBuild+4
		end

		if pPlayer:HasPolicy(19) and pPlayer:HasPolicy(20) and pPlayer:HasPolicy(21) and pPlayer:HasPolicy(22) and pPlayer:HasPolicy(23) then
			numBuild = numBuild+4
		end

		if pPlayer:HasPolicy(25) and pPlayer:HasPolicy(26) and pPlayer:HasPolicy(27) and pPlayer:HasPolicy(28) and pPlayer:HasPolicy(29) then
			numBuild = numBuild+4
		end

		if pPlayer:HasPolicy(31) and pPlayer:HasPolicy(32) and pPlayer:HasPolicy(33) and pPlayer:HasPolicy(34) and pPlayer:HasPolicy(35) then
			numBuild = numBuild+4
		end

		if pPlayer:HasPolicy(37) and pPlayer:HasPolicy(38) and pPlayer:HasPolicy(39) and pPlayer:HasPolicy(40) and pPlayer:HasPolicy(41) then
			numBuild = numBuild+4
		end

		if pPlayer:HasPolicy(50) and pPlayer:HasPolicy(51) and pPlayer:HasPolicy(52) and pPlayer:HasPolicy(53) and pPlayer:HasPolicy(54) then
			numBuild = numBuild+4
		end

		if pPlayer:HasPolicy(57) and pPlayer:HasPolicy(58) and pPlayer:HasPolicy(59) and pPlayer:HasPolicy(60) and pPlayer:HasPolicy(61) then
			numBuild = numBuild+4
		end

		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_MIKO_HAPP_BUILD,numBuild);
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_MIKO_FAITH_BUILD,numBuildB);
	
	end
end
GameEvents.PlayerDoTurn.Add(Trait)
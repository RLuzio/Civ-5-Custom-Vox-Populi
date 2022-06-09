-- Only works for AI Shinmyoumaru

include("KobitoUtil.lua");

function AIKobitoSetBonus ( pPlayer, iRandom )
	if iRandom == 1 then
		KobitoFreeSP(pPlayer);
		print("AI Shinmyoumaru selected Bonus (Free Policy)");
	elseif iRandom == 2 then
		KobitoFreeTc(pPlayer);
		print("AI Shinmyoumaru selected Bonus (Free Tech)");
	elseif iRandom == 3 then
		KobitoFreeGP(pPlayer);
		print("AI Shinmyoumaru selected Bonus (Free Great People)");
	else
		return;
	end
end

function AIKobitoUtil ( iEra, pPlayer )
	print("AI Shinmyoumaru moves to next era. Number of Era is " .. iEra .. ".");
	local iRandom = Game.Rand(2, "Threshold of GP");
	local pCapitalCity = pPlayer:GetCapitalCity();

	if not pCapitalCity then
		return;
	end
	
	if KobitoCheckDummyBuilding(pPlayer,1) then
		if iRandom == 1 then
			AIKobitoSetBonus(pPlayer,2);
		else
			AIKobitoSetBonus(pPlayer,3);
		end
	elseif KobitoCheckDummyBuilding(pPlayer,2) then
		if iRandom == 1 then
			AIKobitoSetBonus(pPlayer,1);
		else
			AIKobitoSetBonus(pPlayer,3);
		end
	elseif KobitoCheckDummyBuilding(pPlayer,3) then
		if iRandom == 1 then
			AIKobitoSetBonus(pPlayer,1);
		else
			AIKobitoSetBonus(pPlayer,2);
		end
	else
		iRandom = Game.Rand(3, "Threshold of GP");
		AIKobitoSetBonus(pPlayer,iRandom+1);
	end
end

function AIKobitoGetNewBonus ( iTeam, iEra )
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local pPlayer = Players[iPlayer];
		if pPlayer:IsAlive() and pPlayer:IsMinorCiv() == false then
			if not pPlayer:IsHuman() then
				if pPlayer:GetTeam() == iTeam and pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOBITO"] then	
					AIKobitoUtil(iEra,pPlayer);
				end
			end
		end
	end
end
GameEvents.TeamSetEra.Add( AIKobitoGetNewBonus );



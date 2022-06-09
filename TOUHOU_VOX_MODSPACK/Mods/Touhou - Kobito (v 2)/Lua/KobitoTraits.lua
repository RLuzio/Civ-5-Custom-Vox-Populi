-- Shinmyoumaru Lua

function IsKobito ()
	for i = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local pPlayer = Players[i];
		if pPlayer:IsEverAlive() then
			if pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOBITO"] then
				print("Shinmyoumaru is in the game");
				return true;
			else
				return false;
			end
		end
		return false;
	end
end

function KobitoGetNewBonus ( iTeam, iEra )
	local pPlayer = Players[Game.GetActivePlayer()];

	if pPlayer == nil then 
		return;
	end

	if pPlayer:GetTeam() == iTeam and pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOBITO"] then
		--E&D support--------
		local pCity = pPlayer:GetCapitalCity();
		if pCity then
			if pCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_GP"]) > 0 then
				pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_GP"], 0);
			end
		end
		----------------------

		LuaEvents.PopUpKobito();
	end
end

function KobitoCaptureCity ( iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest )
	if bIsCapital then
		local oldPlayer = Players[iOldOwner];
		local newPlayer = Players[iNewOwner];
		
		if oldPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOBITO"] then
			local plot = Map.GetPlot(iX, iY);
			local oldCapitalCity = plot:GetPlotCity();
			if not oldCapitalCity then
				return;
			end
			local bNum = oldCapitalCity:GetNumBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"]);
			if bNum > 0 then
				local NewCapitalCity = oldPlayer:GetCapitalCity();
				if NewCapitalCity then
					oldCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"], 0);
					NewCapitalCity:SetNumRealBuilding(GameInfoTypes["BUILDING_KOBITO_DUMMY_CHECK"], bNum);
					--print("Kobito losts her capital. Her new capital is " .. pCapitalCity:GetName() .. ". Her last bonus was " .. bNum .. ".");
				end
			end
		end

	end
end


function InvertedCastleBonus ( iPlayer )
	if Players[iPlayer] == nil then
        return;
    end

	local pPlayer = Players[iPlayer];

	if pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOBITO"] then
		for pUnit in pPlayer:Units() do
			if pUnit:GetDomainType() == DomainTypes["DOMAIN_AIR"] then
				local plot = Map.GetPlot(pUnit:GetX(), pUnit:GetY());
				local pCity = plot:GetPlotCity();
				if pCity then
					if pCity:IsHasBuilding(GameInfoTypes["BUILDING_INVERTED_CASTLE"]) then
						pUnit:ChangeDamage(-5);
					end
				end
			end
		end
	end
end

if IsKobito () then
	GameEvents.TeamSetEra.Add( KobitoGetNewBonus );
	GameEvents.CityCaptureComplete.Add( KobitoCaptureCity );
	GameEvents.PlayerDoTurn.Add( InvertedCastleBonus );
end


----------------------------------------------------------------------------------------------------------------
-- Stinging Swordsman Promotion
----------------------------------------------------------------------------------------------------------------

function GBPromotionUtil ( pPlayer, pUnit )
	if pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_GROW_BIGGER"]) then
		local pPlot = pUnit:GetPlot();
		if pPlot then
			if pPlot:IsFriendlyTerritory(pPlayer:GetTeam()) then
				local pCapital = pPlayer:GetCapitalCity();
				local pCapitalcPopulation = pCapital:GetPopulation();
				local iCombatStrength = math.floor(pCapitalcPopulation/2);
				if iCombatStrength > 7 then
					iCombatStrength = 7;
				end
				pUnit:SetBaseCombatStrength(GameInfo.Units[pUnit:GetUnitType()].Combat + iCombatStrength);
			else
				pUnit:SetBaseCombatStrength(GameInfo.Units[pUnit:GetUnitType()].Combat);
			end
		end
	end
end

GameEvents.UnitSetXY.Add( 
function ( iPlayer, iUnitID, iX, iY )
	if Players[iPlayer] == nil or Players[iPlayer]:GetUnitByID(iUnitID) == nil or Players[iPlayer]:GetUnitByID(iUnitID):IsDead() then
        return;
    end
	local pPlayer = Players[iPlayer];
	local pUnit = pPlayer:GetUnitByID(iUnitID);
	GBPromotionUtil (pPlayer,pUnit);
end
)

GameEvents.PlayerDoTurn.Add( 
function (iPlayer)
	if Players[iPlayer] == nil then
        return;
    end
	local pPlayer = Players[iPlayer];
	for pUnit in pPlayer:Units() do
		GBPromotionUtil (pPlayer,pUnit)
	end 
end
)

GameEvents.UnitUpgraded.Add(
function (playerID, unitID, newUnitID, bGoodyHut)
	if Players[playerID] == nil or Players[playerID]:GetUnitByID(newUnitID) == nil or Players[playerID]:GetUnitByID(newUnitID):IsDead() then
        return;
    end
	local pPlayer = Players[playerID];
	local pUnit = pPlayer:GetUnitByID(newUnitID);
	GBPromotionUtil (pPlayer,pUnit);
end
)
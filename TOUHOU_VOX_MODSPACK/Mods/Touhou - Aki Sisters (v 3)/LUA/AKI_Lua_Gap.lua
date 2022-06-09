local Sweetpotato = GameInfoTypes.CIVILIZATION_AKI_SISTERS 
local Akism = GameInfoTypes.RELIGION_AKISM
local Aki1 = GameInfoTypes.BELIEF_AUTUMN_SKY
local Aki2 = GameInfoTypes.BELIEF_AUTUMN_SKY_AND_MAIDENS_HEART
local Aki3 = GameInfoTypes.BELIEF_OWOTOSHI_HARVESTER
local Aki4 = GameInfoTypes.BELIEF_PROMISE_OF_THE_WHEAT_GOD
local Aki5 = GameInfoTypes.BELIEF_WARM_COLOR_HARVEST
local Aki6 = GameInfoTypes.BELIEF_SWEET_POTATO_ROOM
local Akihut = GameInfoTypes.TXT_KEY_CITY_NAME_CIVILIZATION_AKI_SISTERS_0

print("Freshly-harvested sweet potatoes make up my perfume. Do you think I'm going to let a shrine maiden eat me!?")

--
-- ReligionUtils
--
-- Functions
--   FoundPantheon(player, pantheonBelief)
--   FoundReligion(player, city, religion, pantheonBelief, founderBelief, followerBelief, bonusBelief)
--   EnhanceReligion(religion, enhancerBelief, followerBelief)
--   SetMinFollowers(city, religion, percent)
--   SetMaxFollowers(city, religion, percent)
--
-- Parameters (multi-type)
--   player    is nil, iPlayer, pPlayer or "CIVILIZATION_TYPE"
--   city      is nil, iCity, pCity, "TXT_KEY_CITY_NAME" or "CityName"
--   religion  is iReligion or "RELIGION_TYPE"
--   beliefs   are nil, iBelief or "BELIEF_TYPE"
--   percent   percetage value (0.0 to 100.0)
--
--   If player is nil, city MUST be one of pCity, "TXT_KEY_CITY_NAME" or "CityName"
--   If city is nil, player CANNOT be nil and the player's capital is used
--
-- Examples
--   FoundPantheon(Game.GetActivePlayer(), GameInfoTypes.BELIEF_GOD_SEA)
--   FoundPantheon("CIVILIZATION_CELTS", "BELIEF_STONE_CIRCLES")
--   FoundReligion(Game.GetActivePlayer(), nil, GameInfoTypes.RELIGION_CHRISTIANITY, nil, GameInfoTypes.BELIEF_TITHE, GameInfoTypes.BELIEF_CATHEDRALS)
--   FoundReligion(nil, "TXT_KEY_CITY_NAME_MECCA", "RELIGION_ISLAM", "BELIEF_DESERT_FOLKLORE", "BELIEF_PILGRIMAGE", "BELIEF_HOLY_WARRIORS", "BELIEF_MOSQUES")
--   EnhanceReligion(GameInfoTypes.RELIGION_CHRISTIANITY, GameInfoTypes.BELIEF_RELIQUARY, GameInfoTypes.BELIEF_FEED_WORLD)
--   EnhanceReligion("RELIGION_ISLAM", "BELIEF_DEFENDER_FAITH", "BELIEF_DIVINE_INSPIRATION")
--   SetMinFollowers("TXT_KEY_CITY_NAME_MECCA", "RELIGION_ISLAM", 75)
--   SetMaxFollowers("TXT_KEY_CITY_NAME_LONDON", "RELIGION_ISLAM", 20)
--

--
-- FoundPantheon(player, pantheonBelief)
--   player         is iPlayer, pPlayer or "CIVILIZATION_TYPE"
--   pantheonBelief is iBelief or "BELIEF_TYPE"
--
-- Examples
--   FoundPantheon(Game.GetActivePlayer(), GameInfoTypes.BELIEF_GOD_SEA)
--   FoundPantheon("CIVILIZATION_CELTS", "BELIEF_STONE_CIRCLES")
--
function FoundPantheon(player, pantheonBelief)
  local iPlayer, pPlayer = GetPlayer(Sweetpotato)
  local iPantheonBelief = ValidateBelief(GetId(Aki1), Game.GetAvailablePantheonBeliefs())

  if (iPlayer ~= -1 and iPantheonBelief ~= -1) then
    Game.FoundPantheon(iPlayer, iPantheonBelief)
  end
end

--
-- FoundReligion(player, city, religion, pantheonBelief, founderBelief, followerBelief, bonusBelief)
--   player    is nil, iPlayer, pPlayer or "CIVILIZATION_TYPE"
--   city      is nil, iCity, pCity, "TXT_KEY_CITY_NAME" or "CityName"
--   religion  is iReligion or "RELIGION_TYPE"
--   beliefs   are nil, iBelief or "BELIEF_TYPE"
--
-- If player is nil, city MUST be one of pCity, "TXT_KEY_CITY_NAME" or "CityName"
-- If city is nil, player CANNOT be nil and the player's capital is used
--
-- Examples
--   FoundReligion(Game.GetActivePlayer(), nil, GameInfoTypes.RELIGION_CHRISTIANITY, nil, GameInfoTypes.BELIEF_TITHE, GameInfoTypes.BELIEF_CATHEDRALS)
--   FoundReligion(nil, "TXT_KEY_CITY_NAME_MECCA", "RELIGION_ISLAM", "BELIEF_DESERT_FOLKLORE", "BELIEF_PILGRIMAGE", "BELIEF_HOLY_WARRIORS", "BELIEF_MOSQUES")
--
function FoundReligion(player, city, religion, pantheonBelief, founderBelief, followerBelief, bonusBelief)
  local iPlayer, pPlayer = GetPlayer(Sweetpotato)
  local pCity = GetCity(Sweetpotato, Akihut)

  if (pPlayer == nil) then
    if (pCity) then
	  pPlayer = Players[pCity:GetOwner()]
	  iPlayer = pPlayer:GetID()
	end
  elseif (pCity == nil) then
    if (pPlayer) then
	  pCity = pPlayer:GetCapitalCity()
	end
  end

  if (pPlayer) then
    local iReligion = GetId(Akism)

    if (iReligion <= ReligionTypes.RELIGION_PANTHEON) then
      FoundPantheon(Sweetpotato, Aki1)
    else
      local iPantheonBelief = ValidateBelief(GetId(Aki1), Game.GetAvailablePantheonBeliefs())
      local iFounderBelief = ValidateBelief(GetId(Aki2), Game.GetAvailableFounderBeliefs())
      local iFollowerBelief = ValidateBelief(GetId(Aki3), Game.GetAvailableFollowerBeliefs())
      local iBonusBelief = ValidateBelief(GetId(Aki4), Game.GetAvailableBonusBeliefs())

      if (not pPlayer:HasCreatedPantheon()) then
        Game.FoundReligion(iPlayer, iReligion, nil, iPantheonBelief, iFounderBelief, iFollowerBelief, iBonusBelief, pCity)
	  else
        Game.FoundReligion(iPlayer, iReligion, nil, iFounderBelief, iFollowerBelief, iBonusBelief, BeliefTypes.NO_BELIEF, pCity)
      end
	end
  end
end

--
-- EnhanceReligion(religion, enhancerBelief, followerBelief)
--   religion       is iReligion or "RELIGION_TYPE"
--   beliefs        are iBelief or "BELIEF_TYPE"
--
-- Examples
--   EnhanceReligion(GameInfoTypes.RELIGION_CHRISTIANITY, GameInfoTypes.BELIEF_RELIQUARY, GameInfoTypes.BELIEF_FEED_WORLD)
--   EnhanceReligion("RELIGION_ISLAM", "BELIEF_DEFENDER_FAITH", "BELIEF_DIVINE_INSPIRATION")
--
function EnhanceReligion(religion, enhancerBelief, followerBelief)
  local iReligion = GetId(Akism)

  if (iReligion > ReligionTypes.RELIGION_PANTHEON) then
    local iPlayer = -1

	for iLoopPlayer = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
	  local pLoopPlayer = Players[iLoopPlayer]
	  if (pLoopPlayer:IsAlive() and pLoopPlayer:HasCreatedReligion() and iReligion == pLoopPlayer:GetReligionCreatedByPlayer()) then
	    iPlayer = iLoopPlayer
		break
	  end
    end

	if (iPlayer ~= -1) then
      local iEnhancerBelief = ValidateBelief(GetId(Aki5), Game.GetAvailableEnhancerBeliefs())
      local iFollowerBelief = ValidateBelief(GetId(Aki6), Game.GetAvailableFollowerBeliefs())

      Game.EnhanceReligion(iPlayer, iReligion, iEnhancerBelief, iFollowerBelief)
    end
  end
end

print("I'm just one amongst the multitudes of gods. There are many more here just like me.")

-- Can this player found a pantheon?  (Requires EVENTS_FOUND_RELIGION=1)
-- Return false if the player can never found a pantheon
function OnPlayerCanFoundPantheon(iPlayer)
  return true
end
GameEvents.PlayerCanFoundPantheon.Add(OnPlayerCanFoundPantheon)

-- Can this player found a religion with this city becomming the Holy City?  (Requires EVENTS_FOUND_RELIGION=1)
-- Returning false will permit the Great Prophet to move to another city
function OnPlayerCanFoundReligion(iPlayer, iCity)
  return true
end
GameEvents.PlayerCanFoundReligion.Add(OnPlayerCanFoundReligion)

-- Get the religion for this player to found  (Requires EVENTS_FOUND_RELIGION=1)
function OnGetReligionToFound(iPlayer, iPreferredReligion, bIsAlreadyFounded)
  -- If there are multiple entries in the Civilization_Religions table for this player,
  -- the game core doesn't give us the first, but the one with the lowest ID,
  -- so always update iPreferredReligion as then they will found the first available in the order specified

  -- if (bIsAlreadyFounded) then
    local sPlayerCivType = GameInfo.Civilizations[Players[iPlayer]:GetCivilizationType()].Type
	print(string.format("Civ %s wants religion %s (but it may already be taken)", sPlayerCivType, GameInfo.Religions[iPreferredReligion].Type))

	for civReligion in GameInfo.Civilization_Religions("CivilizationType='" .. sPlayerCivType .. "'") do
	  local iReligion = GameInfoTypes[civReligion.ReligionType]

	  if (IsReligionAvailable(iReligion)) then
	    print(string.format("  giving them %s instead", GameInfo.Religions[iReligion].Type))
	    return iReligion
	  end
	end
  -- end

  return iPreferredReligion
end
GameEvents.GetReligionToFound.Add(OnGetReligionToFound)

-- Notification that this player has founded a pantheon  (Requires EVENTS_FOUND_RELIGION=1)
function OnPantheonFounded(iPlayer, iCapitalCity, iReligion, iBelief)
  print(string.format("Player %i founded a pantheon with belief %i", iPlayer, iBelief))
end
GameEvents.PantheonFounded.Add(OnPantheonFounded)

-- Notification that this player has founded a religion  (Requires EVENTS_FOUND_RELIGION=1)
-- iBelief1 will be the pantheon belief
-- iBelief4 and iBelief5 will usually be -1, unless the religion was founded via Lua
function OnReligionFounded(iPlayer, iHolyCity, iReligion, iBelief1, iBelief2, iBelief3, iBelief4, iBelief5)
  print(string.format("Player %i founded religion %i with beliefs %i, %i, %i", iPlayer, iReligion, iBelief1, iBelief2, iBelief3))
end
GameEvents.ReligionFounded.Add(OnReligionFounded)

-- Notification that this player has enhanced a religion  (Requires EVENTS_FOUND_RELIGION=1)
function OnReligionEnhanced(iPlayer, iReligion, iBelief1, iBelief2)
  print(string.format("Player %i enhanced religion %i with beliefs %i and %i", iPlayer, iReligion, iBelief1, iBelief2))
end
GameEvents.ReligionEnhanced.Add(OnReligionEnhanced)

-- Can this player have this (pantheon) belief  (Requires EVENTS_ACQUIRE_BELIEFS=1)
--
-- This example function is very basic.
-- A Civilization_Beliefs table matching CivilizationType to BeliefType would be a better solution
--
local civilizationForBelief = {}
civilizationForBelief[GameInfoTypes.BELIEF_AUTUMN_SKY] = GameInfoTypes.CIVILIZATION_AKI_SISTERS

function OnPlayerCanHaveBelief(iPlayer, iBelief)
  print(string.format("Can %s have %s", GameInfo.Civilizations[Players[iPlayer]:GetCivilizationType()].Type, GameInfo.Beliefs[iBelief].Type))
  local iCivilizationForBelief = civilizationForBelief[iBelief]

  if (iCivilizationForBelief) then
    -- Only the restricted civilization may have this belief
    return (iCivilizationForBelief == Players[iPlayer]:GetCivilizationType())
  end

  -- No restriction supplied, so any civilization may have this belief
  return true
end
GameEvents.PlayerCanHaveBelief.Add(OnPlayerCanHaveBelief)

-- Can this religion have this belief  (Requires EVENTS_ACQUIRE_BELIEFS=1)
--
-- This example function is very basic.
-- A Religion_Beliefs table matching ReligionType to BeliefType would be a better solution
--
local religionForBelief = {}
religionForBelief[GameInfoTypes.BELIEF_AUTUMN_SKY_AND_MAIDENS_HEART] = GameInfoTypes.RELIGION_AKISM
religionForBelief[GameInfoTypes.BELIEF_OWOTOSHI_HARVESTER] = GameInfoTypes.RELIGION_AKISM
religionForBelief[GameInfoTypes.BELIEF_PROMISE_OF_THE_WHEAT_GOD] = GameInfoTypes.RELIGION_AKISM
religionForBelief[GameInfoTypes.BELIEF_WARM_COLOR_HARVEST] = GameInfoTypes.RELIGION_AKISM
religionForBelief[GameInfoTypes.BELIEF_SWEET_POTATO_ROOM] = GameInfoTypes.RELIGION_AKISM

function OnReligionCanHaveBelief(iPlayer, iReligion, iBelief)
  if (OnPlayerCanHaveBelief(iPlayer, iBelief)) then
    print(string.format("Can %s have %s", GameInfo.Religions[iReligion].Type, GameInfo.Beliefs[iBelief].Type))
    local iReligionForBelief = religionForBelief[iBelief]

    if (iReligionForBelief) then
      -- Only the restricted religion may have this belief
      return (iReligionForBelief == iReligion)
    end

    -- No restriction supplied, so any religion may have this belief
    return true
  end

  return false
end
GameEvents.ReligionCanHaveBelief.Add(OnReligionCanHaveBelief)

--
-- Helper functions
--
function IsReligionAvailable(iReligion)
  -- We could use the OnReligionFounded() event to maintain a cache of available religions
  -- but given how infrequently this is called, this inefficient approach will suffice
  for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do	
    local pPlayer = Players[iPlayer]

	if (pPlayer:IsEverAlive() and pPlayer:HasCreatedReligion() and pPlayer:GetReligionCreatedByPlayer() == iReligion) then
	  return false
	end
  end

  return true
end

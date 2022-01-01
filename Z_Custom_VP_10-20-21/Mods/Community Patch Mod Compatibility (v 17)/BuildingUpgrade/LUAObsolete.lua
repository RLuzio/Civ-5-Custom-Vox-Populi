--[[function CityCanConstructBUS(iPlayer, iCity, buildingType)
	if (isUsingBUS == false) then
		--print("Doesn't have BUS")
		if ((buildingType ~= GameInfoTypes.BUILDING_LIGHTHOUSE_UP) and (buildingType ~= GameInfoTypes.BUILDING_CARAVANSARY_UP) and (buildingType ~= GameInfoTypes.BUILDING_HARBOR_UP) and (buildingType ~= GameInfoTypes.BUILDING_PUBLIC_SCHOOL_UP) and (buildingType ~= GameInfoTypes.BUILDING_LABORATORY_UP) and (buildingType ~= GameInfoTypes.BUILDING_MARKET_UP) and (buildingType ~= GameInfoTypes.BUILDING_BANK_UP) and (buildingType ~= GameInfoTypes.BUILDING_STOCK_EXCHANGE_UP) and (buildingType ~= GameInfoTypes.BUILDING_MONUMENT_UP_MIGHT) and (buildingType ~= GameInfoTypes.BUILDING_MONUMENT_UP_LABOR) and (buildingType ~= GameInfoTypes.BUILDING_MONUMENT_UP_FOOD) and (buildingType ~= GameInfoTypes.BUILDING_MONUMENT_UP_FAITH) and (buildingType ~= GameInfoTypes.BUILDING_MONUMENT_UP_RESEARCH) and (buildingType ~= GameInfoTypes.BUILDING_SHRINE_UP_MIGHT) and (buildingType ~= GameInfoTypes.BUILDING_SHRINE_UP_LABOR) and (buildingType ~= GameInfoTypes.BUILDING_SHRINE_UP_FOOD) and (buildingType ~= GameInfoTypes.BUILDING_SHRINE_UP_CULTURE) and (buildingType ~= GameInfoTypes.BUILDING_SHRINE_UP_RESEARCH) and (buildingType ~= GameInfoTypes.BUILDING_TEMPLE_UP_MIGHT) and (buildingType ~= GameInfoTypes.BUILDING_TEMPLE_UP_LABOR) and (buildingType ~= GameInfoTypes.BUILDING_TEMPLE_UP_FOOD) and (buildingType ~= GameInfoTypes.BUILDING_TEMPLE_UP_CULTURE) and (buildingType ~= GameInfoTypes.BUILDING_TEMPLE_UP_RESEARCH) and (buildingType ~= GameInfoTypes.BUILDING_MONUMENT_UP_GOLD) and (buildingType ~= GameInfoTypes.BUILDING_SHRINE_UP_GOLD) and (buildingType ~= GameInfoTypes.BUILDING_TEMPLE_UP_GOLD)) then
			return true
		else
			return false
		end
	elseif (isUsingBUS == true) then
		--print("Have BUS")
		return true
	end
end
local isBNW = ContentManager.IsActive("6DA07636-4123-4018-B643-6575B4EC336B", ContentType.GAMEPLAY)
--########################################################################
-- Detect active mods
-- Compatability addition by Xaragas from civfanatics
function HavingMods()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		--Assumes that if this mod ID is activated then this is true? I believe?
		if (mod.ID == "e3fed66f-f129-45a4-abce-a5496dc2f0c5") then
			isUsingBUS = true
		end
	end
end

isUsingBUS = false
HavingMods()
print(isUsingBUS)
GameEvents.CityCanConstruct.Add(CityCanConstructBUS)]]
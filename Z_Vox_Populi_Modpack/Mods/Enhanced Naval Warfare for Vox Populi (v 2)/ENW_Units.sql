----------------------------------------------------
-- Enhanced Modern Warfare
-- Changes to existing units and integrating new units
-- Author: Infixo
-- Feb 16, 2017: Created
----------------------------------------------------


----------------------------------------------------
-- Missile Cruiser
-- Original MC gets a new model (Kirov) and a new Flag
----------------------------------------------------

UPDATE ArtDefine_UnitMemberInfos
SET Model = 'kirov.fxsxml'
WHERE Type = 'ART_DEF_UNIT_MEMBER_MISSILECRUISER';

UPDATE ArtDefine_StrategicView
SET Asset = 'SV_ENW_MissileCruiser.dds'
WHERE StrategicViewType = 'ART_DEF_UNIT_MISSILE_CRUISER';

UPDATE Units
SET UnitFlagAtlas = 'FLAG_ATLAS_ENW', UnitFlagIconOffset = 3, CombatClass = 'UNITCOMBAT_NAVALRANGED',
	Combat = 75, RangedCombat = 80, Range = 2, Cost = 2300, FaithCost = 1200, PrereqTech = 'TECH_LASERS', ExtraMaintenanceCost = 2, BaseLandAirDefense = 35
WHERE Type = 'UNIT_MISSILE_CRUISER';

INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
VALUES ('UNIT_BATTLESHIP', 'UNITCLASS_MISSILE_CRUISER');

DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_MISSILE_CRUISER';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES
  ('UNIT_MISSILE_CRUISER', 'RESOURCE_IRON', 1);

DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_MISSILE_CRUISER';
INSERT INTO Unit_FreePromotions	(UnitType, PromotionType)
VALUES
	('UNIT_MISSILE_CRUISER', 'PROMOTION_INDIRECT_FIRE'),
	('UNIT_MISSILE_CRUISER', 'PROMOTION_CARGO_III'),
	('UNIT_MISSILE_CRUISER', 'PROMOTION_ARMOR_PLATING_1'),
	('UNIT_MISSILE_CRUISER', 'PROMOTION_ONLY_DEFENSIVE');
	
-- Polynesian UA no longer applies to Missile Cruiser
DELETE FROM Trait_BuildsUnitClasses
WHERE TraitType = 'TRAIT_WAYFINDING' AND UnitClassType = 'UNITCLASS_MISSILE_CRUISER';
	
UPDATE Language_en_US
SET Text = 'The most powerful Naval Ranged unit with a solid shield. Does not intercept Air Units. Carries 3 Missiles. Requires [ICON_RES_IRON] Iron to be built.'
WHERE Tag = 'TXT_KEY_UNIT_HELP_MISSILE_CRUISER';

UPDATE Language_en_US
SET Text = 'The Missile Cruiser is a modern warship. It''s fast and tough and carries a mean punch. Most importantly, the Missile Cruiser can carry Guided Missiles and Nuclear Missiles, allowing you to carry these deadly weapons right up to the enemy''s shore. Missile Cruisers combined with carriers, submarines, and battleships make a fiendishly powerful armada.'
WHERE Tag = 'TXT_KEY_UNIT_MISSILE_CRUISER_STRATEGY';
	
----------------------------------------------------
-- AI
----------------------------------------------------
INSERT INTO Unit_AITypes (UnitType, UnitAIType)
VALUES
	('UNIT_MISSILE_CRUISER', 'UNITAI_ASSAULT_SEA'),
	('UNIT_MISSILE_CRUISER', 'UNITAI_RESERVE_SEA');

INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
VALUES
	('UNIT_MISSILE_CRUISER', 'FLAVOR_NAVAL', 50),
	('UNIT_MISSILE_CRUISER', 'FLAVOR_NAVAL_RECON', 20);
	
-- Missile cruiser is not for explore/recon
DELETE FROM Unit_AITypes WHERE UnitType = 'UNIT_MISSILE_CRUISER' AND UnitAIType = 'UNITAI_EXPLORE_SEA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

----------------------------------------------------
-- Battleship & Cruiser
----------------------------------------------------
UPDATE Units
SET Combat = 60
WHERE Type = 'UNIT_BATTLESHIP';

UPDATE Units
SET ObsoleteTech = 'TECH_LASERS'
WHERE Type = 'UNIT_BATTLESHIP';

DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_BATTLESHIP';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES
	('UNIT_BATTLESHIP', 'RESOURCE_IRON', 1);

UPDATE Language_en_US
SET Text = 'Very powerful ranged Naval unit, the first one capable of indirect fire.'
WHERE Tag = 'TXT_KEY_UNIT_HELP_BATTLESHIP';

UPDATE Language_en_US
SET Text = 'The Battleship is a powerful warship with a mighty Combat Strength. Its indirect fire ability allows it to bombard targets it cannot see (as long as other friendly units can see them). The Battleship is vulnerable to air and submarine attacks.'
WHERE Tag = 'TXT_KEY_UNIT_BATTLESHIP_STRATEGY';

UPDATE Units
SET ObsoleteTech = 'TECH_RADIO'
WHERE Type = 'UNIT_CRUISER';

----------------------------------------------------
-- Destroyer & Ironclad
----------------------------------------------------
-- Name change
-- Although the term "destroyer" had been used interchangeably with "torpedo boat destroyer" by navies since 1892,
-- the term "torpedo boat destroyer" had been generally shortened to simply "destroyer" by nearly all navies by the First World War.
-- So, a new unit EARLY_DESTROYER from Modern Era will be named "Destroyer", and vanilla game Destroyer
-- since it represents Atomic Era will be named "Modern Destroyer"
UPDATE Language_en_US
SET Text = 'Modern Destroyer'
WHERE Tag = 'TXT_KEY_UNIT_DESTROYER';

UPDATE Language_en_US
SET Text = 'The Modern Destroyer is a naval melee attack unit designed to hunt down submarines and to provide anti-aircraft support.'
WHERE Tag = 'TXT_KEY_UNIT_DESTROYER_STRATEGY';

-- ...and we get a much better model
UPDATE ArtDefine_UnitMemberInfos
SET Model = 'Z_Class.fxsxml', Scale = 0.10
WHERE Type = 'ART_DEF_UNIT_MEMBER_DESTROYER';

UPDATE Units
SET ObsoleteTech = 'TECH_STEALTH'
WHERE Type = 'UNIT_DESTROYER';

DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_DESTROYER';
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
VALUES
	('UNIT_DESTROYER', 'PROMOTION_INTERCEPTION_I'),
	('UNIT_DESTROYER', 'PROMOTION_ANTI_SUBMARINE_I');

UPDATE Units
SET ObsoleteTech = 'TECH_RADIO'
WHERE Type = 'UNIT_IRONCLAD';

DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_IRONCLAD';

----------------------------------------------------
-- Submarines and Carrier
----------------------------------------------------

UPDATE Units
SET Combat = 40, Moves = 4, RangedCombat = 55, Range = 1, Cost = 1200, FaithCost = 800, PrereqTech = 'TECH_PLASTIC', ObsoleteTech = 'TECH_ELECTRONICS'
WHERE Type = 'UNIT_SUBMARINE';

DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_SUBMARINE';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_SUBMARINE', 'RESOURCE_ALUMINUM', 1);

INSERT INTO Technology_Flavors (TechType, FlavorType, Flavor)
VALUES ('TECH_PLASTIC', 'FLAVOR_NAVAL', 10);


UPDATE Units
SET Combat = 60, RangedCombat = 75, PrereqTech = 'TECH_ROBOTICS', ExtraMaintenanceCost = 1, BaseLandAirDefense = 15 -- Cost = 2250
WHERE Type = 'UNIT_NUCLEAR_SUBMARINE';

DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_NUCLEAR_SUBMARINE';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_NUCLEAR_SUBMARINE', 'RESOURCE_ALUMINUM', 1);

INSERT INTO Unit_FreePromotions	(UnitType, PromotionType)
VALUES
	('UNIT_NUCLEAR_SUBMARINE', 'PROMOTION_DIVE_II');

UPDATE Units
SET Combat = 70  -- Cannot make obsolete, not everyone will want Supercarrier, ObsoleteTech = 'TECH_ROBOTICS'
WHERE Type = 'UNIT_CARRIER';

----------------------------------------------------
-- Missiles
----------------------------------------------------

UPDATE Units
SET RangedCombat = 180, PrereqTech = 'TECH_ADVANCED_BALLISTICS' -- RangedCombat = 120, Cost = 1000, was TECH_ROCKETRY
WHERE Type = 'UNIT_GUIDED_MISSILE';

UPDATE ArtDefine_UnitMemberCombats
SET AttackAltitude = 90, MoveRate = 4.8
WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_GUIDEDMISSILE';

UPDATE ArtDefine_UnitMemberCombatWeapons
SET WeaponTypeSoundOverrideTag = 'EXPLOSION1TON'
WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_GUIDEDMISSILE';

----------------------------------------------------
--  ANTI_SUBMARINE and SEE_INVISIBLE_SUBMARINE Promotion tree redesigned
----------------------------------------------------

-- PROMOTION_ANTI_SUBMARINE_I available early with Submarine at TECH_ELECTRICITY
UPDATE UnitPromotions SET TechPrereq = 'TECH_PLASTIC' WHERE Type = 'PROMOTION_ANTI_SUBMARINE_I';

-- remove anti-Sub promotions' prerequisites
UPDATE UnitPromotions
SET PromotionPrereqOr1 = null, CannotBeChosen = 'true', LostWithUpgrade = 'true', TechPrereq = null
WHERE Type = 'PROMOTION_ANTI_SUBMARINE_I';

UPDATE UnitPromotions
SET PromotionPrereqOr1 = null, CannotBeChosen = 'true', LostWithUpgrade = 'true', TechPrereq = null
WHERE Type = 'PROMOTION_ANTI_SUBMARINE_II';

-- move See Invisible Submarine promotion to tier 2
UPDATE UnitPromotions
SET PromotionPrereqOr1 = 'PROMOTION_COASTAL_RAIDER_1', PromotionPrereqOr2 = 'PROMOTION_BOARDING_PARTY_1', TechPrereq = 'TECH_PLASTIC'
WHERE Type = 'PROMOTION_SEE_INVISIBLE_SUBMARINE';

----------------------------------------------------
-- Miscellaneous
----------------------------------------------------

-- TECH_STEALTH, TECH_STEAM_POWER, TECH_PENICILIN are not for NAVAL
DELETE FROM Technology_Flavors WHERE TechType = 'TECH_STEALTH' AND FlavorType = 'FLAVOR_NAVAL';
DELETE FROM Technology_Flavors WHERE TechType = 'TECH_STEAM_POWER' AND FlavorType = 'FLAVOR_NAVAL';
DELETE FROM Technology_Flavors WHERE TechType = 'TECH_PENICILIN' AND FlavorType = 'FLAVOR_NAVAL';

-- Modern Destroyer change
UPDATE Units SET Combat = 80, Cost = 1800, FaithCost = 1000, Moves = 5 WHERE Type = 'UNIT_DESTROYER';
--
UPDATE UnitPromotions
SET LostWithUpgrade = 'true'
WHERE Type = 'PROMOTION_CARGO_I' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

-- Ironclad change
UPDATE Units SET Combat = 55, Cost = 900, FaithCost = 650 WHERE Type = 'UNIT_IRONCLAD';

-- rename Dreadnought promotions
UPDATE Language_en_US
SET Text = 'Hull I'
WHERE Tag = 'TXT_KEY_PROMOTION_COASTAL_RAIDER_1' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Hull II'
WHERE Tag = 'TXT_KEY_PROMOTION_COASTAL_RAIDER_2' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Hull III'
WHERE Tag = 'TXT_KEY_PROMOTION_COASTAL_RAIDER_3' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

-- Anti-Sub promotions reworked
INSERT INTO UnitPromotions_UnitClasses (PromotionType, UnitClassType) VALUES ('PROMOTION_ANTI_SUBMARINE_I', 'UNITCLASS_ATTACK_SUBMARINE');
INSERT INTO UnitPromotions_UnitClasses (PromotionType, UnitClassType) VALUES ('PROMOTION_ANTI_SUBMARINE_II', 'UNITCLASS_ATTACK_SUBMARINE');

UPDATE UnitPromotions_UnitClasses
SET Attack = '33', Defense = '25', Modifier = '0'
WHERE PromotionType = 'PROMOTION_ANTI_SUBMARINE_I' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE UnitPromotions_UnitClasses
SET Attack = '66', Defense = '50', Modifier = '0'
WHERE PromotionType = 'PROMOTION_ANTI_SUBMARINE_II' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );


UPDATE UnitPromotions 
SET Help = 'TXT_KEY_PROMOTION_ANTI_SUBMARINE_I_HELP'
WHERE Type = 'PROMOTION_ANTI_SUBMARINE_I' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Anti-submarine I'
WHERE Tag = 'TXT_KEY_PROMOTION_ANTI_SUBMARINE_I' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Attack vs Submarines +33%[NEWLINE]Defense vs Submarines +25%'
WHERE Tag = 'TXT_KEY_PEDIA_PROMOTION_ANTI_SUBMARINE_I' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE UnitPromotions 
SET Help = 'TXT_KEY_PROMOTION_ANTI_SUBMARINE_II_HELP'
WHERE Type = 'PROMOTION_ANTI_SUBMARINE_II' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Anti-submarine II'
WHERE Tag = 'TXT_KEY_PROMOTION_ANTI_SUBMARINE_II' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Attack vs Submarines +66%[NEWLINE]Defense vs Submarines +50%'
WHERE Tag = 'TXT_KEY_PEDIA_PROMOTION_ANTI_SUBMARINE_II' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

-- Turtle Ship fix
UPDATE Units SET Class = 'UNITCLASS_CARAVEL' WHERE Type = 'UNIT_KOREAN_TURTLE_SHIP';

-- Sea Beggars and Ship Of The Line obsolete early
UPDATE Units
SET ObsoleteTech = 'TECH_RADIO'
WHERE Type = 'UNIT_DUTCH_SEA_BEGGAR';

UPDATE Units
SET ObsoleteTech = 'TECH_RADIO'
WHERE Type = 'UNIT_ENGLISH_SHIPOFTHELINE';




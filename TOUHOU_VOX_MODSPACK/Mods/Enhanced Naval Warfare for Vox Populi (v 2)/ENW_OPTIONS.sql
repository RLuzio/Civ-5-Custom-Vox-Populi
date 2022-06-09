
----------------------------- ENW OPTIONS -----------------------------

----------------------------------------------------------------------+
------------------------------ RESOURCES -----------------------------

-- To activate an optional proposition below, delete "/*" and "*/" front and back

-- e.g.


-- Disabled :
---------------------- Consumes 1x IRON instead and MODERN DESTROYER never obsolete
-- /*
-- INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
-- VALUES ('UNIT_MISSILE_DESTROYER', 'RESOURCE_IRON', 1);
-- UPDATE Units SET ObsoleteTech = NULL WHERE Type = 'UNIT_DESTROYER';
-- */


-- Enable :
---------------------- Consumes 1x IRON instead and MODERN DESTROYER never obsolete
--
-- INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
-- VALUES ('UNIT_MISSILE_DESTROYER', 'RESOURCE_IRON', 1);
-- UPDATE Units SET ObsoleteTech = NULL WHERE Type = 'UNIT_DESTROYER';
--


-----------------------------------------------------------------------
----------------------------------------------------------------------+


----------------------------------------------------
-- MISSILE DESTROYER
-- Consumes NO ressource by default
----------------------------------------------------

---------------------- Consumes 1x COAL instead and MODERN DESTROYER never obsolete
/*
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_MISSILE_DESTROYER', 'RESOURCE_COAL', 1);
UPDATE Units SET ObsoleteTech = NULL WHERE Type = 'UNIT_DESTROYER';
*/

---------------------- Consumes 1x IRON instead and MODERN DESTROYER never obsolete
/*
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_MISSILE_DESTROYER', 'RESOURCE_IRON', 1);
UPDATE Units SET ObsoleteTech = NULL WHERE Type = 'UNIT_DESTROYER';
*/

---------------------- Consumes 1x ALUMINIUM instead and MODERN DESTROYER never obsolete
/*
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_MISSILE_DESTROYER', 'RESOURCE_ALUMINUM', 1);
UPDATE Units SET ObsoleteTech = NULL WHERE Type = 'UNIT_DESTROYER';
*/


--                                           (=°.°=)


----------------------------------------------------
-- ADVANCED DESTROYER
-- Consumes NO ressource by default
----------------------------------------------------

---------------------- Consumes 1x COAL instead and MISSILE DESTROYER never obsolete
/*
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_ADVANCED_DESTROYER', 'RESOURCE_COAL', 1);
UPDATE Units SET ObsoleteTech = NULL WHERE Type = 'UNIT_MISSILE_DESTROYER';
*/

---------------------- Consumes 1x IRON instead and MISSILE DESTROYER never obsolete
/*
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_ADVANCED_DESTROYER', 'RESOURCE_IRON', 1);
UPDATE Units SET ObsoleteTech = NULL WHERE Type = 'UNIT_MISSILE_DESTROYER';
*/

---------------------- Consumes 1x ALUMINIUM instead and MISSILE DESTROYER never obsolete
/*
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_ADVANCED_DESTROYER', 'RESOURCE_ALUMINUM', 1);
UPDATE Units SET ObsoleteTech = NULL WHERE Type = 'UNIT_MISSILE_DESTROYER';
*/


--                                           (=°.°=)


----------------------------------------------------
-- MISSILE CRUISER
-- Consumes 1x IRON by default
----------------------------------------------------

------------------------------ Consumes NO ressource
/*
DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_MISSILE_CRUISER';
*/

---------------------- Consumes 1x ALUMINIUM instead and BATTLESHIP never obsolete
/*
DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_MISSILE_CRUISER';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_MISSILE_CRUISER', 'RESOURCE_ALUMINUM', 1);
UPDATE Units SET ObsoleteTech = NULL WHERE Type = 'UNIT_BATTLESHIP';
*/





----------------------------------------------------------------------+
--------------------------- Ship re-scaling ---------------------------

-- Scale = x.xxx defines how big a Unit is in the game
-- Advice : Do not change anything!

-----------------------------------------------------------------------
----------------------------------------------------------------------+

UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.094 WHERE Type = 'ART_DEF_UNIT_MEMBER_IRONCLAD'; -- org. 0.094
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.091 WHERE Type = 'ART_DEF_UNIT_MEMBER_EARLY_DESTROYER'; -- org. 0.091
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.109 WHERE Type = 'ART_DEF_UNIT_MEMBER_DESTROYER'; -- org. 0.109
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.116 WHERE Type = 'ART_DEF_UNIT_MEMBER_MISSILE_DESTROYER'; -- org. 0.116
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.112 WHERE Type = 'ART_DEF_UNIT_MEMBER_ADVANCED_DESTROYER'; -- org. 0.112
--
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.059 WHERE Type = 'ART_DEF_UNIT_MEMBER_CRUISER'; -- org. 0.059
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.075 WHERE Type = 'ART_DEF_UNIT_MEMBER_DREADNOUGHT'; -- org. 0.075
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.088 WHERE Type = 'ART_DEF_UNIT_MEMBER_BATTLESHIP'; -- org. 0.088
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.100 WHERE Type = 'ART_DEF_UNIT_MEMBER_MISSILECRUISER'; -- org. 0.100
--
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.140 WHERE Type = 'ART_DEF_UNIT_MEMBER_SUBMARINE'; -- org. 0.140
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.085 WHERE Type = 'ART_DEF_UNIT_MEMBER_ATTACK_SUBMARINE'; -- org. 0.085
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.115 WHERE Type = 'ART_DEF_UNIT_MEMBER_NUCLEARSUBMARINE'; -- org. 0.115
--
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.070 WHERE Type = 'ART_DEF_UNIT_MEMBER_CARRIER'; -- org. 0.070
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.095 WHERE Type = 'ART_DEF_UNIT_MEMBER_SUPERCARRIER'; -- org. 0.095

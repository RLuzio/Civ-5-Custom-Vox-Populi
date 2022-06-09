--=======================================================================================================================
-- Bingle's Civ IV Traits
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,				TraitOne,				TraitTwo)
VALUES      ('LEADER_SHINMYOUMARU',	'POLICY_PROTECTIVE_X',	'POLICY_CREATIVE_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PROTECTIVE_X' )
	THEN 'Shinmyoumaru Sukuna [ICON_STRENGTH][ICON_CULTURE]'
	ELSE 'Shinmyoumaru Sukuna' END) 
WHERE Tag = 'TXT_KEY_LEADER_SHINMYOUMARU';

--==========================================================================================================================
-- JFD's Cultural Diversity
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag                             text                                            default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			CultureType,	SplashScreenTag,             SoundtrackTag,               UnitDialogueTag)
VALUES	('CIVILIZATION_KOBITO',	'JFD_Oriental',  'JFD_OrientalJapanese',	 'JFD_OrientalJapanese',        'AS2D_SOUND_JFD_JAPANESE');
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_OrientalJapanese')
	THEN 'JFD_OrientalJapanese'
	ELSE 'Japan' END) 
WHERE Type = 'CIVILIZATION_KOBITO';

--==========================================================================================================================	
-- JFD's Piety & Prestige
--==========================================================================================================================			
-- Flavors
------------------------------	
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
			(LeaderType,				FlavorType,							Flavor)
VALUES		('LEADER_SHINMYOUMARU',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0);

--=========================================================================================================================
-- JFD AND POUAKAI'S MERCENARIES
--=========================================================================================================================
-- Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,					Flavor)
VALUES	--Vanilla
		('LEADER_SHINMYOUMARU',			'FLAVOR_JFD_MERCENARY',		5);
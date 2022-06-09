CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
            (LeaderType,				TraitOne,				TraitTwo)
SELECT      'LEADER_JOON',				'POLICY_MERCANTILE_X',	'POLICY_EXPANSIVE_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

UPDATE Leaders 
SET Description = 'Yorigami Joon [ICON_GOLD][ICON_FOOD]'
WHERE Type = 'LEADER_JOON'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	CultureType 								text										default null,
	SplashScreenTag								text										default	null,
	SoundtrackTag								text										default	null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,					CultureType,		SplashScreenTag,    SoundtrackTag,               UnitDialogueTag)
VALUES	('CIVILIZATION_TOUHOU_PESTILENCE',	'JFD_Colonial',		'JFD_Colonial',		'JFD_OrientalJapanese',       'AS2D_SOUND_JFD_JAPANESE');

UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_OrientalJapanese' )
	THEN 'JFD_OrientalJapanese'
	ELSE 'Japan' END) 
WHERE Type = 'CIVILIZATION_TOUHOU_PESTILENCE';

INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,					Flavor)
VALUES
		('LEADER_JOON',					'FLAVOR_JFD_MERCENARY',		8);
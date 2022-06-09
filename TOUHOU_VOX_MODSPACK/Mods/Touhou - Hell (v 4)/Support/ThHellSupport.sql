CREATE TABLE IF NOT EXISTS
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,				TraitOne,				TraitTwo)
VALUES      ('LEADER_HECATIA',	'POLICY_AGGRESSIVE_X',	'POLICY_DIPLOMATIC_X');

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Hecatia Lapislazuli [ICON_WAR][ICON_INFLUENCE]'
	ELSE 'Hecatia Lapislazuli' END) 
WHERE Tag = 'TXT_KEY_LEADER_HECATIA';


CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag                             text                                            default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			CultureType,	SplashScreenTag,             SoundtrackTag,               UnitDialogueTag)
VALUES	('CIVILIZATION_TH_HELL',	'JFD_Mandala',  'JFD_Mandala',	 'JFD_OrientalJapanese',        'AS2D_SOUND_JFD_JAPANESE');

UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_OrientalJapanese')
	THEN 'JFD_OrientalJapanese'
	ELSE 'Japan' END) 
WHERE Type = 'CIVILIZATION_TH_HELL';


INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');

INSERT INTO Leader_Flavors
			(LeaderType,				FlavorType,							Flavor)
VALUES		('LEADER_HECATIA',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0);


INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');

INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,					Flavor)
VALUES
		('LEADER_HECATIA',			'FLAVOR_JFD_MERCENARY',		5);
-- Insert SQL Rules Here 
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits -- Traits chosen by Mathetes tou Megalou Alexandrou
            (LeaderType,				TraitOne,				TraitTwo)
VALUES      ('LEADER_EIKI',	'POLICY_DIPLOMATIC_X',	'POLICY_CHARISMATIC_X');

UPDATE Language_en_US
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Shikieiki [ICON_INFLUENCE][ICON_HAPPINESS_1]'
	ELSE 'Shikieiki' END) 
WHERE Tag = 'TXT_KEY_LEADER_EIKI';


CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	CultureType 								text										default null,
	SplashScreenTag								text										default	null,
	SoundtrackTag								text										default	null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			CultureType,	SplashScreenTag,             SoundtrackTag,               UnitDialogueTag)
VALUES	('CIVILIZATION_HIGAN',	'JFD_Mandala',  'JFD_Mandala',	 'JFD_OrientalJapanese',        'AS2D_SOUND_JFD_JAPANESE');

UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_OrientalJapanese' )
	THEN 'JFD_OrientalJapanese'
	ELSE 'Japan' END) 
WHERE Type = 'CIVILIZATION_HIGAN';


INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');

INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,					Flavor)
VALUES
		('LEADER_EIKI',			'FLAVOR_JFD_MERCENARY',		0); -- She does not like the concept of mercenaries
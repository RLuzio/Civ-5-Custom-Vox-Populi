CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
            (LeaderType,				TraitOne,				TraitTwo)
SELECT      'LEADER_TENMA',	'POLICY_PROTECTIVE_X',	'POLICY_CREATIVE_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

UPDATE Leaders 
SET Description = 'Tenma [ICON_STRENGTH][ICON_CULTURE]'
WHERE Type = 'LEADER_TENMA'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	DefeatScreenEarlyTag						text											default	null,
	DefeatScreenMidTag							text											default	null,
	DefeatScreenLateTag							text											default	null,
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,				ArtDefineTag, CultureType,			DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag,			IdealsTag,			SplashScreenTag, 		SoundtrackTag,  		UnitDialogueTag)
SELECT	'CIVILIZATION_TOUHOU_TENGU',	ArtDefineTag, 'JFD_Totalitarian',	DefeatScreenEarlyTag, DefeatScreenMidTag, 'DefeatScreenLateTotal.dds',  'JFD_Totalitarian',	'JFD_Totalitarian',		'JFD_OrientalJapanese', UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_JAPAN';

UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_OrientalJapanese' )
	THEN 'JFD_OrientalJapanese'
	ELSE 'Tengu' END) 
WHERE Type = 'CIVILIZATION_TOUHOU_TENGU';

INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,					Flavor)
VALUES
		('LEADER_TENMA',			'FLAVOR_JFD_MERCENARY',		3);

CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,									X,		Y	)
VALUES	('CIVILIZATION_TOUHOU_TENGU',			96,	    59	); --Beside the Yatsugatake Mountains, close to Nagano, which is where the Youkai Mountain used to be in


CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_TOUHOU_TENGU'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_JAPAN'; --Same resources as Japan
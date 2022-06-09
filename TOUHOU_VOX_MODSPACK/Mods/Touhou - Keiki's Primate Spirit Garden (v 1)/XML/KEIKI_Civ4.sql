CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,    TraitOne,    TraitTwo)
VALUES	('LEADER_HANIYASUSHIN_KEIKI',	'POLICY_INDUSTRIOUS_X',	'POLICY_CREATIVE_X');
------------------------------	
-- Leaders
------------------------------	

UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'TXT_KEY_LEADER_HANIYASUSHIN_KEIKI_CIV_IV'
	ELSE 'TXT_KEY_LEADER_HANIYASUSHIN_KEIKI' END) 
WHERE Type = 'LEADER_HANIYASUSHIN_KEIKI';

-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,    TraitOne,    TraitTwo)
VALUES	('LEADER_HIMEMUSHI_MOMOYO',	'POLICY_EXPANSIVE_X',	'POLICY_INDUSTRIOUS_X');
------------------------------	
-- Leaders
------------------------------	

UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'TXT_KEY_LEADER_HIMEMUSHI_MOMOYO_CIV_IV'
	ELSE 'TXT_KEY_LEADER_HIMEMUSHI_MOMOYO' END) 
WHERE Type = 'LEADER_HIMEMUSHI_MOMOYO';
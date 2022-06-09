CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);

INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,    TraitOne,    TraitTwo)
VALUES      ('LEADER_KUROKOMA_SAKI', 'POLICY_AGGRESSIVE_X', 'POLICY_IMPERIALISTIC_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_CREATIVE_X' )
 THEN 'TXT_KEY_LEADER_KUROKOMA_SAKI_CIV_IV'
 ELSE 'TXT_KEY_LEADER_KUROKOMA_SAKI' END) 
WHERE Type = 'LEADER_KUROKOMA_SAKI'
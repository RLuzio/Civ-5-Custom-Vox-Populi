CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);

INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,    TraitOne,    TraitTwo)
VALUES      ('LEADER_USAMI_SUMIREKO', 'POLICY_PHILOSOPHICAL_X', 'POLICY_INVENTIVE_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_CREATIVE_X' )
 THEN 'TXT_KEY_LEADER_USAMI_SUMIREKO_CIV_IV'
 ELSE 'TXT_KEY_LEADER_USAMI_SUMIREKO' END) 
WHERE Type = 'LEADER_USAMI_SUMIREKO'
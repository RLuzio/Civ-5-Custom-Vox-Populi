CREATE TABLE IF NOT EXISTS
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);

INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,    TraitOne,    TraitTwo)
VALUES      ('LEADER_RINNOSUKE', 'POLICY_MERCANTILE_X', 'POLICY_DIPLOMATIC_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_CREATIVE_X')
 THEN 'TXT_KEY_LEADER_RINNOSUKE_CIV_IV'
 ELSE 'TXT_KEY_LEADER_RINNOSUKE' END) 
WHERE Type = 'LEADER_RINNOSUKE'

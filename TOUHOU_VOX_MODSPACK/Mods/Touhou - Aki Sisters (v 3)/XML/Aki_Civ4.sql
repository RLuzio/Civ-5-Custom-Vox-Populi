CREATE TABLE IF NOT EXISTS
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);

INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,    TraitOne,    TraitTwo)
VALUES      ('LEADER_MINORIKO', 'POLICY_SPIRITUAL_X', 'POLICY_EXPANSIVE_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_SPIRITUAL_X')
 THEN 'TXT_KEY_LEADER_MINORIKO_CIV_IV'
 ELSE 'TXT_KEY_LEADER_MINORIKO' END)
WHERE Type = 'LEADER_MINORIKO'
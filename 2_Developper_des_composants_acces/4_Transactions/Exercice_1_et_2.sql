-- EXERCICE 1 ---------------------------------------------------------------------------------------------------------

START TRANSACTION;

SELECT nomfou FROM fournis WHERE numfou=120;

UPDATE fournis  SET nomfou= 'GROSBRIGAND' WHERE numfou=120;

SELECT nomfou FROM fournis WHERE numfou=120; 


-- Pour valider ces modifications --> COMMIT;

-- Pour annuler ces modifications --> ROLLBACK;

-- Pour verrouiller les tables pendant la transaction --> LOCK TABLES nom_table WRITE; 

-- Pour NE PAS verrouiller les tables pendant la transaction --> LOCK TABLES nom_table READ;

-- Pour déverrouiller les tables (une fois la transaction finit, par exemple) --> UNLOCK TABLES;


-- EXERCICE 2 ---------------------------------------------------------------------------------------------------------

START TRANSACTION;

SELECT nomfou FROM fournis WHERE numfou=120;

UPDATE fournis  SET nomfou= 'GROSBRIGAND' WHERE numfou=120;

SELECT nomfou FROM fournis WHERE numfou=120; 
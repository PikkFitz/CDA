drop database IF EXISTS exemple;
create database exemple;

use exemple;


CREATE TABLE dept (
	nodept 		varchar(50) NOT NULL PRIMARY KEY,
	nom 		varchar(50) NOT NULL,
	noregion 	varchar(50) NOT NULL
);

CREATE TABLE employe(
	noemp 		int NOT NULL PRIMARY KEY,
	nom 		varchar(50) NOT NULL,
	prenom 		varchar(50) NOT NULL,
	dateemb 	datetime NOT NULL,
	nosup 		varchar(50) NULL,
	titre 		varchar(50) NOT NULL,
	nodep 		varchar(50) NOT NULL REFERENCES dept(nodept),
	salaire 	decimal(18, 0) NOT NULL,
	tauxcom 	decimal(18, 0) NULL
);



INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('10', 'finance', '1');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('20', 'atelier', '2');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('30', 'atelier', '3');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('31', 'vente', '1');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('32', 'vente', '2');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('33', 'vente', '3');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('34', 'vente', '4');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('35', 'vente', '5');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('41', 'distribution', '1');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('42', 'distribution', '2');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('43', 'distribution', '3');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('44', 'distribution', '4');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('45', 'distribution', '5');
INSERT INTO  dept  ( nodept ,  nom ,  noregion ) VALUES ('50', 'administration', '1');




INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (1, 'patamob', 'adhémar', '20000326', NULL, 'président', '50', 50000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (2, 'zeublouse', 'agathe', '20000415', '1', 'dir.distrib', '41', 35000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (3, 'kuzbidon', 'alex', '20000505', '1', 'dir.vente', '31', 34000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (4, 'locale', 'anasthasie', '20000525', '1', 'dir.finance', '10', 36000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (5, 'teutmaronne', 'armand', '20000614', '1', 'dir.administratif', '50', 36000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (6, 'zoudanlkou', 'debbie', '20000704', '2', 'chef entrepot', '41', 25000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (7, 'rivenbusse', 'elsa', '20000724', '2', 'chef entrepot', '42', 24000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (8, 'ardelpic', 'helmut', '20000813', '2', 'chef entrepot', '43', 23000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (9, 'peursconla', 'humphrey', '20000902', '2', 'chef entrepot', '44', 22000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (10, 'vrante', 'helena', '20000922', '2', 'chef entrepot', '45', 21000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (11, 'melusine', 'enfaillite', '20001012', '3', 'représentant', '31', 25000, 10);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (12, 'eurktumeme', 'odile', '20001101', '3', 'représentant', '32', 26000, 12);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (13, 'hotdeugou', 'olaf', '20001121', '3', 'représentant', '33', 27000, 10);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (14, 'odlavieille', 'pacome', '20001211', '3', 'représentant', '34', 25000, 15);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (15, 'amartakaldire', 'quentin', '20001221', '3', 'représentant', '35', 23000, 17);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (16, 'traibien', 'samira', '20001231', '6', 'secrétaire', '41', 15000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (17, 'fonfec', 'sophie', '20010110', '6', 'secrétaire', '41', 14000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (18, 'fairent', 'teddy', '20010120', '7', 'secrétaire', '42', 13000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (19, 'blaireur', 'terry', '20010209', '7', 'secrétaire', '42', 13000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (20, 'ajerre', 'tex', '20010209', '8', 'secrétaire', '43', 13000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (21, 'chmonfisse', 'thierry', '20010219', '8', 'secrétaire', '43', 12000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (22, 'phototetedemort', 'thomas', '20010219', '9', 'secrétaire', '44', 22500, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (23, 'kaecoute', 'xavier', '20010301', '9', 'secrétaire', '34', 11500, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (24, 'adrouille-toutltan', 'yves', '20010311', '10', 'secrétaire', '45', 11000, NULL);
INSERT INTO  employe  ( noemp ,  nom ,  prenom ,  dateemb ,  nosup ,  titre ,  nodep ,  salaire ,  tauxcom ) VALUES (25, 'anchier', 'yvon', '20010321', '10', 'secrétaire', '45', 10000, NULL);

-- ---------------------------------------------------------------------------------------------------------------------------
-- EXERCICE PHASE 1 - LA BASE EXEMPLE  - PARTIE 1 ----------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

-- 1. Afficher toutes les informations concernant les employés --------------------------------------------------------------

SELECT *
FROM employe;

-- 2. Afficher toutes les informations concernant les départements ----------------------------------------------------------

SELECT *
FROM dept;

-- 3. Afficher le nom, la date d'embauche, le numéro du supérieur, le numéro de département et le salaire de tous les employés -------------

SELECT nom, dateemb, nosup, nodep, salaire
FROM employe;

-- 4. Afficher le titre de tous les employés --------------------------------------------------------------------------------

SELECT nom, titre
FROM employe;

-- 5. Afficher les différentes valeurs des titres des employés --------------------------------------------------------------------------------

SELECT titre
FROM employe
GROUP BY titre ASC;

-- 6. Afficher le nom, le numéro d'employé et le numéro du département des employés dont le titre est « Secrétaire » --------------------------

SELECT nom, noemp, nodep, titre
FROM employe
WHERE titre = 'secrétaire';

-- 7. Afficher le nom et le numéro de département dont le numéro de département est supérieur à 40 --------------------------

SELECT nom, nodep
FROM employe
WHERE nodep > 40;

-- 8. Afficher le nom et le prénom des employés dont le nom est alphabétiquement antérieur au prénom --------------------------

SELECT nom, prenom
FROM employe e
WHERE e.nom < e.prenom;

-- 9. Afficher le nom, le salaire et le numéro du département des employés dont le titre est « Représentant », le numéro de département est 35
-- et le salaire est supérieur à 20000 --------------------------

SELECT nom, titre, salaire, nodep
FROM employe
WHERE titre = 'représentant' AND nodep = 35 AND salaire > 20000;

-- 10.Afficher le nom, le titre et le salaire des employés dont le titre est « Représentant » ou dont le titre est « Président » --------------------------

SELECT nom, titre, salaire 
FROM employe
WHERE titre = 'représentant' OR titre = 'président';

-- 11.Afficher le nom, le titre, le numéro de département, le salaire des employés du département 34, dont le titre est « Représentant » ou « Secrétaire »  --------------------------

SELECT nom, titre, nodep, salaire
FROM employe
WHERE nodep = 34 AND (titre = 'représentant' OR titre = 'secrétaire');

-- 12.Afficher le nom, le titre, le numéro de département, le salaire des employés dont le titre est Représentant, ou dont le titre est Secrétaire 
-- dans le département numéro 34 --------------------------

SELECT nom, titre, nodep, salaire
FROM employe
WHERE titre = 'représentant' OR (titre = 'secrétaire' AND nodep = 34);

-- 13.Afficher le nom, et le salaire des employés dont le salaire est compris entre 20000 et 30000 --------------------------

SELECT nom, salaire
FROM employe
WHERE salaire >= 20000 AND salaire <= 30000;

-- 15.Afficher le nom des employés commençant par la lettre « H » --------------------------

SELECT nom
FROM employe
WHERE nom LIKE 'h%';

-- 16.Afficher le nom des employés se terminant par la lettre « n » --------------------------

SELECT nom
FROM employe
WHERE nom LIKE '%n';

-- 17.Afficher le nom des employés contenant la lettre « u » en 3ème position --------------------------

SELECT nom
FROM employe
WHERE nom LIKE '__u%';

-- 18.Afficher le salaire et le nom des employés du service 41 classés par salaire croissant --------------------------

SELECT salaire, nom, nodep
FROM employe
WHERE nodep = 41
ORDER BY salaire ASC;

-- 19.Afficher le salaire et le nom des employés du service 41 classés par salaire décroissant --------------------------

SELECT salaire, nom, nodep
FROM employe
WHERE nodep = 41
ORDER BY salaire DESC;

-- 20.Afficher le titre, le salaire et le nom des employés classés par titre croissant et par salaire décroissant --------------------------

SELECT titre, salaire, nom
FROM employe
ORDER BY titre ASC, salaire DESC;

-- 21.Afficher le taux de commission, le salaire et le nom des employés classés par taux de commission croissante --------------------------

SELECT tauxcom, salaire, nom
FROM employe
ORDER BY tauxcom ASC;

-- 22.Afficher le nom, le salaire, le taux de commission et le titre des employés dont le taux de commission n'est pas renseigné --------------------------

SELECT nom, salaire, tauxcom, titre
FROM employe
WHERE tauxcom IS NULL;

-- 23.Afficher le nom, le salaire, le taux de commission et le titre des employés dont le taux de commission est renseigné --------------------------

SELECT nom, salaire, tauxcom, titre
FROM employe
WHERE tauxcom IS NOT NULL;

-- 24.Afficher le nom, le salaire, le taux de commission, le titre des employés dont le taux de commission est inférieur à 15 --------------------------

SELECT nom, salaire, tauxcom, titre
FROM employe
WHERE tauxcom < 15;

-- 25. Afficher le nom, le salaire, le taux de commission, le titre des employés dont le taux de commission est supérieur à 15 --------------------------

SELECT nom, salaire, tauxcom, titre
FROM employe
WHERE tauxcom > 15;

-- 26.Afficher le nom, le salaire, le taux de commission et la commission des employés dont le taux de commission n'est pas nul 
-- (la commission est calculée en multipliant le salaire par le taux de commission) --------------------------

SELECT nom, salaire, tauxcom, (salaire * tauxcom) AS 'commission'
FROM employe
WHERE tauxcom IS NOT NULL;

-- 27. Afficher le nom, le salaire, le taux de commission, la commission des employés dont le taux de commission n'est pas nul, 
-- classé par taux de commission croissant --------------------------

SELECT nom, salaire, tauxcom, (salaire * tauxcom) AS 'commission'
FROM employe
WHERE tauxcom IS NOT NULL
ORDER BY tauxcom ASC;

-- 28. Afficher le nom et le prénom (concaténés) des employés. Renommer les colonnes --------------------------

SELECT CONCAT (prenom, ' ', nom) AS 'Employé'
FROM employe;

-- 29. Afficher les 5 premières lettres du nom des employés --------------------------

SELECT nom, SUBSTRING(nom, 1, 5) AS 'Les 5 premières lettres'
FROM employe;

-- 30. Afficher le nom et le rang de la lettre « r » dans le nom des employés --------------------------

SELECT nom, LOCATE('r', nom) AS 'Rang de la lettre \"r\"'
FROM employe;

-- 31. Afficher le nom, le nom en majuscule et le nom en minuscule de l'employé dont le nom est Vrante --------------------------

SELECT nom AS 'Nom', UPPER(nom) AS 'Nom en majuscules', LOWER(nom) AS 'Nom en minuscule'
FROM employe
WHERE nom = 'vrante';

-- 32. Afficher le nom et le nombre de caractères du nom des employés --------------------------

SELECT nom AS 'Nom', LENGTH(nom) AS 'Nombre de caractères dans le nom'
FROM employe;

-- ---------------------------------------------------------------------------------------------------------------------------
-- EXERCICE PHASE 1 - LA BASE EXEMPLE  - PARTIE 2 ----------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

-- Rechercher le prénom des employés et le numéro de la région de leur département --------------------------

SELECT e.nom, prenom, noregion
FROM employe e
JOIN dept d ON e.nodep = d.nodept;

-- Rechercher le numéro du département, le nom du département, le nom des employés classés par numéro de département (renommer les tables utilisées) --------------------------

SELECT d.nodept AS 'Numéro de département', d.nom AS 'Nom de département', e.nom AS 'Nom de l\'employé'
FROM employe e
JOIN dept d ON e.nodep = d.nodept
ORDER BY d.nodept ASC;

-- Rechercher le nom des employés du département Distribution --------------------------

SELECT d.nom AS 'Nom de département', e.nom AS 'Nom de l\'employé'
FROM employe e
JOIN dept d ON e.nodep = d.nodept
WHERE d.nom = 'distribution'
GROUP BY e.nom ASC;

-- Rechercher le nom et le salaire des employés qui gagnent plus que leur patron, et le nom et le salaire de leur patron --------------------------

SELECT e.nom AS 'Nom employé', e.salaire AS 'Salaire employé', patron.nom AS 'Nom patron', patron.salaire AS 'Salaire patron'
FROM employe e
JOIN employe patron ON e.nosup = patron.noemp
WHERE e.salaire > patron.salaire;

-- Rechercher le nom et le titre des employés qui ont le même titre que Amartakaldire --------------------------

SELECT nom, titre
FROM employe
WHERE titre = (
	SELECT titre
	FROM employe
	WHERE nom = 'amartakaldire'
	);

-- Rechercher le nom, le salaire et le numéro de département des employés qui gagnent plus qu'un seul employé du département 31, 
-- classés par numéro de département et salaire --------------------------

SELECT nom, salaire, nodep
FROM employe
WHERE salaire > MAX((
	SELECT salaire
	FROM employe
	WHERE nodep = 31
));

-- Rechercher le nom, le salaire et le numéro de département des employés qui gagnent plus qu'un seul employé du département 31,
-- classés par numéro de département et salaire -------------------------------------------------------------------------------------

SELECT nom, salaire, nodep
FROM employe
WHERE salaire > (
    SELECT MIN(salaire)
    FROM employe
    WHERE nodep = 31
);

-- OU --

SELECT nom, salaire, nodep
FROM employe
WHERE salaire > ANY(
    SELECT salaire
    FROM employe
    WHERE nodep = 31
);

-- Rechercher le nom, le salaire et le numéro de département des employés qui gagnent plus qu'un seul employé du département 31,
-- classés par numéro de département et salaire -------------------------------------------------------------------------------------

SELECT nom, salaire, nodep
FROM employe
WHERE salaire > (
    SELECT MAX(salaire)
    FROM employe
    WHERE nodep = 31
);

-- OU --

SELECT nom, salaire, nodep
FROM employe
WHERE salaire > ALL(
    SELECT salaire
    FROM employe
    WHERE nodep = 31
);

-- Rechercher le nom et le titre des employés du service 31 qui ont un titre que l'on trouve dans le département 32 -----------------------------------

SELECT nom, titre
FROM employe
WHERE nodep = 31 AND titre = (
    SELECT DISTINCT titre 
    FROM employe
    WHERE nodep = 31
	INTERSECT
	SELECT DISTINCT titre 
    FROM employe
    WHERE nodep = 32
    );

-- Rechercher le nom et le titre des employés du service 31 qui ont un titre l'on ne trouve pas dans le département 32 -----------------------------------

SELECT nom, titre
FROM employe
WHERE nodep = 31 AND titre = (
    SELECT DISTINCT titre 
    FROM employe
    WHERE nodep = 31
	EXCEPT
	SELECT DISTINCT titre 
    FROM employe
    WHERE nodep = 32
    );

-- Rechercher le nom, le titre et le salaire des employés qui ont le même titre et le même salaire que Fairent -----------------------------------

SELECT nom, titre, salaire
FROM employe
WHERE titre = (
    SELECT titre
    FROM employe
    WHERE nom = 'fairent'
) AND salaire = (
    SELECT salaire
    FROM employe
    WHERE nom = 'fairent'
);

-- Rechercher le numéro de département, le nom du département, le nom des employés, en affichant aussi les départements dans lesquels
-- il n'y a personne, classés par numéro de département --------------------------------------------------------------------------------------------

SELECT d.nodept AS 'Numéro département', d.nom AS 'Nom département', e.nom AS 'Nom employé'
FROM dept d
LEFT JOIN employe e ON d.nodept = e.nodep    -- ECRIRE "LEFT" DANS LA JOINTURE EST TRES IMPORTANT ICI, il permet d'afficher les départements dans lesquels il n'y a personne --
ORDER BY e.nodep ASC;

-- 1. Calculer le nombre d'employés de chaque titre ------------------------------------------------------------------------------------------------

SELECT DISTINCT titre, COUNT(nom) AS 'Nombre d\'employe'
FROM employe
GROUP BY titre;

-- 2. Calculer la moyenne des salaires et leur somme, par région ------------------------------------------------------------------------------------------------

SELECT noregion, AVG(salaire) AS 'Moyenne des salaires', SUM(salaire) AS 'Somme des salaires'
FROM employe
JOIN dept ON nodep = nodept
GROUP BY noregion;

-- 3. Afficher les numéros des départements ayant au moins 3 employés ------------------------------------------------------------------------------------------------

SELECT nodep, COUNT(nom) AS 'Nombre d\'employés'
FROM employe
GROUP BY nodep
HAVING COUNT(nom) >= 3;

-- 4. Afficher les lettres qui sont l'initiale d'au moins trois employés ------------------------------------------------------------------------------------------------

SELECT SUBSTRING(nom, 1, 1) AS 'Première lettre du nom', COUNT(SUBSTRING(nom, 1, 1)) AS 'Nombre de noms commençant par cette lettre'
FROM employe
GROUP BY SUBSTRING(nom, 1, 1)
HAVING COUNT(nom) >= 3
ORDER BY SUBSTRING(nom, 1, 1) ASC;

-- 5. Rechercher le salaire maximum et le salaire minimum parmi tous les salariés et l'écart entre les deux ------------------------------------------------------------------------------------------------

SELECT MIN(salaire) AS 'Salaire minimum', MAX(salaire) AS 'Salaire maximum', (MAX(salaire) - MIN(salaire)) AS 'Ecart de salaire'
FROM employe;

-- 6. Rechercher le nombre de titres différents ------------------------------------------------------------------------------------------------

SELECT COUNT(DISTINCT titre) AS 'Nombre de titres différents'
FROM employe;

-- 7. Pour chaque titre, compter le nombre d'employés possédant ce titre ------------------------------------------------------------------------------------------------

SELECT titre, COUNT(nom) AS 'Nombre d\'employé(s) possedant ce titre'
FROM employe
GROUP BY titre
ORDER BY titre ASC;

-- 8. Pour chaque nom de département, afficher le nom du département et le nombre d'employés -----------------------------------------------------------------------------

SELECT d.nodept, d.nom, COUNT(e.nom) AS 'Nombre d\'employé(s)'
FROM dept d
LEFT JOIN employe e ON d.nodept = e.nodep
GROUP BY d.nodept;

-- 9. Rechercher les titres et la moyenne des salaires par titre dont la moyenne est supérieure à la moyenne des salaires des Représentants -----------------------------------------------------------------------------

SELECT titre, AVG(salaire) AS 'Moyenne des salaire'
FROM employe
GROUP BY titre
HAVING AVG(salaire) > (
    SELECT AVG(salaire)
    FROM employe
    WHERE titre = 'représentant'
);

-- 10. Rechercher le nombre de salaires renseignés et le nombre de taux de commission renseignés -----------------------------------------------------------------------------

SELECT COUNT(salaire) AS 'Nombre de salaires renseignés', COUNT(tauxcom) AS 'Nombre de taux de commission renseignés'
FROM employe;

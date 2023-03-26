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



-- --------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------
-- VUES ---------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------------------------------
-- Exercice 1 : vues sur la base hotel --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------

-- 1. Afficher la liste des hôtels avec leur station ------------------------------------------------------------------------

DROP VIEW IF EXISTS v_liste_hotels_stations;
CREATE VIEW v_liste_hotels_stations
AS
SELECT hot_id AS 'ID hotel', hot_nom AS 'Nom hotel', sta_id AS 'ID Station', sta_nom AS 'Nom station'
FROM station
JOIN hotel ON sta_id = hot_sta_id
ORDER BY hot_id ASC;

-- 2. Afficher la liste des chambres et leur hôtel --------------------------------------------------------------------------

DROP VIEW IF EXISTS v_liste_chambres_hotels;
CREATE VIEW v_liste_chambres_hotels
AS
SELECT cha_id AS 'ID chambre', cha_numero AS 'Numéro chambre', hot_id AS 'ID hotel', hot_nom AS 'Nom hotel'
FROM hotel
JOIN chambre ON hot_id = cha_hot_id
ORDER BY cha_id;

-- 3. Afficher la liste des réservations avec le nom des clients --------------------------------------------------------------------------

DROP VIEW IF EXISTS v_liste_reservations_clients;
CREATE VIEW v_liste_reservations_clients
AS
SELECT res_id AS 'ID reservation', cli_id AS 'ID client', cli_nom AS 'Nom client'
FROM client
JOIN reservation ON cli_id = res_cli_id
ORDER BY res_id;

-- 4. Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station --------------------------------------------------------

DROP VIEW IF EXISTS v_liste_chambres_hotels_stations;
CREATE VIEW v_liste_chambres_hotels_stations
AS
SELECT cha_id AS 'ID chambre', hot_id AS 'ID hotel', hot_nom AS 'Nom hotel', sta_id AS 'ID Station', sta_nom AS 'Nom station'
FROM station
JOIN hotel ON sta_id = hot_sta_id
JOIN chambre ON hot_id = cha_hot_id
ORDER BY cha_id ASC;

-- 5. Afficher les réservations avec le nom du client et le nom de l’hôtel --------------------------------------------------------

DROP VIEW IF EXISTS v_liste_reservations_clients_hotels;
CREATE VIEW v_liste_reservations_clients_hotels
AS
SELECT res_id AS 'ID reservation', cli_id AS 'ID client', cli_nom AS 'Nom client', hot_id AS 'ID hotel', hot_nom AS 'Nom hotel'
FROM hotel
JOIN chambre ON hot_id = cha_hot_id
JOIN reservation ON cha_id = res_cha_id
JOIN client ON res_cli_id = cli_id
ORDER BY res_id;


-- --------------------------------------------------------------------------------------------------------------------------
-- Exercice 2 : vues sur la base papyrus ------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------

-- 1. v_GlobalCde correspondant à la requête : A partir de la table Ligcom, afficher par code produit, la somme des quantités commandées 
-- et le prix total correspondant : on nommera la colonne correspondant à la somme des quantités commandées, QteTot et le prix total, PrixTot ------------------------

DROP VIEW IF EXISTS v_GlobalCde;
CREATE VIEW v_GlobalCde
AS
SELECT codart AS 'Code produit', SUM(qtecde) AS 'QteTot', SUM(priuni) AS 'PrixTot'
FROM ligcom
GROUP BY codart;

-- 2. v_VentesI100 correspondant à la requête : Afficher les ventes dont le code produit est le I100 (affichage de toutes les colonnes de la table Vente) -------------

DROP VIEW IF EXISTS v_VentesI100;
CREATE VIEW v_VentesI100
AS
SELECT *
FROM vente
WHERE codart = 'I100';

-- 3. A partir de la vue précédente, créez v_VentesI100Grobrigan remontant toutes les ventes concernant le produit I100 et le fournisseur 00120 -------------

DROP VIEW IF EXISTS v_VentesI100Grobrigan;
CREATE VIEW v_VentesI100Grobrigan
AS
SELECT *
FROM vente
WHERE codart = 'I100' AND numfou = 00120;
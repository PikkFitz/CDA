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
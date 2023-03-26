DROP DATABASE IF EXISTS hotel;

CREATE DATABASE hotel; 
USE hotel;

CREATE TABLE station (
	sta_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	sta_nom VARCHAR(50) NOT NULL,
	sta_altitude INT
);

CREATE TABLE hotel (
	hot_id 			INT AUTO_INCREMENT NOT NULL,
	hot_sta_id 		INT NOT NULL,
	hot_nom 		VARCHAR(50) NOT NULL,
	hot_categorie 	INT NOT NULL,
	hot_adresse		VARCHAR(50) NOT NULL,
	hot_ville 		VARCHAR(50) NOT NULL, 
	FOREIGN KEY (hot_sta_id) REFERENCES station(sta_id),
	PRIMARY KEY (hot_id)
);

CREATE TABLE chambre (
	cha_id INT NOT NULL AUTO_INCREMENT ,
	cha_hot_id INT NOT NULL,
	cha_numero INT NOT NULL,
	cha_capacite INT NOT NULL,
	cha_type INT NOT NULL,
	FOREIGN KEY (cha_hot_id) REFERENCES hotel(hot_id),
	PRIMARY KEY (cha_id)
);

CREATE TABLE client (
	cli_id INT NOT NULL AUTO_INCREMENT ,
	cli_nom VARCHAR(50),
	cli_prenom VARCHAR(50),
	cli_adresse VARCHAR(50),
	cli_ville VARCHAR(50),
	PRIMARY KEY (cli_id)
);

CREATE TABLE reservation (
	res_id INT NOT NULL AUTO_INCREMENT,
	res_cha_id INT NOT NULL ,
	res_cli_id INT NOT NULL ,
	res_date DATE NOT NULL,
	res_date_debut DATE NOT NULL,
	res_date_fin DATE NOT NULL,
	res_prix DECIMAL(6,2) NOT NULL,
	res_arrhes DECIMAL(6,2),
	FOREIGN KEY (res_cha_id) REFERENCES chambre(cha_id),
	FOREIGN KEY (res_cli_id) REFERENCES client(cli_id),
	PRIMARY KEY (res_id)
);

INSERT INTO station (sta_id, sta_nom, sta_altitude) 
VALUES 
(1, 'La Montagne', 2500),
(2, 'Le Sud', 200),
(3, 'La Plage', 10);

INSERT INTO hotel (hot_id, hot_sta_id, hot_nom, hot_categorie, hot_adresse, hot_ville) 
VALUES 
(1, 1, 'Le Magnifique', 3, 'rue du bas', 'Pralo'),
(2, 1, 'Hotel du haut', 1, 'rue du haut', 'Pralo'),
(3, 2, 'Le Narval', 3, 'place de la liberation', 'Vonten'),
(4, 2, 'Les Pissenlis', 4, 'place du 14 juillet', 'Bretou'),
(5, 2, 'RR Hotel', 5, 'place du bas', 'Bretou'),
(6, 2, 'La Brique', 2, 'place du haut', 'Bretou'),
(7, 3, 'Le Beau Rivage', 3, 'place du centre', 'Toras');

INSERT INTO chambre (cha_numero, cha_hot_id, cha_capacite, cha_type) 
VALUES 
(001, 1, 2, 1),
(002, 1, 3, 1),
(003, 1, 2, 1),
(101, 1, 1, 1),
(102, 1, 2, 1),
(103, 1, 3, 1),
(201, 1, 2, 1),
(202, 1, 7, 1),
(203, 1, 1, 1),
(001, 2, 2, 1),
(002, 2, 2, 1),
(003, 2, 1, 1),
(101, 2, 2, 1),
(102, 2, 1, 1),
(103, 2, 3, 1),
(201, 2, 2, 1),
(202, 2, 4, 1),
(203, 2, 4, 1),
(001, 3, 3, 1),
(002, 3, 1, 1),
(003, 3, 2, 1),
(101, 3, 2, 1),
(102, 3, 2, 1),
(103, 3, 2, 1),
(201, 3, 2, 1),
(202, 3, 4, 1),
(203, 3, 4, 1),
(001, 4, 4, 1),
(002, 4, 2, 1),
(003, 4, 4, 1),
(101, 4, 1, 1),
(102, 4, 2, 1),
(103, 4, 2, 1),
(201, 4, 2, 1),
(202, 4, 2, 1),
(203, 4, 3, 1),
(001, 5, 3, 1),
(002, 5, 2, 1),
(003, 5, 2, 1),
(101, 5, 1, 1),
(102, 5, 4, 1),
(103, 5, 1, 1),
(201, 5, 2, 1),
(202, 5, 4, 1),
(203, 5, 4, 1),
(001, 6, 1, 1),
(002, 6, 1, 1),
(003, 6, 1, 1),
(101, 6, 1, 1),
(102, 6, 1, 1),
(103, 6, 1, 1),
(201, 6, 1, 1),
(202, 6, 1, 1),
(203, 6, 1, 1),
(001, 7, 1, 1),
(002, 7, 5, 1),
(003, 7, 5, 1),
(101, 7, 5, 1),
(102, 7, 5, 1),
(103, 7, 5, 1),
(201, 7, 5, 1),
(202, 7, 5, 1),
(203, 7, 5, 1);

INSERT INTO client (cli_nom, cli_prenom, cli_adresse, cli_ville) 
VALUES 
('Doe', 'John', '', 'LA'),
('Homme', 'Josh', '', 'Palm Desert'),
('Paul', 'Weller', '', 'Londres'),
('White', 'Jack', '', 'Detroit'),
('Claypool', 'Les', '', 'San Francisco'),
('Squire', 'Chris', '', 'Londres'),
('Wood', 'Ronnie', '', 'Londres');

INSERT INTO reservation (res_cha_id, res_cli_id, res_date, res_date_debut, res_date_fin, res_prix, res_arrhes) 
VALUES 
(1, 1, '2021-01-17', '2021-04-09', '2021-04-13', 2400, 800),
(2, 2, '2021-01-19', '2021-04-09', '2021-04-13', 3400, 100),
(1, 3, '2020-12-26', '2021-02-01', '2021-02-08', 400, 50),
(2, 4, '2021-02-13', '2021-04-01', '2021-04-13', 7200, 1800),
(3, 5, '2021-10-25', '2022-02-05', '2021-02-15', 1400, 450),
(4, 6, '2022-03-03', '2022-04-14', '2022-04-18', 2400, 780),
(4, 6, '2022-01-17', '2022-04-16', '2022-04-26', 500, 80),
(50, 1, '2022-03-18', '2022-04-10', '2022-04-18', 40, 0);


------------ LOT 1 SELECT FROM WHERE AND -------------------------------------------------------------------------------------------------------------------

--01-------- LISTE DES HOTELS ------------------------------------------------------------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom de l’hôtel et la ville -------------------------------------------------------------------------------

SELECT hot_nom, hot_ville
FROM hotel;


--02-------- VILLE DE RESIDENCE ----------------------------------------------------------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom, le prénom et l'adresse du client --------------------------------------------------------------------

SELECT cli_nom, cli_prenom, cli_adresse
FROM client;


--03-------- LISTE DES STATIONS DONT L'ALTITUDE < 1000 -----------------------------------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom de la station et l'altitude --------------------------------------------------------------------------

SELECT sta_nom, sta_altitude
FROM station
WHERE sta_altitude < 1000;


--04-------- LISTE DES CHAMBRES AYANT UNE CAPACITE > 1 -----------------------------------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le numéro de chambre ainsi que la capacité ------------------------------------------------------------------

SELECT cha_numero, cha_capacite
FROM chambre
WHERE cha_capacite > 1;


--05-------- CLIENTS N'HABITANT PAS A LONDRES --------------------------------------------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom du client et la ville --------------------------------------------------------------------------------

SELECT cli_nom, cli_ville
FROM client
WHERE cli_ville != 'Londres';


--06-------- HOTELS SITUES SUR LA VILLE DE BRETOU ET AYANT UNE CATEGORIE > 3 -------------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom de l'hôtel, la ville et la catégorie -----------------------------------------------------------------

SELECT hot_nom, hot_ville, hot_categorie
FROM hotel
WHERE hot_ville = 'Bretou' AND hot_categorie > 3;


------------ LOT 2 JOIN ------------------------------------------------------------------------------------------------------------------------------------

--07-------- LISTE DES HOTELS AVEC LEUR STATION ------------------------------------------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, la catégorie, la ville ---------------------------------------------

SELECT sta_nom, hot_nom, hot_categorie, hot_ville
FROM hotel
JOIN station ON hot_sta_id = sta_id;


--08-------- LISTE DES CHAMBRES ET LEUR HOTEL --------------------------------------------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre ------------------------------------------

SELECT hot_nom, hot_categorie, hot_ville, cha_numero
FROM hotel
JOIN chambre ON hot_id = cha_hot_id;


--09-------- LISTE DES CHAMBRES DE CAPACITE > 1 DANS LES HOTELS DE LA VILLE DE BRETOU ----------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre et sa capacité ---------------------------

SELECT hot_nom, hot_categorie, hot_ville, cha_numero, cha_capacite
FROM hotel
JOIN chambre ON hot_id = cha_hot_id
WHERE hot_ville = 'Bretou' AND cha_capacite > 1;


--10-------- LISTE DES RESERVATIONS AVEC LE NOM DES CLIENTS ------------------------------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de réservation -------------------------------------------------

SELECT cli_nom, hot_nom, res_date
FROM hotel
JOIN chambre ON hot_id = cha_hot_id
JOIN reservation ON cha_id = res_cha_id
JOIN client ON res_cli_id = cli_id;


--11-------- LISTE DES CHAMBRES AVEC LE NOM DE L'HOTEL ET LE NOM DE LA STATION -----------------------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, le numéro de la chambre et sa capacité -----------------------------

SELECT sta_nom, hot_nom, cha_numero, cha_capacite
FROM station
JOIN hotel ON sta_id = hot_sta_id
JOIN chambre ON hot_id = cha_hot_id;


-- UPDATE ----- RESERVATION ----- res_date_fin ----- res_id=5 ----------------------------------------------------------------------------------------------

UPDATE reservation
SET res_date_fin = '2022-02-15'
WHERE res_id = 5;


--12-------- LISTE LES RESERVATIONS AVEC LE NOM DU CLIENT ET LE NOM DE L'HOTEL avec datediff ---------------------------------------------------------------
------------ Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de début du séjour et la durée du séjour -----------------------

SELECT cl.cli_nom AS 'Nom du client', h.hot_nom AS 'Nom de l''hotel', r.res_date_debut AS 'Début du séjour', DATEDIFF (r.res_date_fin, r.res_date_debut) AS 'Durée du séjour'
FROM hotel h
JOIN chambre ch ON h.hot_id = ch.cha_hot_id
JOIN reservation r ON ch.cha_id = r.res_cha_id
JOIN client cl ON r.res_cli_id = cl.cli_id;


------------ LOT 3 FONCTIONS D'AGREGATION ------------------------------------------------------------------------------------------------------------------

--13-------- COMPTER LE NOMBRE D'HOTEL PAR STATION ---------------------------------------------------------------------------------------------------------

SELECT sta_nom AS 'Nom de station', COUNT (hot_id) AS 'Nombre d''hotel'
FROM hotel
JOIN station ON sta_id = hot_sta_id
GROUP BY sta_nom;


--14-------- COMPTER LE NOMBRE DE CHAMBRE PAR STATION ------------------------------------------------------------------------------------------------------

SELECT sta_nom AS 'Nom de station', COUNT (cha_id) as 'Chambre'
FROM station
JOIN hotel ON sta_id = hot_sta_id
JOIN chambre ON hot_id = cha_hot_id
GROUP BY sta_nom
ORDER BY sta_id;


--15--------  Compter le nombre de chambres par station ayant une capacité > 1 -----------------------------------------------------------------------------

SELECT sta_nom AS 'Nom de station', COUNT (cha_id) as 'Chambre'
FROM station
JOIN hotel ON sta_id = hot_sta_id
JOIN chambre ON hot_id = cha_hot_id
WHERE cha_capacite > 1
GROUP BY sta_nom
ORDER BY sta_id;


--16-------- Afficher la liste des hôtels pour lesquels Mr Squire a effectué une réservation ---------------------------------------------------------------

SELECT cli_nom AS 'Nom du client', hot_nom AS 'Nom de l''hotel'
FROM hotel
JOIN chambre ON hot_id = cha_hot_id
JOIN reservation ON cha_id = res_cha_id
JOIN client ON res_cli_id = cli_id
WHERE cli_id = 6


--17-------- Afficher la durée moyenne des réservations par station ----------------------------------------------------------------------------------------

SELECT sta_nom AS 'Nom de la station', ROUND(AVG(DATEDIFF (res_date_fin, res_date_debut)),2) AS 'Durée moyenne du séjour'
FROM station
JOIN hotel h  ON sta_id = hot_sta_id
JOIN chambre ON hot_id = cha_hot_id
JOIN reservation  ON cha_id = res_cha_id
GROUP BY sta_nom;
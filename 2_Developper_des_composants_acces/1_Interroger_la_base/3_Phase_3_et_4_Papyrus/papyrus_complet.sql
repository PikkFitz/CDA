DROP DATABASE IF EXISTS papyrus;

CREATE DATABASE papyrus;

USE papyrus;

-- TABLE FOURNISSEURS ----------------------------------------------------------------------------------------------

CREATE TABLE `fournis` (
  `numfou` int NOT NULL,
  `nomfou` varchar(25) NOT NULL,
  `ruefou` varchar(50) NOT NULL,
  `posfou` char(5) NOT NULL,
  `vilfou` varchar(30) NOT NULL,
  `confou` varchar(15) NOT NULL,
  `satisf` tinyint(4) DEFAULT NULL, 
  CHECK (`satisf` >=0 AND `satisf` <=10),
  PRIMARY KEY (`numfou`)
);

INSERT INTO `fournis` (`numfou`, `nomfou`, `ruefou`, `posfou`, `vilfou`, `confou`, `satisf`) VALUES
	(120, 'GROBRIGAN', '20 rue du papier', '92200', 'Papercity', 'Georges', 8),
	(540, 'ECLIPSE', '53 rue laisse flotter les rubans', '78250', 'Bugbugville', 'Nestor', 7),
	(8700, 'MEDICIS', '120 rue des plantes', '75014', 'Paris', 'Lison', 0),
	(9120, 'DISCOBOL', '11 rue des sports', '85100', 'La Roche sur Yon', 'Hercule', 8),
	(9150, 'DEPANPAP', '26 avenue des locomotives', '59987', 'Coroncountry', 'Pollux', 5),
	(9180, 'HURRYTAPE', '68 boulevard des octets', '78440', 'Dumpville', 'Track', 0),
	(10127, 'FOURNITOU', '30 allée des chaumières', '78440', 'Dumpville', 'Bobby', 3);


-- TABLE PRODUITS --------------------------------------------------------------------------------------------------

CREATE TABLE `produit` (
  `codart` char(4) NOT NULL,
  `libart` varchar(30) NOT NULL,
  `stkale` int(11) NOT NULL,
  `stkphy` int(11) NOT NULL,
  `qteann` int(11) NOT NULL,
  `unimes` char(5) NOT NULL,
  PRIMARY KEY (`codart`)
) ;


INSERT INTO `produit` (`codart`, `libart`, `stkale`, `stkphy`, `qteann`, `unimes`) VALUES
	('B001', 'Bande magnétique 1200', 20, 87, 240, 'unite'),
	('B002', 'Bande magnétique 6250', 20, 12, 410, 'unite'),
	('D035', 'CD R slim 80 mm', 40, 42, 150, 'B010'),
	('D050', 'CD R-W 80mm', 50, 4, 0, 'B010'),
	('I100', 'Papier 1 ex continu', 100, 557, 3500, 'B1000'),
	('I105', 'Papier 2 ex continu', 75, 5, 2300, 'B1000'),
	('I108', 'Papier 3 ex continu', 200, 557, 3500, 'B500'),
	('I110', 'Papier 4 ex continu', 10, 12, 63, 'B400'),
	('P220', 'Pré-imprimé commande', 500, 2500, 24500, 'B500'),
	('P230', 'Pré-imprimé facture', 500, 250, 12500, 'B500'),
	('P240', 'Pré-imprimé bulletin paie', 500, 3000, 6250, 'B500'),
	('P250', 'Pré-imprimé bon livraison', 500, 2500, 24500, 'B500'),
	('P270', 'Pré-imprimé bon fabrication', 500, 2500, 24500, 'B500'),
	('R080', 'ruban Epson 850', 10, 2, 120, 'unite'),
	('R132', 'ruban impl 1200 lignes', 25, 200, 182, 'unite');


-- TABLE ENTREES DE COMMANDES --------------------------------------------------------------------------------------

CREATE TABLE `entcom` (
  `numcom` int(11) NOT NULL AUTO_INCREMENT,
  `obscom` varchar(50) DEFAULT NULL,
  `datcom` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `numfou` int(11) DEFAULT NULL,
  PRIMARY KEY (`numcom`),
  KEY `numfou` (`numfou`),
  CONSTRAINT `entcom_ibfk_1` FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`)
);


INSERT INTO `entcom` (`numcom`, `obscom`, `datcom`, `numfou`) VALUES
	(70010, '', '2018-04-23 15:59:51', 120),
	(70011, 'Commande urgente', '2020-05-21 17:32:43', 540),
	(70020, '', '2020-12-14 08:57:09', 9120),
	(70025, 'Commande urgente', '2021-04-13 16:17:45', 9150),
	(70210, 'Commande cadencée', '2021-06-05 10:40:05', 120),
	(70250, 'Commande cadencée', '2021-08-02 09:19:46', 8700),
	(70300, '', '2021-10-31 14:03:52', 9120),
	(70620, '', '2021-10-31 15:24:17', 540),
	(70625, '', '2022-02-19 13:07:33', 120),
	(70629, '', '2022-04-02 19:58:16', 9180);


-- TABLE LIGNES DE COMMANDES ---------------------------------------------------------------------------------------

CREATE TABLE `ligcom` (
  `numlig` tinyint(4) NOT NULL,
  `numcom` int(11) NOT NULL,
  `codart` char(4) NOT NULL,
  `qtecde` int(11) NOT NULL,
  `priuni` decimal(5,0) NOT NULL,
  `qteliv` int(11) DEFAULT NULL,
  `derliv` date NOT NULL,
  PRIMARY KEY (`numcom`,`codart`),
  KEY `codart` (`codart`),
  CONSTRAINT `ligcom_ibfk_1` FOREIGN KEY (`numcom`) REFERENCES `entcom` (`numcom`),
  CONSTRAINT `ligcom_ibfk_2` FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
);


INSERT INTO `ligcom` (`numcom`, `numlig`, `codart`, `qtecde`, `priuni`, `qteliv`, `derliv`) VALUES
	(70010, 1, 'I100', 3000, 470, 3000, '2018-04-15'),
	(70010, 2, 'I105', 2000, 485, 2000, '2018-07-05'),
	(70010, 3, 'I108', 1000, 680, 1000, '2018-08-20'),
	(70010, 4, 'D035', 200, 40, 250, '2018-08-20'),
	(70010, 5, 'P220', 6000, 3500, 6000, '2018-08-31'),
	(70010, 6, 'P240', 6000, 2000, 2000, '2018-08-31'),
	(70011, 1, 'I105', 1000, 600, 1000, '2020-05-26'),
	(70011, 2, 'P220', 10000, 3500, 10000, '2020-05-31'),
	(70020, 1, 'B001', 200, 140, 0, '2020-12-31'),
	(70020, 2, 'B002', 200, 140, 0, '2020-12-31'),
	(70025, 1, 'I100', 1000, 590, 1000, '2021-04-15'),
	(70025, 2, 'I105', 500, 590, 500, '2021-05-16'),
	(70210, 1, 'I100', 1000, 470, 1000, '2021-06-13'),
	(70250, 1, 'P230', 15000, 4900, 12000, '2021-08-18'),
	(70250, 2, 'P220', 10000, 3350, 10000, '2021-09-08'),
	(70300, 1, 'I100', 50, 790, 50, '2021-11-08'),
	(70620, 1, 'I105', 200, 600, 200, '2021-11-08'),
	(70625, 1, 'I100', 1000, 470, 1000, '2022-10-15'),
	(70625, 2, 'P220', 10000, 3500, 10000, '2022-03-03'),
	(70629, 1, 'B001', 200, 140, 0, '2022-04-21'),
	(70629, 2, 'B002', 200, 140, 0, '2022-04-21');


-- TABLE VENTES ----------------------------------------------------------------------------------------------------

CREATE TABLE `vente` (
  `codart` char(4) NOT NULL,
  `numfou` int(11) NOT NULL,
  `delliv` smallint(6) NOT NULL,
  `qte1` int(11) NOT NULL,
  `prix1` decimal(5,0) NOT NULL,
  `qte2` int(11) DEFAULT NULL,
  `prix2` decimal(5,0) DEFAULT NULL,
  `qte3` int(11) DEFAULT NULL,
  `prix3` decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (`codart`,`numfou`),
  KEY `numfou` (`numfou`),
  CONSTRAINT `vente_ibfk_1` FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`),
  CONSTRAINT `vente_ibfk_2` FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
) ;


INSERT INTO `vente` (`codart`, `numfou`, `delliv`, `qte1`, `prix1`, `qte2`, `prix2`, `qte3`, `prix3`) VALUES
	('B001', 8700, 15, 0, 150, 50, 145, 100, 140),
	('B002', 8700, 15, 0, 210, 50, 200, 100, 185),
	('D035', 120, 0, 0, 40, 0, 0, 0, 0),
	('D035', 9120, 5, 0, 40, 100, 30, 0, 0),
	('I100', 120, 90, 0, 700, 50, 600, 120, 500),
	('I100', 540, 70, 0, 710, 60, 630, 100, 600),
	('I100', 9120, 60, 0, 800, 70, 600, 90, 500),
	('I100', 9150, 90, 0, 650, 90, 600, 200, 590),
	('I100', 9180, 30, 0, 720, 50, 670, 100, 490),
	('I105', 120, 90, 10, 705, 50, 630, 120, 500),
	('I105', 540, 70, 0, 810, 60, 645, 100, 600),
	('I105', 8700, 30, 0, 720, 50, 670, 100, 510),
	('I105', 9120, 60, 0, 920, 70, 800, 90, 700),
	('I105', 9150, 90, 0, 685, 90, 600, 200, 590),
	('I108', 120, 90, 5, 795, 30, 720, 100, 680),
	('I108', 9120, 60, 0, 920, 70, 820, 100, 780),
	('I110', 9120, 60, 0, 950, 70, 850, 90, 790),
	('I110', 9180, 90, 0, 900, 70, 870, 90, 835),
	('P220', 120, 15, 0, 3700, 100, 3500, 0, 0),
	('P220', 8700, 20, 50, 3500, 100, 3350, 0, 0),
	('P230', 120, 30, 0, 5200, 100, 5000, 0, 0),
	('P230', 8700, 60, 0, 5000, 50, 4900, 0, 0),
	('P240', 120, 15, 0, 2200, 100, 2000, 0, 0),
	('P250', 120, 30, 0, 1500, 100, 1400, 500, 1200),
	('P250', 9120, 30, 0, 1500, 100, 1400, 500, 1200),
	('R080', 9120, 10, 0, 120, 100, 100, 0, 0),
	('R132', 9120, 5, 0, 275, 0, 0, 0, 0);


-------------------------------------- EXERCICE SELECT --------------------------------------------------------------------------------------------------------


-- 01 ----- Quelles sont les commandes du fournisseur n°9120 ? -----------------------------------------------------

SELECT f.numfou AS 'Numéro fournisseur', f.nomfou AS 'Nom du fournisseur', l.*
FROM fournis f
JOIN entcom e  ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
WHERE f.numfou = 9120
ORDER BY l.numcom ASC;


-- 02 ----- Afficher le code des fournisseurs pour lesquels des commandes ont été passées --------------------------

SELECT numfou AS 'Numéro fournisseur', numcom AS 'Numéro de commande'
FROM entcom;


-- 03 ----- Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés ------------

SELECT COUNT (numcom) AS 'Nombre de commandes passées', COUNT (DISTINCT numfou) AS 'Nombre de fournisseurs concernés'
FROM entcom;


-- 04 ----- Extraire les produits ayant un stock inférieur ou égal au stock d'alerte, et dont la quantité annuelle est inférieure à 1000 -
----------- Informations à fournir : n° produit, libellé produit, stock actuel, stock d'alerte, quantité annuelle) -

SELECT codart AS 'Code de l''article', libart AS 'Libellé du produit', stkphy AS 'Stock actuel', stkale AS 'stock d''alerte', qteann AS 'Quantité annuelle'
FROM produit
WHERE stkphy <= stkale AND qteann < 1000
ORDER BY codart;


-- 05 ----- Quels sont les fournisseurs situés dans les départements 75, 78, 92, 77 ? ------------------------------
----------- L’affichage (département, nom fournisseur) sera effectué par département décroissant, puis par ordre alphabétique -

SELECT posfou AS 'Code postal', nomfou AS 'Nom du fournisseur'
FROM fournis
WHERE posfou LIKE '75%' OR posfou LIKE'78%' OR posfou LIKE '92%' OR posfou LIKE'77%'
ORDER BY posfou DESC, nomfou ASC;


-- 06 ----- Quelles sont les commandes passées en mars et en avril ? -----------------------------------------------

SELECT numcom AS 'Numéro de commande', datcom AS 'Date de commande'
FROM entcom
WHERE datcom LIKE '%-03-%' OR datcom LIKE '%-04-%'
ORDER BY datcom ASC;


-- 07 ----- Quelles sont les commandes du jour qui ont des observations particulières ? ----------------------------
----------- Afficher numéro de commande et date de commande --------------------------------------------------------

SELECT numcom AS 'Numéro de commande', obscom 'Observation'
FROM entcom
WHERE obscom != '' OR obscom != NULL
ORDER BY numcom ASC;


-- 08 ----- Lister le total de chaque commande par total décroissant -----------------------------------------------
----------- Afficher numéro de commande et total -------------------------------------------------------------------

SELECT numcom AS 'Numéro de commande', SUM (qtecde * priuni) AS 'Total'
FROM ligcom
GROUP BY numcom
ORDER BY Total DESC;


-- 09 ----- Lister les commandes dont le total est supérieur à 10000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure ou égale à 1000 -
----------- Afficher numéro de commande et total -------------------------------------------------------------------

SELECT numcom AS 'Numéro de commande', SUM (qtecde * priuni) AS 'Total'
FROM ligcom
WHERE qtecde < 1000
GROUP BY numcom
HAVING Total > 10000
ORDER BY numcom ASC;

-- OU --

SELECT *
FROM (
	SELECT numcom, SUM (qtecde * priuni) AS 'total'
	FROM ligcom
	WHERE qtecde < 1000
	GROUP BY numcom ASC
) AS `calcul`
GROUP BY numcom ASC
HAVING total > 10000
ORDER BY numcom ASC;


-- 10 ----- Lister les commandes par nom de fournisseur ------------------------------------------------------------
----------- Afficher nom du fournisseur, numéro de commande et date ------------------------------------------------

SELECT nomfou AS 'Nom du fournisseur', numcom AS 'Numéro de commande', datcom AS 'Date de la commande'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
ORDER BY numcom ASC;


-- 11 ----- Sortir les produits des commandes ayant le mot "urgent' en observation ---------------------------------
----------- Afficher numéro de commande, nom du fournisseur, libellé du produit et sous total (= quantité commandée * prix unitaire) -

SELECT e.numcom AS 'Numéro de commande', f.nomfou AS 'Nom du fournisseur', p.libart AS 'Libellé du produit', SUM (l.qtecde * l.priuni) AS "Sous-total"
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
JOIN produit p ON l.codart = p.codart
WHERE e.obscom LIKE "%urgent%"
GROUP BY e.numcom;


-- 12 ----- Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article -

SELECT f.nomfou AS 'Nom du fournisseur', e.numcom AS 'Numéro de commande', l.numlig AS 'Numéro de ligne', l.qteliv AS 'Quantité livrée'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
WHERE l.qteliv > 0
ORDER BY e.numcom ASC, l.numlig ASC;

-- OU --

SELECT f.nomfou AS 'Nom du fournisseur', l.numcom AS 'Numéro de commande', l.numlig AS 'Numéro de ligne', l.qteliv AS 'Quantité livrée'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
WHERE l.numcom IN (
	SELECT numcom
	FROM ligcom
	WHERE qteliv > 0
)
ORDER BY e.numcom ASC, l.numlig ASC;

-- OU (JUSTE LE NOM DES FOURNISSEURS) --

SELECT f.nomfou AS 'Nom du fournisseur'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
WHERE l.numcom IN (
	SELECT numcom
	FROM ligcom
	WHERE qteliv > 0
)
GROUP BY f.nomfou;


-- 13 ----- Coder de 2 manières différentes la requête suivante : Lister les commandes dont le fournisseur est celui de la commande n°70210 -
----------- Afficher numéro de commande et date --------------------------------------------------------------------

SELECT numcom AS 'Numéro de commande', datcom AS 'Date de la commande'
FROM entcom
WHERE numfou IN (
	SELECT numfou
	FROM entcom
	WHERE numcom = 70210
)
ORDER BY numcom ASC;

-- OU -- A REVOIR SANS UTILISER LE NUMERO DU FOURNISSEUR MAIS LE NUMERO DE COMMANDE !!! -- COMME CI-DESSUS -

SELECT numcom AS 'Numéro de commande', datcom AS 'Date de la commande'
FROM entcom
WHERE numfou = 120
ORDER BY numcom ASC;


-- 14 ----- Dans les articles susceptibles d’être vendus, lister les articles moins chers (basés sur Prix1) que le moins cher des rubans (article dont le premier caractère commence par R) -
----------- Afficher libellé de l’article et prix1 -----------------------------------------------------------------

SELECT p.libart AS 'libellé de l''article', v.prix1 AS 'Prix'
FROM produit p
JOIN vente v ON p.codart = v.codart
WHERE v.prix1 < (
	SELECT MIN (prix1)
	FROM vente
	WHERE codart LIKE "R%"
)
GROUP BY p.libart;


-- 15 ----- Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte -
----------- La liste sera triée par produit puis fournisseur -------------------------------------------------------

SELECT p.libart AS 'Libellé du produit', f.nomfou AS 'Nom du fournisseur'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
JOIN produit p ON l.codart = p.codart
WHERE l.qteliv > 0 AND p.stkphy <= (1.5*p.stkale)
ORDER BY p.libart ASC, f.nomfou ASC;


-- 16 ----- Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte, et un délai de livraison d'au maximum 30 jours -
----------- La liste sera triée par fournisseur puis produit -------------------------------------------------------

SELECT p.libart AS 'Libellé du produit', f.nomfou AS 'Nom du fournisseur'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
JOIN produit p ON l.codart = p.codart
JOIN vente v ON p.codart = v.codart
WHERE l.qteliv > 0 AND p.stkphy <= (1.5*p.stkale) AND v.delliv <= 30
ORDER BY p.libart ASC, f.nomfou ASC;


-- 17 ----- Avec le même type de sélection que ci-dessus, sortir un total des stocks par fournisseur, triés par total décroissant -

SELECT p.codart AS 'Code article', p.libart AS 'Libellé du produit', f.nomfou AS 'Nom du fournisseur', SUM (p.stkphy) AS 'Total'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
JOIN produit p ON l.codart = p.codart
JOIN vente v ON p.codart = v.codart
WHERE l.qteliv > 0 AND p.stkphy <= (1.5*p.stkale) AND v.delliv <= 30
GROUP BY f.nomfou
ORDER BY Total DESC;


-- 18 ----- En fin d'année, sortir la liste des produits dont la quantité réellement commandée dépasse 90% de la quantité annuelle prévue -

SELECT p.codart AS 'Code article', p.libart AS 'Libellé de l''article', SUM(l.qtecde) AS 'Quantité_commandée', p.qteann AS 'Quantité annuelle'
FROM ligcom l
JOIN produit p ON l.codart = p.codart
GROUP BY l.codart ASC
HAVING Quantité_commandée > (0.9*p.qteann);

-- OU --

SELECT *
FROM (
	SELECT p.codart AS 'Code article', p.libart AS 'Libellé de l''article', SUM(l.qtecde) AS 'Quantité_commandée', p.qteann AS 'Quantité annuelle'
	FROM ligcom l
	JOIN produit p ON l.codart = p.codart
	GROUP BY l.codart ASC
	HAVING Quantité_commandée > (0.9*p.qteann)
) AS `calcul`;


-- 19 ----- Calculer le chiffre d'affaire par fournisseur pour l'année 2018, sachant que les prix indiqués sont hors taxes et que le taux de TVA est 20% -

SELECT f.numfou AS'Numéro fournisseur', f.nomfou AS 'Nom du fournisseur', SUM ((l.qtecde * l.priuni)*0.80) AS 'Chiffre d''affaire'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
WHERE e.datcom LIKE '2018%'
GROUP BY f.numfou;




-------------------------------------- EXERCICE UPDATE / DELETE --------------------------------------------------------------------------------------------------------

-- 01 ----- Appliquer une augmentation de tarif de 4% pour le prix 1, et de 2% pour le prix2, pour le fournisseur 9180 -

UPDATE vente
SET prix1 = prix1 * 1.04, prix2 = prix2 * 1.02
WHERE numfou = 9180;


-- 02 ----- Dans la table vente, mettre à jour le prix2 des articles dont le prix2 est nul, en affectant la valeur du prix1 -

UPDATE vente
SET prix2 = prix1
WHERE prix2 = 0;


-- 03 ----- Mettre à jour le champ obscom, en renseignant ***** pour toutes les commandes dont le fournisseur a un indice de satisfaction inférieur à 5 -

UPDATE entcom e
JOIN fournis f ON e.numfou = f.numfou
SET obscom = '*****'
WHERE satisf < 5;


-- 04 ----- Supprimer le produit "I110" -

DELETE FROM vente
WHERE codart = 'I110';

DELETE FROM produit
WHERE codart = 'I110';
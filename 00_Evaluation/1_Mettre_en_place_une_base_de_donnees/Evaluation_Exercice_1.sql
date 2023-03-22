DROP DATABASE IF EXISTS Evaluation_Creation_BDD_Exercice_1;

CREATE DATABASE Evaluation_Creation_BDD_Exercice_1;

USE Evaluation_Creation_BDD_Exercice_1;

-- TABLE CLIENT ----------------------------------------------------------------------------------------------

CREATE TABLE `Client` (
  `cli_num` int NOT NULL,
  `cli_nom` varchar(50) NOT NULL,
  `cli_adresse` varchar(50) NOT NULL,
  `cli_tel` varchar(30),
  PRIMARY KEY (`cli_num`)
);

INSERT INTO `Client` (`cli_num`, `cli_nom`, `cli_adresse`, `cli_tel`) 
VALUES
	(1, 'nom_client_1', 'adresse_client_1', 'tel_client_1');

-- TABLE COMMANDE ----------------------------------------------------------------------------------------------

CREATE TABLE `Commande` (
  `com_num` int NOT NULL,
  `cli_num` int NOT NULL,
  `com_date` datetime NOT NULL DEFAULT current_timestamp(),
  `com_obs` varchar(50),
  PRIMARY KEY (`com_num`),
  FOREIGN KEY (`cli_num`) REFERENCES `Client` (`cli_num`)
);

INSERT INTO `Commande` (`com_num`, `cli_num`, `com_obs`) 
VALUES
	(1, 1, 'observation_commande_1');

-- TABLE PRODUIT ----------------------------------------------------------------------------------------------

CREATE TABLE `Produit` (
  `pro_num` int NOT NULL,
  `pro_libelle` varchar(50) NOT NULL,
  `pro_description` varchar(50),
  PRIMARY KEY (`pro_num`)
);

INSERT INTO `Produit` (`pro_num`, `pro_libelle`, `pro_description`) 
VALUES
	(1, 'libelle_produit_1', 'description_produit_1');

-- TABLE EST_COMPOSE ----------------------------------------------------------------------------------------------

CREATE TABLE `est_compose` (
  `com_num` int NOT NULL,
  `pro_num` int NOT NULL,
  `est_qte` int NOT NULL,
  PRIMARY KEY (`com_num`, `pro_num`),
  FOREIGN KEY (`com_num`) REFERENCES `Commande` (`com_num`),
  FOREIGN KEY (`pro_num`) REFERENCES `Produit` (`pro_num`)
);

INSERT INTO `est_compose` (`com_num`, `pro_num`, `est_qte`) 
VALUES
	(1, 1, 10);

-- INDEX ----------------------------------------------------------------------------------------------

CREATE UNIQUE INDEX `nom_client` 
ON `Client` (`cli_nom` ASC);

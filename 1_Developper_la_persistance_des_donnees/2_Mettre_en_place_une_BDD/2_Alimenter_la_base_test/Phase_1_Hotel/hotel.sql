DROP DATABASE IF EXISTS hotel;

CREATE DATABASE hotel;

USE hotel;

-- TABLE STATION ----------------------------------------------------------------------------------------------

CREATE TABLE `station` (
  `station_num` int NOT NULL AUTO_INCREMENT,
  `station_nom` varchar(255) NOT NULL,
  PRIMARY KEY (`station_num`)
);

INSERT INTO `station` (`station_num`, `station_nom`)
VALUES
	(1, 'nom_station_1'),
  (2, 'nom_station_2'),
	(3, 'nom_station_3');

-- TABLE HOTEL ----------------------------------------------------------------------------------------------

CREATE TABLE `hotel` (
  `hotel_num` int NOT NULL AUTO_INCREMENT,
  `hotel_nom` varchar(255),
  `hotel_adresse` varchar(255),
  `hotel_categorie` varchar(255),
  `hotel_capacite` int,
  `station_num` int,
  PRIMARY KEY (`hotel_num`),
  FOREIGN KEY (`station_num`) REFERENCES `station` (`station_num`)
);

INSERT INTO `hotel` (`hotel_num`, `hotel_nom`, `hotel_adresse`, `hotel_categorie`, `hotel_capacite`, `station_num`)
VALUES
	(1, 'nom_hotel_1', 'adresse_hotel_1', 'categorie_hotel_1', 100, 1),
  (2, 'nom_hotel_2', 'adresse_hotel_2', 'categorie_hotel_2', 200, 2),
	(3, 'nom_hotel_3', 'adresse_hotel_3', 'categorie_hotel_3', 300, 3);

-- TABLE CHAMBRE ----------------------------------------------------------------------------------------------

CREATE TABLE `chambre` (
  `chambre_num` int NOT NULL AUTO_INCREMENT,
  `chambre_capacite` int,
  `chambre_degreConfort` varchar(255),
  `chambre_type` varchar(255),
  `chambre_exposition` varchar(255),
  `hotel_num` int,
  PRIMARY KEY (`chambre_num`),
  FOREIGN KEY (`hotel_num`) REFERENCES `hotel` (`hotel_num`)
);

INSERT INTO `chambre` (`chambre_num`, `chambre_capacite`, `chambre_degreConfort`, `chambre_type`, `chambre_exposition`, `hotel_num`)
VALUES
	(1, 2, 'confort_chambre_1', 'type_chambre_1', 'exposition_chambre_1', 1),
  (2, 2, 'confort_chambre_2', 'type_chambre_2', 'exposition_chambre_2', 2),
	(3, 1, 'confort_chambre_3', 'type_chambre_3', 'exposition_chambre_3', 2);

-- TABLE CLIENT ----------------------------------------------------------------------------------------------

CREATE TABLE `client` (
  `client_num` int NOT NULL AUTO_INCREMENT,
  `client_nom` varchar(255),
  `client_prenom` varchar(255),
  `client_adresse` varchar(255),
  PRIMARY KEY (`client_num`)
);

-- TABLE RESERVATION ----------------------------------------------------------------------------------------------

CREATE TABLE `reservation` (
  `client_num` int,
  `chambre_num` int,
  `reservation_dateDebut` date,
  `reservation_dateFin` date,
  `reservation_date` datetime NOT NULL DEFAULT current_timestamp(),
  `reservation_montantArrhes` decimal(15,2),
  `reservation_prixTotal` decimal(15,2),
  PRIMARY KEY (`client_num`, `chambre_num`),
  FOREIGN KEY (`client_num`) REFERENCES `client` (`client_num`),
  FOREIGN KEY (`chambre_num`) REFERENCES `chambre` (`chambre_num`)
);
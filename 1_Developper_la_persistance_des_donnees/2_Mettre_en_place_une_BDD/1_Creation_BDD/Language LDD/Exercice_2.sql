DROP DATABASE IF EXISTS Exercice_2;

CREATE DATABASE Exercice_2;

USE Exercice_2;

-- TABLE STATION ----------------------------------------------------------------------------------------------

CREATE TABLE `station` (
  `station_num` int NOT NULL AUTO_INCREMENT,
  `station_nom` varchar(255) NOT NULL,
  PRIMARY KEY (`station_num`)
);

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
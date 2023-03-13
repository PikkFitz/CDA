DROP DATABASE IF EXISTS Exercice_1;

CREATE DATABASE Exercice_1;

USE Exercice_1;

-- TABLE PERSONNE ----------------------------------------------------------------------------------------------

CREATE TABLE `personne` (
  `per_num` int NOT NULL AUTO_INCREMENT,
  `per_nom` varchar(255) NOT NULL,
  `per_prenom` varchar(255) NOT NULL,
  `per_adresse` varchar(100) NOT NULL,
  `per_ville` varchar(50) NOT NULL,
  PRIMARY KEY (`per_num`)
);

-- TABLE GROUPE ----------------------------------------------------------------------------------------------

CREATE TABLE `groupe` (
  `gro_num` int NOT NULL AUTO_INCREMENT,
  `gro_libelle` varchar(255),
  PRIMARY KEY (`gro_num`)
);

-- TABLE APPARTIENT ----------------------------------------------------------------------------------------------

CREATE TABLE `appartient` (
  `per_num` int,
  `gro_num` int,
  PRIMARY KEY (`per_num`, `gro_num`),
  FOREIGN KEY (`per_num`) REFERENCES `personne` (`per_num`),
  FOREIGN KEY (`gro_num`) REFERENCES `groupe` (`gro_num`)
);
DROP DATABASE IF EXISTS papyrus;

CREATE DATABASE papyrus;

USE papyrus;

-- TABLE FOURNISSEURS ----------------------------------------------------------------------------------------------

CREATE TABLE `fournis` (
  `numfou` int NOT NULL,
  `nomfou` varchar(255) NOT NULL,
  `ruefou` varchar(255) NOT NULL,
  `posfou` varchar(5) NOT NULL,
  `vilfou` varchar(255) NOT NULL,
  `confou` varchar(255) NOT NULL,
  `satisf` tinyint(2) CHECK (`satisf` >=1 AND `satisf` <=10),
  PRIMARY KEY (`numfou`)
);

-- TABLE PRODUITS --------------------------------------------------------------------------------------------------

CREATE TABLE `produit` (
  `codart` varchar(255) NOT NULL,
  `libart` varchar(255) NOT NULL,
  `stkale` int NOT NULL,
  `stkphy` int NOT NULL,
  `qteann` int NOT NULL,
  `unimes` varchar(5) NOT NULL,
  PRIMARY KEY (`codart`)
);

-- ENTCOM ----------------------------------------------------------------------------------------------------------

CREATE TABLE `entcom` (
  `numcom` int NOT NULL AUTO_INCREMENT,
  `obscom` varchar(255),
  `datcom` datetime NOT NULL DEFAULT current_timestamp(), -- ON UPDATE current_timestamp()--
  `numfou` int,
  PRIMARY KEY (`numcom`),
  FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`)
);

-- TABLE LIGNES DE COMMANDES ---------------------------------------------------------------------------------------

CREATE TABLE `ligcom` (
  `numlig` int NOT NULL,
  `numcom` int NOT NULL,
  `codart` varchar(255) NOT NULL,
  `qtecde` int NOT NULL,
  `priuni` decimal(15,2) NOT NULL,
  `qteliv` int,
  `derliv` date NOT NULL,
  PRIMARY KEY (`numcom`,`codart`),
  FOREIGN KEY (`numcom`) REFERENCES `entcom` (`numcom`),
  FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
);

-- TABLE VENTES ----------------------------------------------------------------------------------------------------

CREATE TABLE `vente` (
  `codart` varchar(255) NOT NULL,
  `numfou` int NOT NULL,
  `delliv` int NOT NULL,
  `qte1` int NOT NULL,
  `prix1` decimal(15,2) NOT NULL,
  `qte2` int,
  `prix2` decimal(15,2),
  `qte3` int,
  `prix3` decimal(15,2),
  PRIMARY KEY (`codart`,`numfou`),
  FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`),
  FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
) ;

-- INDEX ----------------------------------------------------------------------------------------------

CREATE UNIQUE INDEX `numero_fournisseur` 
ON `entcom` (`numfou` ASC);



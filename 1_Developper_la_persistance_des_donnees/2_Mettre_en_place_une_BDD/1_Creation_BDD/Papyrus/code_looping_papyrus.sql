DROP DATABASE IF EXISTS papyrus_export_looping;

CREATE DATABASE papyrus_export_looping;

USE papyrus_export_looping;

CREATE TABLE fournis(
   numfou INT,
   nomfou VARCHAR(255)  NOT NULL,
   ruefou VARCHAR(255)  NOT NULL,
   posfou VARCHAR(5)  NOT NULL,
   vilfou VARCHAR(255)  NOT NULL,
   satisf TINYINT , CHECK (`satisf` >=1 AND `satisf` <=10),
   PRIMARY KEY(numfou)
);

CREATE TABLE vente(
   codart VARCHAR(255) ,
   numfou INT,
   delliv INT NOT NULL,
   qte1 INT NOT NULL,
   prix1 DECIMAL(15,2)   NOT NULL,
   qte2 INT,
   prix2 DECIMAL(15,2)  ,
   qte3 INT,
   prix3 DECIMAL(15,2)  ,
   PRIMARY KEY(codart, numfou)
);

CREATE TABLE produit(
   codart VARCHAR(255) ,
   libart VARCHAR(255)  NOT NULL,
   stkale INT NOT NULL,
   stkphy INT NOT NULL,
   qteann INT NOT NULL,
   unimes VARCHAR(5)  NOT NULL,
   PRIMARY KEY(codart)
);

CREATE TABLE entcom(
   numcom INT AUTO_INCREMENT,
   obscom VARCHAR(255) ,
   datcom DATETIME NOT NULL DEFAULT current_timestamp(),
   numfou INT,
   numfou_1 INT NOT NULL,
   PRIMARY KEY(numcom),
   FOREIGN KEY(numfou_1) REFERENCES fournis(numfou)
);

CREATE TABLE ligcom(
   numcom INT,
   codart VARCHAR(255) ,
   numlig INT NOT NULL,
   qtecde INT NOT NULL,
   priuni DECIMAL(15,2)   NOT NULL,
   qteliv INT,
   derliv DATE NOT NULL,
   numcom_1 INT NOT NULL,
   PRIMARY KEY(numcom, codart),
   FOREIGN KEY(numcom_1) REFERENCES entcom(numcom)
);

CREATE TABLE fait(
   numfou INT,
   codart VARCHAR(255) ,
   numfou_1 INT,
   PRIMARY KEY(numfou, codart, numfou_1),
   FOREIGN KEY(numfou) REFERENCES fournis(numfou),
   FOREIGN KEY(codart, numfou_1) REFERENCES vente(codart, numfou)
);

CREATE TABLE concerne(
   codart VARCHAR(255) ,
   numfou INT,
   codart_1 VARCHAR(255) ,
   PRIMARY KEY(codart, numfou, codart_1),
   FOREIGN KEY(codart, numfou) REFERENCES vente(codart, numfou),
   FOREIGN KEY(codart_1) REFERENCES produit(codart)
);

CREATE TABLE comprend(
   codart VARCHAR(255) ,
   numcom INT,
   codart_1 VARCHAR(255) ,
   PRIMARY KEY(codart, numcom, codart_1),
   FOREIGN KEY(codart) REFERENCES produit(codart),
   FOREIGN KEY(numcom, codart_1) REFERENCES ligcom(numcom, codart)
);

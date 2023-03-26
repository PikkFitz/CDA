-- Active: 1677670145006@@127.0.0.1@3306@hotel
-- -----------------
-- BDD : hotel -----
-- -----------------

-- VERIFIER QUE LE MOTEUR DE STOCKAGE (ENGINE) EST BIEN InnoDB 
-- SINON POUR CHANGER LE MOTEUR, EXECUTER LA REQUTE SUIVANTE :

-- ALTER TABLE nom_table ENGINE=InnoDB;


-- 1. modif_reservation : interdire la modification des réservations (on autorise l'ajout et la suppression) --------------------------------------

USE hotel;

DROP TRIGGER IF EXISTS modif_reservation;

DELIMITER |

CREATE TRIGGER modif_reservation AFTER UPDATE ON reservation
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'La modification de reservation est interdite';
END|

DELIMITER ;

-- TEST : -----

INSERT INTO client (client_num, client_nom, client_prenom, client_adresse) 
VALUES 
(1, 'nomClient_1', 'prenomClient_1', 'adresseClient_1'),
(2, 'nomClient_2', 'prenomClient_2', 'adresseClient_2'),
(3, 'nomClient_3', 'prenomClient_3', 'adresseClient_3'),
(4, 'nomClient_4', 'prenomClient_4', 'adresseClient_4'),
(5, 'nomClient_5', 'prenomClient_5', 'adresseClient_5'),
(6, 'nomClient_6', 'prenomClient_6', 'adresseClient_6'),
(7, 'nomClient_7', 'prenomClient_7', 'adresseClient_7'),
(8, 'nomClient_8', 'prenomClient_8', 'adresseClient_8'),
(9, 'nomClient_9', 'prenomClient_9', 'adresseClient_9'),
(10, 'nomClient_10', 'prenomClient_10', 'adresseClient_10');

INSERT INTO reservation (client_num, chambre_num, reservation_dateDebut, reservation_dateFin, reservation_date, reservation_montantArrhes, reservation_prixTotal) 
VALUES 
(1, 1, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(2, 2, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(3, 3, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(4, 1, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(5, 2, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(6, 3, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(7, 1, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(8, 2, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(9, 3, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(10, 1, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(1, 2, '2021-04-11', '2021-04-14', '2021-01-19', 800, 2400),
(2, 3, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(3, 1, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400),
(4, 2, '2021-04-10', '2021-04-13', '2021-01-18', 800, 2400),
(5, 3, '2021-04-10', '2021-04-13', '2021-01-18', 800, 2400),
(6, 1, '2021-04-10', '2021-04-13', '2021-01-18', 800, 2400),
(7, 2, '2021-04-11', '2021-04-14', '2021-01-19', 800, 2400),
(8, 3, '2021-04-11', '2021-04-14', '2021-01-19', 800, 2400),
(9, 1, '2021-04-11', '2021-04-14', '2021-01-19', 800, 2400),
(10, 2, '2021-04-11', '2021-04-14', '2021-01-19', 800, 2400);

UPDATE reservation
SET reservation_montantArrhes = 1000
WHERE client_num = 1;


-- 2. insert_reservation : interdire l'ajout de réservation pour les hôtels possédant déjà 10 réservations --------------------------------------

USE hotel;

DROP TRIGGER IF EXISTS insert_reservation;

DELIMITER |

CREATE TRIGGER insert_reservation BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
    DECLARE numeroHotel INT;
    DECLARE nombreReservation INT;
    
    SET numeroHotel = (
        SELECT DISTINCT c.hotel_num 
        FROM chambre c
        JOIN reservation r ON c.chambre_num = r.chambre_num
        WHERE c.chambre_num = NEW.chambre_num
        );

    SET nombreReservation = (
        SELECT COUNT(r.chambre_num) 
        FROM reservation r
        JOIN chambre c ON r.chambre_num = c.chambre_num
        WHERE c.hotel_num = numeroHotel
        );

    IF nombreReservation >= 10 
    THEN
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Maximum de réservations atteint (Nombre de reservations pour cet hotel = 10)';
    END IF;
END|

DELIMITER ;


-- TEST : -----

INSERT INTO reservation
VALUES
(10, 3, '2021-04-11', '2021-04-14', '2021-01-19', 800, 2400);



-- 3. insert_reservation2 : interdire les réservations si le client possède déjà 3 réservations ---------------------------------------------------

USE hotel;

DROP TRIGGER IF EXISTS insert_reservation2;

DELIMITER |

CREATE TRIGGER insert_reservation2 BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN

    DECLARE numeroClient INT;
    DECLARE nombreReservation INT;
    
    SET numeroClient = NEW.client_num;

    SET nombreReservation = (
        SELECT COUNT(client_num) 
        FROM reservation
        WHERE client_num = numeroClient
        );

    IF nombreReservation >= 3 
    THEN
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Maximum de réservations atteint (Nombre de reservations pour ce client = 3)';
    END IF;
END|

DELIMITER ;


-- TEST : -----

INSERT INTO reservation
VALUES
(2, 4, '2021-04-11', '2021-04-14', '2021-01-19', 800, 2400);



-- 4. insert_chambre : lors d'une insertion, on calcule le total des capacités des chambres pour l'hôtel, 
--si ce total est supérieur à 50, on interdit l'insertion de la chambre ------------------------------------------------------------------------------

USE hotel;

DROP TRIGGER IF EXISTS insert_chambre;

DELIMITER |

CREATE TRIGGER insert_chambre BEFORE INSERT ON chambre
FOR EACH ROW
BEGIN

    DECLARE capaciteChambre INT;

    SET capaciteChambre = (
        SELECT SUM(chambre_capacite) 
        FROM chambre
        WHERE hotel_num = NEW.hotel_num
        );

    IF capaciteChambre >= 50
    THEN
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Capacité maximum atteinte (Nombre de reservations pour cet hotel >= 50)';
    END IF;
END|

DELIMITER ;

-- TEST : -----

INSERT INTO chambre
VALUES
(6, 2, 'confort_chambre_5-04-11', 'type_chambre_5', 'exposition_chambre_5', 1);


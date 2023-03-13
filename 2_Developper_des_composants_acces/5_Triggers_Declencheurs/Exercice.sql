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
(1, 'Doe', 'John', 'LA');
INSERT INTO reservation (client_num, chambre_num, reservation_dateDebut, reservation_dateFin, reservation_date, reservation_montantArrhes, reservation_prixTotal) 
VALUES 
(1, 1, '2021-04-09', '2021-04-12', '2021-01-17', 800, 2400);


UPDATE reservation
SET reservation_montantArrhes = 1000
WHERE client_num = 1;


-- 2. insert_reservation : interdire l'ajout de réservation pour les hôtels possédant déjà 10 réservations --------------------------------------

DROP TRIGGER IF EXISTS insert_reservation;

DELIMITER |

CREATE TRIGGER modif_reservation AFTER UPDATE ON reservation
FOR EACH ROW
BEGIN
    DECLARE numeroChambre INT;
    SET numeroChambre = chambre_num;

    DECLARE numeroHotel INT;
    SET numeroHotel = SELECT hotel_num FROM chambre WHERE 

    DECLARE nombreReservation INT;
    SET nombreReservation =







    SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'La modification de reservation est interdite';
END|

DELIMITER ;



-- 3. insert_reservation2 : interdire les réservations si le client possède déjà 3 réservations ---------------------------------------------------






-- 4. insert_chambre : lors d'une insertion, on calcule le total des capacités des chambres pour l'hôtel, 
--si ce total est supérieur à 50, on interdit l'insertion de la chambre ------------------------------------------------------------------------------
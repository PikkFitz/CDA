-- Active: 1677670145006@@127.0.0.1@3306@commande_produit

-- 1. Mettez en place ce trigger, puis ajoutez un produit dans une commande, vérifiez que le champ total est bien mis à jour ------------------------------

USE commande_produit;

DROP TRIGGER IF EXISTS maj_total;

DELIMITER |
CREATE TRIGGER maj_total AFTER INSERT ON lignedecommande
    FOR EACH ROW
    BEGIN

        DECLARE id_c INT;
        DECLARE tot DOUBLE;

        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total

        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande

    END |

DELIMITER ;


-- TEST --

INSERT INTO lignedecommande
VALUES
(1, 4, 1, 5);


-- 2. Ce trigger ne fonctionne que lorsque l'on ajoute des produits dans la commande, 
-- les modifications ou suppressions ne permettent pas de recalculer le total
-- Modifiez le code ci-dessus pour faire en sorte que la modification ou la suppression de produit recalcul le total de la commande ------------
-- ET --
-- 3. Un champ remise était prévu dans la table commande. Prenez en compte ce champ dans le code de votre trigger ------------------------------

USE commande_produit;

DROP TRIGGER IF EXISTS maj_total_insert;

DELIMITER |
CREATE TRIGGER maj_total_insert AFTER INSERT ON lignedecommande 
    FOR EACH ROW
    BEGIN

        DECLARE id_c INT;
        DECLARE tot DOUBLE;

        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (
            SELECT sum((prix*quantite)*((100-remise)/100)) 
            FROM lignedecommande 
            JOIN commande ON id_commande = id
            WHERE id_commande=id_c
            ); -- on recalcul le total

        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande

    END |

DELIMITER ;

-- TEST ----------------------------------

INSERT INTO lignedecommande
VALUES
(1, 5, 3, 5);

-- ---------------------------------------

USE commande_produit;

DROP TRIGGER IF EXISTS maj_total_update;

DELIMITER |
CREATE TRIGGER maj_total_update AFTER UPDATE ON lignedecommande 
    FOR EACH ROW
    BEGIN

        DECLARE id_c INT;
        DECLARE tot DOUBLE;

        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (
            SELECT sum((prix*quantite)*((100-remise)/100)) 
            FROM lignedecommande 
            JOIN commande ON id_commande = id
            WHERE id_commande=id_c
            ); -- on recalcul le total

        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande

    END |

DELIMITER ;

-- TEST -----------------------------------------

UPDATE lignedecommande
SET quantite = 5
WHERE id_commande = 1 AND id_produit = 5;

-- -----------------------------------------------

USE commande_produit;

DROP TRIGGER IF EXISTS maj_total_delete;

DELIMITER |
CREATE TRIGGER maj_total_delete AFTER DELETE ON lignedecommande 
    FOR EACH ROW
    BEGIN

        DECLARE id_c INT;
        DECLARE tot DOUBLE;

        SET id_c = OLD.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (
            SELECT sum((prix*quantite)*((100-remise)/100)) 
            FROM lignedecommande
            JOIN commande ON id_commande = id 
            WHERE id_commande=id_c
            ); -- on recalcul le total

        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande

    END |

DELIMITER ;


-- TEST --------------------------------------

DELETE FROM lignedecommande
WHERE id_commande = 1 AND id_produit = 5;

-- --------------------------------------------

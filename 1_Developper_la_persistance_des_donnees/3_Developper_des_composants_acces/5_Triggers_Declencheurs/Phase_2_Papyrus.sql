-- Active: 1677670145006@@127.0.0.1@3306@papyrus

-- CREATION DE LA TABLE "articles_a_commander" ------------------------------------------------------------

USE papyrus;

CREATE TABLE `articles_a_commander` (
  `codart` varchar(255) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `qte` int NOT NULL,
  FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
);

-- Créer un déclencheur UPDATE sur la table produit : lorsque le stock physique devient inférieur ou égal au stock d'alerte, 
-- une nouvelle ligne est insérée dans la table ARTICLES_A_COMMANDER.

-- Attention, il faut prendre en compte les quantités déjà commandées dans la table ARTICLES_A_COMMANDER .

-- Pour comprendre le problème :

-- Soit l'article I120, le stock d'alerte = 5, le stock physique = 20



-- 1. Nous retirons 15 produits du stock. stock d'alerte = 5, le stock physique = 5, le stock physique n'est pas inférieur au stock d'alerte, on ne fait rien

-- 2. Nous retirons 1 produit du stock. stock d'alerte = 5, le stock physique = 4, le stock physique est inférieur au stock d'alerte, 
-- nous devons recommander des produits. 
-- Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec QTE = (stock alerte - stock physique) = 1

-- 3. Nous retirons 2 produit du stock. stock d'alerte = 5, le stock physique = 2. le stock physique est inférieur au stock d'alerte, 
-- nous devons recommander des produits. Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec 
-- QTE = (stock alerte - stock physique) – quantité déjà commandée dans ARTICLES_A_COMMANDER : QTE = (5 - 2) – 1 = 2*


USE papyrus;

DROP TRIGGER IF EXISTS mise_a_jour_articles_a_commander;

DELIMITER |
CREATE TRIGGER mise_a_jour_articles_a_commander AFTER UPDATE ON produit 
    FOR EACH ROW
    BEGIN

        DECLARE code_article VARCHAR(255);
        DECLARE quantite_deja_commandee INT;
        DECLARE quantite INT;
        

        SET code_article = NEW.codart; -- nous captons le code de l'article concerné

        SET quantite_deja_commandee = (
                SELECT SUM(qte)
                FROM articles_a_commander
                WHERE codart = code_article
                );

        SET quantite = (
            SELECT ((stkale - stkphy) - IFNULL(quantite_deja_commandee, 0))
            FROM produit
            -- JOIN articles_a_commander a ON p.codart = a.codart
            WHERE codart = code_article
            );

        IF NEW.stkphy < NEW.stkale
        THEN
            INSERT INTO `articles_a_commander`(`codart`, `qte`) -- on stocke le total dans la table commande
            VALUES
            (code_article, quantite);
        END IF;

    END |

DELIMITER ;


-- TEST --
USE papyrus;
INSERT INTO `articles_a_commander`(`codart`, `qte`)
VALUES
('B002', 2);


USE papyrus;
UPDATE produit
SET stkphy = 8
WHERE codart = 'I110';

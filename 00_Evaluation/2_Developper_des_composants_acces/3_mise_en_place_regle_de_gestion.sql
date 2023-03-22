-- Pour tenir compte des coûts liés au transport, on vérifiera que pour chaque produit d’une commande, 
-- le client réside dans le même pays que le fournisseur du même produit

-- Il s'agit d'interdire l'insertion de produits dans les commandes ne satisfaisants pas à ce critère.

-- Décrivez par quel moyen et avec quels outils (procédures stockées, trigger...) vous pourriez implémenter la règle de gestion suivante.


USE northwind;

DROP TRIGGER IF EXISTS insert_orders_details_adresse_client_fournisseur;

DELIMITER |

CREATE TRIGGER insert_orders_details_adresse_client_fournisseur BEFORE INSERT ON `order details`
FOR EACH ROW
BEGIN

    DECLARE idCommande INT;
    DECLARE idProduit INT;
    DECLARE paysFournisseur varchar(15);
    DECLARE paysClient varchar(15);

    SET idCommande = NEW.OrderID;
    
    SET idProduit = NEW.ProductID;

    SET paysFournisseur = (
        SELECT s.Country
        FROM suppliers s
        JOIN products p ON s.SupplierID = p.SupplierID
        WHERE p.ProductID = idProduit
        );

    SET paysClient = (
        SELECT DISTINCT c.Country
        FROM customers c
        JOIN orders o ON c.CustomerID = o.CustomerID
        JOIN `order details` od ON o.OrderID = od.OrderID
        WHERE od.OrderID = idCommande
        );

    IF paysClient != paysFournisseur
    THEN
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Insertion interdite (le client et le fournisseur du produit n\'ont pas le même pays de résidence)';
    END IF;
END|

DELIMITER ;



-- TEST NEGATIF -----

USE northwind;
INSERT INTO `order details`(`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`)
VALUES
(10248, 1, 18.000, 8, 0);


-- TEST POSITIF -----

USE northwind;
INSERT INTO `order details`(`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`)
VALUES
(10248, 58, 13.2500, 10, 0);


-- SUPPRESSION DE LA LIGNE AJOUTEE AVEC LE TEST POSITIF -----

DELETE FROM `order details`
WHERE OrderID = 10248 AND ProductID = 58;
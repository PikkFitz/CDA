-- Active: 1677670145006@@127.0.0.1@3306@northwind

-- UPDATES -------------------------------------------------------------------------------------------------------------------------------------

UPDATE products
SET ProductName = 'Sirop d''érable'
WHERE ProductID = 61;

UPDATE suppliers
SET CompanyName = "Gai pâturage"
WHERE SupplierID = 28;

UPDATE suppliers
SET CompanyName = "Gai pâturage"
WHERE SupplierID = 28;

UPDATE suppliers
SET CompanyName = "Forts d'érables"
WHERE SupplierID = 29;

UPDATE customers
SET CompanyName = "Blondesddsl père et fils"
WHERE CustomerID = 'BLONP';

UPDATE customers
SET CompanyName = "Mère Paillarde"
WHERE CustomerID = 'MEREP';

UPDATE customers
SET CompanyName = "Königlich Essen"
WHERE CustomerID = 'KOENE';


-- 1 - Liste des contacts français : ------------------------------------------------------------------------------------------------------------

SELECT CompanyName AS 'Société', ContactName AS 'Contact', ContactTitle AS 'Fonction', Phone AS 'Téléphone'
FROM customers
WHERE Country = 'France'
ORDER BY CompanyName ASC;

-- 2 - Produits vendus par le fournisseur « Exotic Liquids » : ----------------------------------------------------------------------------------

SELECT ProductName AS 'Produit', CAST(UnitPrice as decimal (20, 4)) AS 'Prix'
FROM products p
JOIN suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierID = 1;

-- 3 - Nombre de produits vendus par les fournisseurs Français dans l’ordre décroissant : -------------------------------------------------------

SELECT s.CompanyName AS 'Fournisseur', COUNT(p.ProductName) AS 'Nbre produits'
FROM products p
JOIN suppliers s ON p.SupplierID = s.SupplierID
WHERE s.Country = 'France'
GROUP BY s.CompanyName
ORDER BY `Nbre produits` DESC, s.CompanyName ASC;

-- 4 - Liste des clients Français ayant plus de 10 commandes : ----------------------------------------------------------------------------------

SELECT c.CompanyName AS 'Client', COUNT(DISTINCT o.OrderID) AS 'Nbre commandes'
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'France'
GROUP BY c.CompanyName
HAVING `Nbre commandes` > 10
ORDER BY c.CompanyName ASC;

-- 5 - Liste des clients ayant un chiffre d’affaires > 30.000 : ---------------------------------------------------------------------------------

SELECT c.CompanyName AS 'Client', CAST(SUM(od.UnitPrice * od.Quantity) as decimal (20, 4)) AS 'CA', c.Country AS 'Pays'
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN `order details` od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
HAVING CA > 30000
ORDER BY CA DESC;

-- 6 – Liste des pays dont les clients ont passé commande de produits fournis par « ExoticLiquids » : -------------------------------------------

SELECT o.ShipCountry AS 'Pays'
FROM orders o
JOIN `order details` od ON o.OrderID = od.OrderID
JOIN products p ON od.ProductID = p.ProductID
JOIN suppliers s ON p.SupplierID = s.SupplierID
WHERE s.CompanyName = 'Exotic Liquids'
GROUP BY o.ShipCountry
ORDER BY o.ShipCountry ASC;

-- 7 – Montant des ventes de 1997 : --------------------------------------------------------------------------------------------------------------

SELECT CAST(SUM(od.UnitPrice * od.Quantity) as decimal (20, 4)) AS 'Montant ventes 97'
FROM orders o
JOIN `order details` od ON o.OrderID = od. OrderID
WHERE OrderDate LIKE "1997%";

-- 8 – Montant des ventes de 1997 mois par mois : ------------------------------------------------------------------------------------------------

SELECT MONTH (o.OrderDate) AS 'Mois 97', CAST(SUM(od.UnitPrice * od.Quantity) as decimal (20, 4)) AS 'Montant ventes 97'
FROM orders o
JOIN `order details` od ON o.OrderID = od. OrderID
WHERE OrderDate LIKE "1997%"
GROUP BY `Mois 97`;

-- 9 – Depuis quelle date le client « Du monde entier » n’a plus commandé ? ------------------------------------------------------------------------------------------------

SELECT MAX(o.OrderDate) AS 'Date de dernière commande'
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
WHERE c.CompanyName = 'Du monde entier';

-- 10 – Quel est le délai moyen de livraison en jours ? ------------------------------------------------------------------------------------------

SELECT ROUND(AVG(DATEDIFF(ShippedDate, OrderDate))) AS 'Délai moyen de livraison en jours'
FROM orders;

-- 2 - Codez deux procédures stockées correspondant aux requêtes 9 et 10. Les procédures stockées doivent prendre en compte les éventuels paramètres -----

-- Procédure stockée 1 : Dernière date de commande d'un client  -------------------------------------------------------------

DROP PROCEDURE IF EXISTS `date_derniere_commande_client`;

DELIMITER |

CREATE PROCEDURE date_derniere_commande_client(
   In idClient varchar(5)
   )

BEGIN

SELECT MAX(o.OrderDate) AS 'Date de dernière commande'
FROM `customers` c
JOIN `orders` o ON c.CustomerID = o.CustomerID
WHERE c.CustomerID = idClient;

END |

DELIMITER ;

CALL date_derniere_commande_client('DUMON');


-- Procédure stockée 2 : Délai moyen de livraison d'un client, en jours  ----------------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `delai_livraison_moyenne_client`;

DELIMITER |

CREATE PROCEDURE delai_livraison_moyenne_client(
   In idClient varchar(5)
   )

BEGIN

SELECT ROUND(AVG(DATEDIFF(ShippedDate, OrderDate))) AS 'Délai moyen de livraison en jours'
FROM orders
WHERE CustomerID = idClient;

END |

DELIMITER ;

CALL delai_livraison_moyenne_client('DUMON');


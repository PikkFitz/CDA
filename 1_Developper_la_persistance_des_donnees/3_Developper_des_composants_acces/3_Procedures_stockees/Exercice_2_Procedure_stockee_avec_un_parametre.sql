-- Exercice 2 : création d'une procédure stockée avec un paramètre en entrée --------------------------------------------------------------

-- Créer la procédure stockée Lst_Commandes, qui liste les commandes ayant un libellé particulier dans le champ obscom 
-- (cette requête sera construite à partir de la requête n°11) -----

DROP PROCEDURE IF EXISTS `Lst_Commandes`;

DELIMITER |

CREATE PROCEDURE Lst_Commandes(
   In observation varchar(50)
   )

BEGIN

SELECT e.numcom AS 'Numéro de commande', f.nomfou AS 'Nom du fournisseur', p.libart AS 'Libellé du produit', SUM(l.qtecde * l.priuni) AS "Sous-total", e.obscom AS 'Observation'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
JOIN produit p ON l.codart = p.codart
WHERE e.obscom LIKE observation
GROUP BY e.numcom;

END |

DELIMITER ;

-- Pour exécuter avec une valeur de paramètre :
CALL Lst_Commandes('_%')
